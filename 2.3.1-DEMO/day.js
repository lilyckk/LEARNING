const dayjs = require('dayjs');
const utc = require('dayjs/plugin/utc');
// import dayjs from 'dayjs';

//傳入現在的時間
const now = dayjs(new Date()).format('YYYY-MM-DD HH:mm:ss');
//console.log(now);

const date1 = dayjs('01-10-2020').format('YYYY-MM-DD');
//console.log(date1);

//UTC 要記得引入相關套件
dayjs.extend(utc);
const utcTime = dayjs().utc().format();
console.log(utcTime);