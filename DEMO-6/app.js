/**
 * ! 基本Server架構
 */

const express = require('express')

// express 的 Server
const app = express();
const PORT = 3000;

// 指定樣板引擎為ejs
app.engine('.html', require('ejs').__express);
  app.set('view engine', 'html');
//app.set('view engine', 'ejs');

/**
 * ! app.use VS app.set 
 * * app.use : 是指 express 要使用靜態資源，而這個資源在哪個位置上
 * * app.set : 這整個 express 的框架是要吃什麼樣的樣板引擎(ejs)
 * */

// 掛載靜態資源，絕對路徑 + /public
app.use(express.static(__dirname + '/public'));

// Render 渲染 : 要呼叫前端的頁面作頁面的顯示，回應一整個頁面
app.get('/',(req,res)=>{
    res.render('index.ejs',{
        title:'TMC 商城',
        productList:[
            {
                'category': '3C',
                'productName':'i phone',
                'text':'iphone just pro',
                'price':25000,
                'inventory':5
            },
            {
                'category': 'house',
                'productName':'keyboard',
                'text':'there is a new keyboard',
                'price':3000,
                'inventory':4
            }
        ]
    });
})

// 監聽，並讓人知道Server已啟動
app.listen(PORT,()=>{
    console.log('Server is start on port: ', PORT);
})