import { Telegraf } from 'telegraf';
import { startHandler,
  onOfficeAdd,
  onCategoryAdd,
  onOffices,
  onCategories,
} from './handlers.js';
import models from '../database/models.js';

const { Account,
  AccountOffice,
  AccountQuestion,
  Office,
  Question, } = models;

export default class NotifierBot extends Telegraf {
  constructor(botToken) {
    super(botToken);
    this.start(startHandler);
    this.command('add_office', onOfficeAdd);
    this.command('add_category', onCategoryAdd);
    this.command('offices', onOffices);
    this.command('categories', onCategories);
  }

  async #newTalonNotify(data) {
    const { officeId, date, questionId } = data;
    console.log('Notifying', data);
    const officeQuery = Office.findByPk(officeId);
    const questionQuery = Question.findByPk(questionId);
    const accountsQuery = Account.findAll({
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
    const [office, accounts, question] = await Promise.all([officeQuery, accountsQuery, questionQuery]);
    const { address } = office.dataValues;
    const { category } = question.dataValues;
    const messages = accounts.map(({ dataValues }) => this.telegram.sendMessage(dataValues.id,
      `✨ Новий талон знайдено за адресою 📍 "${address}" на 📅 ${date} на категорію 🏷️ "${category}" 🎉`));
    return Promise.allSettled(messages);
  }

  get newTalonNotify() {
    return this.#newTalonNotify.bind(this);
  }
}


