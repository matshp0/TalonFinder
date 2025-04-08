import { request } from 'undici';
import { headers } from './config.js';
import { ExpiredException } from './exceptions.js';
import makeFetchCookie from 'fetch-cookie';
import { WebSocket } from 'undici';
import { extractCsrfToken } from '../utils/extractCsrfToken.js';

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

const wsConnectApi = async (url, notify) => new Promise((resolve, reject) => {
  const { searchParams } = url;
  const reqObj = {
    'c': 'nbuBankId',
    'redirectUri': null,
    'clientId': searchParams.get('client_id'),
    'state': searchParams.get('state'),
  };
  const ws = new WebSocket('wss://api.monobank.ua/wss/');
  ws.addEventListener('open', () => {
    ws.send(JSON.stringify(reqObj));
  });
  ws.addEventListener('message', (event) => {
    const { data } = event;
    const json = JSON.parse(data);
    if (json['a'] === 'qr') {
      notify(`⚠️Session expired \n ℹ️Login url: \n${json.data}`);
    }
    if (json['a'] === 'redirect') {
      resolve(json['redirectUrl']);
      ws.close();
    }
  });
  ws.addEventListener('close', () => {
    reject();
  });
  ws.addEventListener('error', (error) => {
    reject(error);
  });
});


export async function getLogInCookie(notify) {
  const fetchCookie = makeFetchCookie(fetch);
  await fetchCookie('https://id.gov.ua/?response_type=code&client_id=80c51b9c14a442af5a3c3c0f64acaa0f&state=1231231231&redirect_uri=https://eqn.hsc.gov.ua/openid/auth/govid');
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
}

