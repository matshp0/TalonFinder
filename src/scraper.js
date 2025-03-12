import {  getAvailableDates } from './requests.js';
import sleep from '../utils/sleep.js';
import models from '../database/models.js';
import { OFFICE_STATUS } from './config.js';
import { RedirectException } from './exceptions.js';
import { toDate } from '../utils/date.js';

const { Question, DateOffice, Cookie } = models;

class Scraper {
  constructor() {
    this.onAvailable = null;
    this.onRedirect = null;
    this.isRunning = false;
    this.categoryIds = [49];
    this.officesIds = [3];
  }

  async #scrape(questionId, officeId) {
    const cookiesQuery = (await Cookie.findByPk(1));
    const cookie = cookiesQuery.toJSON().value;
    const { data } = await getAvailableDates(questionId, officeId, cookie);
    for (const { date } of data) {
      const dateString = toDate(date);
      const condition = { officeId, questionId, date: dateString };
      const isAvailable = await this.#updateStatus(condition, OFFICE_STATUS.available);
      if (isAvailable && this.onAvailable) {
        await this.onAvailable(condition);
      }
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
      for (const questionId of this.categoryIds) {
        for (const officeId of this.officesIds) {
          try {
            await this.#scrape(questionId, officeId);
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
