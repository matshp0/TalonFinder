import { request } from 'undici';
import { headers } from './config.js';
import { ExpiredException } from './exceptions.js';
import makeFetchCookie from 'fetch-cookie';
import { WebSocket } from 'undici';
import { extractCsrfToken } from '../utils/extractCsrfToken.js';
import { AsyncQueue } from '../utils/AsyncQueue.js';


const fetchQueue = new AsyncQueue();
fetchQueue.minTimeout = parseInt(process.env.MIN_QUEUE_TIMEOUT) || 1000;
fetchQueue.maxTimeout = parseInt(process.env.MAX_QUEUE_TIMEOUT) || 2000;
fetchQueue.onErrorTimeout = parseInt(process.env.ON_ERROR_QUEUE_TIMEOUT) || 10000;
fetchQueue.batchSize = parseInt(process.env.BATCH_SIZE) || 1;

export async function getAvailableDates(categoryId) {
  const task = fetchAvailableDates.bind(null, categoryId);
  return fetchQueue.process(task);
}

export async function getAvailableOffices(categoryId, date, cookie) {
  const task = fetchAvailableOffices.bind(null, categoryId, date, cookie);
  return fetchQueue.process(task);
}

async function fetchAvailableDates(categoryId) {
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


async function fetchAvailableOffices(categoryId, date, cookie) {
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

const wsConnectApi = async (url, notify) => new Promise((resolve, reject) => {
  const { searchParams } = url;
  const reqObj = {
    'c': 'nbuBankId',
    'redirectUri': null,
    'clientId': searchParams.get('client_id'),
    'state': searchParams.get('state'),
  };
  const ping = (ws) => ws.send(JSON.stringify({ 'c': 'ping' }));
  let pingInterval = null;
  const ws = new WebSocket('wss://api.monobank.ua/wss/');
  ws.addEventListener('open', () => {
    ws.send(JSON.stringify(reqObj));
    ping(ws);
    pingInterval = setInterval(() => ping(ws));
  });
  ws.addEventListener('message', (event) => {
    const { data } = event;
    const json = JSON.parse(data);
    if (json['a'] === 'qr') {
      notify(`⚠️Session expired \n ℹ️Login url: \n${json.data}`);
    }
    if (json['a'] === 'redirect') {
      resolve(json['redirectUrl']);
      clearInterval(pingInterval);
      ws.close();
    }
  });
  ws.addEventListener('close', () => {
    clearInterval(pingInterval);
    reject();
  });
  ws.addEventListener('error', (error) => {
    clearInterval(pingInterval);
    reject(error);
  });
});


export async function getLogInCookie(notify) {
  while (true) {
    try {
      const fetchCookie = makeFetchCookie(fetch);
      await fetchCookie('https://eqn.hsc.gov.ua/api/v2/oauth/govid', {
        method: 'GET',
        redirect: 'follow',
      });
      await fetchCookie('https://id.gov.ua/bankid-nbu-auth');
      const formData = new FormData();
      formData.append('selBankConnect', 'monobank');
      const res1 = await fetchCookie('https://id.gov.ua/bankid-auth-request', {
        method: 'POST',
        redirect: 'manual',
        body: formData,
      });
      const location = res1.headers.get('location');
      const res2 = await fetchCookie(location, {
        method: 'GET',
        redirect: 'manual',
      });
      const finalLocation = res2.headers.get('location');
      const url = new URL(finalLocation);
      const redirectUri = await wsConnectApi(url, notify);
      const res4 = await fetchCookie(redirectUri, {
        method: 'GET',
        redirect: 'follow',
      });
      const html = await res4.text();
      const csrfToken = extractCsrfToken(html);
      const formData2 = new FormData();
      formData2.append('cfsr_token', csrfToken);
      formData2.append('is_passport', '0');
      formData2.append('is_edrpou', '0');
      formData2.append('is_birthday', '0');
      await fetchCookie('https://id.gov.ua/senduserdata', {
        method: 'POST',
        redirect: 'follow',
        body: formData2,
      });
      return fetchCookie.cookieJar.getCookieString('https://eqn.hsc.gov.ua');
    } catch (err) {
      console.log(err);
    }
  }
}

