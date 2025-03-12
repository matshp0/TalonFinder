export const toDate = (ISOSDate) => new Date(ISOSDate).toISOString().split('T')[0];
