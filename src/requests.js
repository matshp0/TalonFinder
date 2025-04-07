import { request } from 'undici';
import { headers } from './config.js';
import { ExpiredException } from './exceptions.js';

export async function getAvailableDates(categoryId) {
  const { statusCode, body } = await request(`https://eqn.hsc.gov.ua/api/v2/days?startDate=[&endDate=s&serviceId=${categoryId}`, {
    headers,
    'body': null,
    'method': 'GET'
  });
  if (statusCode >= 200 && statusCode < 300) {
    return body.json();
  } else {
    throw new Error(`Failed to fetch available dates. HTTP statusCode: ${statusCode}`);
  }
}

export async function getAvailableOffices(categoryId, date, cookie) {
  headers['cookie'] = cookie;
  const { statusCode, body } = await request(`https://eqn.hsc.gov.ua/api/v2/departments?serviceId=${categoryId}&date=${date}`, {
    headers,
    'body': null,
    'method': 'GET'
  });
  if (statusCode === 440) throw new ExpiredException('Session has expired');
  if (statusCode >= 200 && statusCode < 300) {
    return body.json();
  } else {
    throw new Error(`Failed to fetch available offices. HTTP statusCode: ${statusCode}, for date: ${date}`);
  }
}
