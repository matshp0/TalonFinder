import models from '../database/models.js';

const { Account } = models;

export async function isAdmin(ctx, next) {
  const userQuery =  await Account.findByPk(ctx.from.id);
  const user = userQuery.toJSON();
  if (user.role === 'admin') {
    return next();
  }
}
