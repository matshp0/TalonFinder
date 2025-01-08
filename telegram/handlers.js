import models from '../database/models.js';
import Office from '../database/models/Office.js';

const { Account,
  AccountOffice,
  AccountQuestion,
  Question } = models;

export async function startHandler(ctx) {
  const { id } = ctx.from;
  const [record, created] = await Account.findOrCreate({
    where: { id },
    defaults: {
      id,
      role: 'user'
    }
  });

  if (created) {
    console.log('A new record was created:', record);
  } else {
    console.log('Record already exists:', record);
  }
}

export async function onOfficeAdd(ctx) {
  const { payload } = ctx;
  const offices = payload.split(' ').map((id) => +id);
  const query = await Office.findAll();
  const officeIdArr = query.map(({ dataValues }) => dataValues.id);
  const isValid = offices.every((id) => officeIdArr.includes(id));
  if (!isValid) {
    ctx.reply('Error occurred parsing payload');
    return;
  }
  const records = offices.map((officeId) => AccountOffice.create({
    officeId,
    accountId: ctx.from.id
  }));
  ctx.reply(`You're going to be notified, if one of this offices: ${[offices]} will have available tickets`);
  await Promise.allSettled(records);
}

export async function onCategoryAdd(ctx) {
  const { payload } = ctx;
  const categories = payload.split(' ').map((id) => +id);
  const query = await Question.findAll();
  const questionIdArr = query.map(({ dataValues }) => dataValues.id);
  const isValid = categories.every((id) => (questionIdArr.includes(id)));
  if (!isValid) {
    ctx.reply('Could not find category with provided id');
    return;
  }
  const records = categories.map((categoryId) => AccountQuestion.create({
    questionId: categoryId,
    accountId: ctx.from.id
  }));
  ctx.reply(`You're going to be notified, if one of this categories: ${[categories]} will have available tickets`);
  await Promise.allSettled(records);
}

