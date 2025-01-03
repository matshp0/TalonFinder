import * as cheerio from 'cheerio';


export default function parseDates(html) {
  const $ = cheerio.load(html);
  const dates = [];

  $('a[data-params]').each((index, element) => {
    const dataParams = $(element).attr('data-params');
    const match = dataParams.match(/"chdate":"(.*?)"/);
    if (match) {
      dates.push(match[1]);
    }
  });

  return dates;
}
