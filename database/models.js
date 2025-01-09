import _sequelize from 'sequelize';
import _Account from  './models/Account.js';
import _AccountOffice from './models/AccountOffice.js';
import _Office from  './models/Office.js';
import { Sequelize } from 'sequelize';
import _DateOffice from './models/DateOffice.js';
import _Question from './models/Question.js';
import _AccountQuestion from './models/AccountQuestion.js';
import _Cookie from './models/Cookie.js';

const { DataTypes } = _sequelize;

function initModels(sequelize) {
  const Account = _Account.init(sequelize, DataTypes);
  const AccountOffice = _AccountOffice.init(sequelize, DataTypes);
  const AccountQuestion = _AccountQuestion.init(sequelize, DataTypes);
  const Cookie = _Cookie.init(sequelize, DataTypes);
  const DateOffice = _DateOffice.init(sequelize, DataTypes);
  const Office = _Office.init(sequelize, DataTypes);
  const Question = _Question.init(sequelize, DataTypes);

  Account.belongsToMany(Office, { as: 'officeIdOffices', through: AccountOffice, foreignKey: 'accountId', otherKey: 'officeId' });
  Account.belongsToMany(Question, { as: 'questionIdQuestions', through: AccountQuestion, foreignKey: 'accountId', otherKey: 'questionId' });
  Office.belongsToMany(Account, { as: 'accountIdAccounts', through: AccountOffice, foreignKey: 'officeId', otherKey: 'accountId' });
  Office.belongsToMany(Question, { as: 'questionIdQuestionDateOffices', through: DateOffice, foreignKey: 'officeId', otherKey: 'questionId' });
  Question.belongsToMany(Account, { as: 'accountIdAccountAccountQuestions', through: AccountQuestion, foreignKey: 'questionId', otherKey: 'accountId' });
  Question.belongsToMany(Office, { as: 'officeIdOfficeDateOffices', through: DateOffice, foreignKey: 'questionId', otherKey: 'officeId' });
  AccountOffice.belongsTo(Account, { as: 'account', foreignKey: 'accountId' });
  Account.hasMany(AccountOffice, { as: 'accountOffices', foreignKey: 'accountId' });
  AccountQuestion.belongsTo(Account, { as: 'account', foreignKey: 'accountId' });
  Account.hasMany(AccountQuestion, { as: 'accountQuestions', foreignKey: 'accountId' });
  AccountOffice.belongsTo(Office, { as: 'office', foreignKey: 'officeId' });
  Office.hasMany(AccountOffice, { as: 'accountOffices', foreignKey: 'officeId' });
  DateOffice.belongsTo(Office, { as: 'office', foreignKey: 'officeId' });
  Office.hasMany(DateOffice, { as: 'dateOffices', foreignKey: 'officeId' });
  AccountQuestion.belongsTo(Question, { as: 'question', foreignKey: 'questionId' });
  Question.hasMany(AccountQuestion, { as: 'accountQuestions', foreignKey: 'questionId' });
  DateOffice.belongsTo(Question, { as: 'question', foreignKey: 'questionId' });
  Question.hasMany(DateOffice, { as: 'dateOffices', foreignKey: 'questionId' });

  return {
    Account,
    AccountOffice,
    AccountQuestion,
    Cookie,
    DateOffice,
    Office,
    Question,
  };
}

function models() {
  const sequelize = new Sequelize(process.env.DB_URL, { logging: false, });
  return initModels(sequelize);
}

export default models();

