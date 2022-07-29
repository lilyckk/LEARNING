// 0726 NodeJS 簡易版計算機 (模組化練習)
// 將app.js內的function模組化，讓app.js & server.js 共享這兩個函數

// 創建一個常量 保存 require 語句返回 object
// 讓 NodeJS 從當前目錄裡的 calculator.js 引入其對外開放的功能
// calculator.js裡的function是不會自動被暴露輸出的
// 需要明確告訴NodeJS哪一個函數需要被輸出( module, exprt )，這樣才能被其他程序引入和調用
const calculator = require("./calculator.js");

console.log(calculator);

let addResult = calculator.add(1, 2);
console.log(`1 + 2 = ${addResult}`);

let multiplyResult = calculator.multiply(2,3);
console.log(`2 * 3 = ${multiplyResult}`);

let divideResult = calculator.divide(24,6);
console.log(`24 / 6 = ${divideResult}`);