import { headers } from './config.js';
import { ExpiredException } from './exceptions.js';
import makeFetchCookie from 'fetch-cookie';
import { WebSocket } from 'undici';
import { extractCsrfToken } from '../utils/extractCsrfToken.js';
import { AsyncQueue } from '../utils/AsyncQueue.js';
import sleep from '../utils/sleep.js';


const fetchQueue = new AsyncQueue();
fetchQueue.minTimeout = parseInt(process.env.MIN_QUEUE_TIMEOUT) || 1000;
fetchQueue.maxTimeout = parseInt(process.env.MAX_QUEUE_TIMEOUT) || 2000;
fetchQueue.onErrorTimeout = parseInt(process.env.ON_ERROR_QUEUE_TIMEOUT) || 10000;
fetchQueue.batchSize = parseInt(process.env.BATCH_SIZE) || 1;


let fetchCookie = makeFetchCookie(fetch);

async function streamToJson(stream) {
  const decoder = new TextDecoder('utf-8');
  let text = '';

  for await (const chunk of stream) {
    text += decoder.decode(chunk, { stream: true });
  }

  text += decoder.decode();

  try {
    return JSON.parse(text);
  } catch (err) {
    throw new Error('Failed to parse JSON: ' + err.message);
  }
}

export async function getAvailableDates(categoryId) {
  const task = fetchAvailableDates.bind(null, categoryId);
  return fetchQueue.process(task);
}

export async function getAvailableOffices(categoryId, date, officeId, cookie) {
  const task = fetchIfAvailable.bind(null, categoryId, date, officeId, cookie);
  return fetchQueue.process(task);
}

async function fetchAvailableDates(categoryId) {
  const { status, body } = await fetchCookie(`https://eqn.hsc.gov.ua/api/v2/days?startDate=[&endDate=s&serviceId=${categoryId}`, {
    headers,
    'body': null,
    'method': 'GET'
  }).catch((err) => {
    console.log(err);
  });
  console.log(status);
  if (status >= 200 && status < 300) {
    return streamToJson(body);
  } else {
    throw new Error(`Failed to fetch available dates. HTTP statusCode: ${body}`);
  }
}


async function fetchIfAvailable(categoryId, date, officeId, cookie) {
  headers['cookie'] = cookie;
  const { status, body } = await fetchCookie(`https://eqn.hsc.gov.ua/api/v2/departments/${officeId}/services/${categoryId}/slots?date=${date}&page=1&pageSize=24`, {
    headers,
    'body': null,
    'method': 'GET'
  });
  console.log(status);
  if (status === 440) throw new ExpiredException('Session has expired');
  if (status >= 200 && status < 300) {
    return streamToJson(body);
  } else {
    throw new Error(`Failed to fetch available offices. HTTP statusCode: ${status}, for date: ${date}`);
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
    await sleep(1000);
    fetchCookie = makeFetchCookie(fetch);
    try {
      await fetchCookie('https://eqn.hsc.gov.ua/api/v2/oauth/govid', {
        method: 'GET',
        redirect: 'follow',
        headers,
      });
      await fetchCookie('https://id.gov.ua/bankid-nbu-auth');
      const formData = new FormData();
      formData.append('selBankConnect', 'monobank');
      const res1 = await fetchCookie('https://id.gov.ua/bankid-auth-request', {
        method: 'POST',
        redirect: 'manual',
        body: formData,
        headers,
      }).catch((err) => {
        throw err;
      });
      const location = res1.headers.get('location');
      const res2 = await fetchCookie(location, {
        method: 'GET',
        redirect: 'manual',
        headers,
      });
      const finalLocation = res2.headers.get('location');
      const url = new URL(finalLocation);
      const redirectUri = await wsConnectApi(url, notify);
      const res4 = await fetchCookie(redirectUri, {
        method: 'GET',
        redirect: 'follow',
        headers,
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
        headers,
      });
      return fetchCookie.cookieJar.getCookieString('https://eqn.hsc.gov.ua');
    } catch (err) {
      console.log(err);
    }
  }
}

