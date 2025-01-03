import { Telegraf } from 'telegraf';
import { message } from 'telegraf/filters';
import { startHandler, onOfficeAdd } from './handlers.js';
import models from '../database/models.js';

const { Account, AccountOffice, AccountQuestion } = models;

export default class NotifierBot extends Telegraf {
  constructor(botToken) {
    super(botToken);
    this.start(startHandler);
    this.command('add_office', onOfficeAdd);
    this.command('add_category', onOfficeAdd);
  }

  async #newTalonNotify(data) {
    const { officeId, date, questionId } = data;
    console.log('Notifying', data);
    const accounts = await Account.findAll({
      include: [
        {
          model: AccountOffice,
          as: 'accountOffices',
          where: { officeId },
          required: true,
        },
        {
          model: AccountQuestion,
          as: 'accountQuestions',
          where: { questionId },
          required: true,
        },
      ],
    });
    const messages = accounts.map(({ dataValues }) => this.telegram.sendMessage(dataValues.id,
      `New talon available for office ${officeId} on ${date} for category ${questionId}`));
    return Promise.allSettled(messages);
  }

  get newTalonNotify() {
    return this.#newTalonNotify.bind(this);
  }
}


