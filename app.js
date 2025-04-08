import './utils/env.js';
import NotifierBot from './telegram/bot.js';
import Scraper from './src/scraper.js';

const tgBot = new NotifierBot(process.env.BOT_TOKEN);
const scraper = new Scraper();

scraper.onAvailable = tgBot.newTalonNotify;
scraper.adminNotify = tgBot.adminNotify;
tgBot.startScraper = scraper.start;

scraper.start();
tgBot.launch();
