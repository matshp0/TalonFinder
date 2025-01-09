import { request } from 'undici';
import { headers } from './config.js';
import { RedirectException } from './exceptions.js';

export async function getStepmap(chdate, questionId, cookie) {
  headers.cookie = cookie;
  const { statusCode, body } = await request(`https://eq.hsc.gov.ua/site/stepmap?chdate=${chdate}&question_id=${questionId}`, {
    headers,
    'body': null,
    'method': 'GET'
  });
  if (statusCode >= 200 && statusCode < 300) {
    return await body.json();
  } else {
    if (statusCode === 302) {
      throw new RedirectException('302 Status code received');
    }
    throw new Error(`Failed to fetch available dates. HTTP statusCode: ${statusCode}`);
  }
}

export async function getAvailableDates(questionId, cookie) {
  headers.cookie = cookie;
  const { statusCode, body } = await request(`https://eq.hsc.gov.ua/site/step1?value=${questionId}`, {
    headers,
    'body': null,
    'method': 'GET'
  });
  if (statusCode >= 200 && statusCode < 300) {
    return await body.text();
  } else {
    if (statusCode === 302) {
      throw new RedirectException('302 Status code received');
    }
    throw new Error(`Failed to fetch available dates. HTTP statusCode: ${statusCode}`);
  }
}
