import './utils/env.js';
import NotifierBot from './telegram/bot.js';
import Scraper from './src/scraper.js';


const tgBot = new NotifierBot(process.env.BOT_TOKEN);
const scraper = new Scraper();

scraper.onAvailable = tgBot.newTalonNotify;
console.log(tgBot.newTalonNotify);

tgBot.newTalonNotify({ officeId: 182, date: '2021-12-12', questionId: 56 });

tgBot.launch();
scraper.start();
