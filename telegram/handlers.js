import models from '../database/models.js';

const { Account, AccountOffice } = models;

const { MIN_OFFICE_ID, MAX_OFFICE_ID } = process.env;

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
  const isValid = offices.every((id) => (Number.isInteger(id) && id >= MIN_OFFICE_ID &&
      id <= MAX_OFFICE_ID));
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

