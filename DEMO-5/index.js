const { response } = require('express');
//引入express
// 呼叫 express
const express = require('express'); 

// 引入router
const clothesRouter = require('./routes/product')

//呼叫express 的 Server
const app = express(); 

//設定PORT  幫express加上一個PORT號
//3000通常拿來做測試或前端的Server
const PORT = 5000; 

//引入express server讀取靜態資源
app.use(express.static(__dirname + '/public'))

//引入router 要給一個路由(/product)，讓express知道這個路由要導向剛剛那Router
app.use('/product',clothesRouter)


//設定第一支GET api
//Client發送request，Server(express端)回應response
app.get('/',(request,response)=>{
    // status code, 200 = success
    response.status(200); 
    
    // 回應一些字，代表 Server 有正常啟動
    response.send("Hello My Express Server!!")
})

// 第一個Server的錯誤訊息
// 錯誤訊息的api
app.get('/error-500', (req,res)=>{
    // json格式
    const message = {'message':'Server is stop now, something wrong.'}
    res.status(500)
    res.json(message);
})

//設定Server監聽PORT並且啟動 ， (監聽PORT讓 Server可以正常啟動)
//要放在最後面，是讓server啟動的最後一步
app.listen(PORT,()=>{

    //業界開發習慣加上這句，方便查看程式進行到你哪裡
    console.log('Server is listen on port' + PORT) //需要知道程式已經進行到哪裡
});
