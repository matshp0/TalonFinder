import { request } from 'undici';
import { headers } from './config.js';
import { RedirectException } from './exceptions.js';
import { toDate } from '../utils/date.js';

export async function getAvailableDates(questionId, officeId, cookie) {
  headers.cookie = cookie;
  const { statusCode, body } = await request(`https://eqn.hsc.gov.ua/api/v2/days?startDate=${toDate(new Date())}&endDate=2025-04-30&serviceId=${questionId}&departmentId=${officeId}`, {
    headers,
    'body': null,
    'method': 'GET'
  });
  if (statusCode >= 200 && statusCode < 300) {
    return await body.json();
  } else {
    if (statusCode === 440) {
      throw new RedirectException('302 Status code received');
    }
    throw new Error(`Failed to fetch available dates. HTTP statusCode: ${statusCode}`);
  }
}

