/**
 * ! 模組化路由
 */

const express = require('express')
const app = express();
const PORT = 3000;

/**
 * ! MiddleWare : 不用一一去每個路由設定 "紀錄Server資訊"
 * * MiddleWare是個function，要負責打印出Server的log
 * ! MiddleWare 的擺放位置要在 Router 之前
 * * 無論對 express Server 做了什麼事，他都會先經過 MiddleWare，再去呼叫到 Router
 * * 這就是 MiddleWare 存在的意義，也是 Server 紀錄 log 檔的方式
 */
const serverLogMiddleWare = (req,res,next)=>{
    console.log(`log:[${req.method}]:${req.url} --- ${new Date().toISOString()}`)

    if(req.method === 'GET' && req.url === '/'){
        console.log('log:[warning] : this url is not found. ')
    }
    /**
     * ! 重點 : 若 Router 中有 function 或還有其他的 MiddleWare 時，要用 NEXT !
     */
    next();
}

/**
 * ! Note : 身分驗證，一旦身分錯誤就不給他看到資料內容
 * * 使用 MiddleWare 製作身分驗證
 * ? MiddleWare : 在每個request進來之前，都要先檢查request，
 * ? 檢查完request後再讓他進行下一步驟，並在進入Router前完成這件事
 * ? 因此在此加入一段身分驗證
 * * QueryString : /priduct?Id=123
 */

const validationMiddleWare = (req,res,next)=>{
    if(req.query.username !== "Michael"){
        // 401 -> 代表認證失敗
        res.status(401);
        res.json({'message':"Verity failed! Please check username is correct or not."})
    }
    else{
        //若驗證成功則放行，進行下一步，導向其他Router
        next();
    }
}


app.use(serverLogMiddleWare);
/**
 * * 此段 MiddleWare 的位置須加在 express Server 上，
 * * 並且在使用 Router 之前，在Server log 之後
 */
app.use(validationMiddleWare);


// router 引入
const teacherRouter = require('./routes/teacher');
const studentRouter = require('./routes/student');

// 使用Router
app.use('/teacher', teacherRouter);
app.use('/student', studentRouter);

app.listen(PORT,()=>{
    console.log('Servering on port' + PORT);
})