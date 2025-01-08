import models from '../database/models.js';
import Office from '../database/models/Office.js';

const { Account,
  AccountOffice,
  AccountQuestion,
  Question } = models;

export async function startHandler(ctx) {
  const { id } = ctx.from;
  ctx.reply(`🤖 Цей бот допоможе вам отримати сповіщення про доступні талони на обрані вами ТСЦ МВС. \n
  📋 Доступні команди: \n
  ➕ /add_office - додати офіс для сповіщення \n
  ➕ /add_category - додати категорію для сповіщення \n
  🏢 /offices - список доступних офісів \n
  📂 /categories - список доступних категорій`);
  await Account.findOrCreate({
    where: { id },
    defaults: {
      id,
      role: 'user'
    }
  });
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

export async function onOffices(ctx) {
  const query = await Office.findAll();
  const offices = query.map(({ dataValues }) => dataValues);
  const message = offices.map(({ id, address }) => `${id}: ${address}`).join('\n');
  ctx.reply('🏢 Доступні офіси: \n' + message);
}

export async function onCategories(ctx) {
  const query = await Question.findAll();
  const categories = query.map(({ dataValues }) => dataValues);
  const message = categories.map(({ id, category }) => `${id}: ${category}`).join('\n');
  ctx.reply('🏷️ Доступні категорії: \n' + message);
}
