import { getAvailableDates, getAvailableOffices } from './requests.js';
import sleep from '../utils/sleep.js';
import models from '../database/models.js';
import { OFFICE_STATUSES } from './config.js';
import { ExpiredException } from './exceptions.js';

const { Question, DateOffice, Cookie, Office } = models;

class Scraper {
  constructor() {
    this.onAvailable = null;
    this.onSessionExpire = null;
    this.isRunning = false;
  }

  async #scrape(questionId) {
    const cookie = await this.#getCookie();
    const { data } = await getAvailableDates(questionId);
    const dates = data.map(({ date }) => date.slice(0, 10));
    const update = dates.map(async (date) => {
      await sleep(1000);
      return getAvailableOffices(questionId, date, cookie)
        .then((res) => res.map(({ srvCenterId }) => srvCenterId))
        .then((officeIds) => this.#updateStatus(questionId, officeIds, date));
    });
    await Promise.all(update);
  };

  async #getCookie() {
    const { value } = (await Cookie.findByPk(1)).dataValues;
    return value;
  }

  async #getQuestionIds() {
    const questions = await Question.findAll({ attributes: ['id'] });
    return questions.map(({ dataValues }) => dataValues.id);
  }

  async #getOffices() {
    const questions = await Office.findAll({ attributes: ['id'] });
    return questions.map(({ dataValues }) => dataValues.id);
  }

  async #updateStatus(questionId, officeIds, date) {
    const allOffices = await this.#getOffices();
    const available = OFFICE_STATUSES.AVAILABLE;
    const unavailable = OFFICE_STATUSES.UNAVAILABLE;
    const update = allOffices.map(async (officeId) => {
      const options = {
        officeId, questionId, date
      };
      const currentStatus = officeIds.includes(officeId) ? available : unavailable;
      const query = await DateOffice.findOne({
        where: options
      }) ?? await DateOffice.create({ ...options, status: unavailable });
      const record = query.dataValues;
      if (record.status === unavailable && currentStatus === available) {
        await query.update({ status: available });
        this.onAvailable(options);
      }
    });
    await Promise.all(update);
  }

  async #start() {
    this.isRunning = true;
    const questionIds = await this.#getQuestionIds();
    while (true) {
      const search = questionIds.map(async (questionId) => {
        try {
          await this.#scrape(questionId);
        } catch (err) {
          if (err instanceof ExpiredException) throw err;
          throw new Error(`QuestionId: ${questionId}, ${err.message}`);
        }
      });
      const result = await Promise.allSettled(search);
      for (const { reason } of result) {
        if (!reason) continue;
        console.error(reason);
        if (reason instanceof ExpiredException) {
          await this.onSessionExpire(reason);
          this.isRunning = false;
          return;
        }
      }
      await sleep(process.env.REQUEST_TIMEOUT);
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
