import sleep from '../utils/sleep.js';
import { getAvailableDates, getAvailableOffices, getLogInCookie } from './requests.js';
import models from '../database/models.js';
import { OFFICE_STATUSES } from './config.js';
import { ExpiredException } from './exceptions.js';

const { Question, DateOffice, Cookie, Office } = models;

class Scraper {
  constructor() {
    this.onAvailable = null;
    this.adminNotify = null;
    this.isRunning = false;
  }

  async #scrape(questionId) {
    const cookie = await this.#getCookie();
    const { data } = await getAvailableDates(questionId);
    const dates = data.map(({ date }) => date.slice(0, 10));
    const update = dates.map(async (date) => getAvailableOffices(questionId, date, 3, cookie)
      .then((res) => {
        if (res.data.length) return this.#updateStatus(questionId, [3], date);
        else return this.#updateStatus(questionId, [], date);
      })
      .then(() => console.log(`Fetched data successfuly for date: ${date}`))
      .catch((err) => {
        console.log(err);
        if (err instanceof ExpiredException) {
          throw err;
        }
      }));
    return Promise.all(update);
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

  async #setCookie(cookie) {
    return Cookie.update({ value: cookie }, { where: { id: 1 } });
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
    this.adminNotify('🟢 Bot has successfully started');
    console.log('bot started');


    while (true) {
      const questionIds = [49];
      const settledArr = questionIds.map(async (questionId) => this.#scrape(questionId));

      try {
        await Promise.all(settledArr);
      } catch (err) {
        console.log(err);
        const cookie = await getLogInCookie(this.adminNotify);
        console.log(cookie);
        await this.#setCookie(cookie);
      }
      await sleep(process.env.QUERY_TIMEOUT);
    }
  }

  get start() {
    return this.#start.bind(this);
  }
}

export default Scraper;
