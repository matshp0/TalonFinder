import { getStepmap, getAvailableDates } from './requests.js';
import parseDates from '../utils/parseDates.js';
import sleep from '../utils/sleep.js';
import models from '../database/models.js';
import { OFFICE_STATUS } from './config.js';
import { RedirectException } from './exceptions.js';

const { Question, DateOffice, Cookie } = models;

class Scraper {
  constructor() {
    this.questionIds = [];
    this.onAvailable = null;
    this.onRedirect = null;
    this.isRunning = false;
  }

  async #scrape(questionId) {
    const cookiesQuery = (await Cookie.findByPk(1));
    const cookie = cookiesQuery.toJSON().value;
    const html = await getAvailableDates(questionId, cookie);
    const availableDates = parseDates(html);
    for (const date of availableDates) {
      const stepmap = await getStepmap(date, questionId, cookie);
      const notifyArr = stepmap.map(async ({ id_offices: officeId, sts }) => {
        const condition = { officeId, date, questionId };
        const isAvailable = await this.#updateStatus(condition, sts);
        if (isAvailable && this.onAvailable) {
          this.onAvailable(condition);
        }
      });
      const settled = Promise.allSettled(notifyArr);
      await Promise.all([sleep(process.env.REQUEST_TIMEOUT), settled]);
    }
  };

  #isAvailable(status) {
    return status === OFFICE_STATUS.available ||
      status === OFFICE_STATUS.availableOnSite;
  }

  async #setQuestionIds() {
    const query = await Question.findAll();
    this.questionIds = query.map(({ dataValues }) => dataValues.id);
  }

  async #updateStatus(conditions, status) {
    const record = await DateOffice.findOne({
      where: conditions
    });
    let changedStatus = this.#isAvailable(status);
    if (record) {
      if (this.#isAvailable(record.status)) {
        changedStatus = false;
      }
      await record.update({ status });
    } else {
      await DateOffice.create({ ...conditions, status });
    }
    return changedStatus;
  }

  async #start() {
    this.isRunning = true;
    while (true) {
      await this.#setQuestionIds();
      for (const questionId of this.questionIds) {
        try {
          await this.#scrape(questionId);
        } catch (err) {
          if (err instanceof RedirectException) {
            console.log('Redirect detected, notifying admins');
            await this.onRedirect(err);
            this.isRunning = false;
            return;
          } else {
            const errTimeout = parseInt(process.env.ERROR_TIMEOUT, 10) || 1000;
            console.error(`Error: ${err.message}. Retrying in ${errTimeout}ms`);
            await sleep(errTimeout);
          }
        }
      }
    }
  }

  #restart() {
    if (this.isRunning) {
      return;
    }
    this.#start();
  }

  get start() {
    return this.#restart.bind(this);
  }
}

export default Scraper;
