const express = require('express');
const session = require('express-session');
const app = express();

// MiddleWare express session
app.use(
    session({
        secret:"teachermichaelnodecourse",
        resave: true,
        saveUninitialized:true,
        name:"demo",
        cookie:{
            // 單位:毫秒 
            maxAge: 10 * 60 * 1000 //10分鐘 
        }
    })
)


const PORT = 3000;

app.listen(3000,()=>{
    console.log("Server is listening on port",3000)
})

// 將資料塞進session
app.get('/',(req,res)=>{
    req.session.account = 'Michael';
    res.send(`Hello : ${req.session.account}`)
})