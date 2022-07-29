const express = require('express')
const router = express.Router();

router.get('/information',(req,res,next)=>{

    // 紀錄Server資訊
    // req.method -> request 的 http 方法
    // req.url -> request 的路徑 (router)
    console.log(`log:[${req.method}]:${req.url} --- ${new Date().toISOString()}`)
    const teacherInfo = {
        "name":"Jason",
        "age":28,
        "course":"node.js",
        "email":"1234@gmail.com",
        "phone":0912345678
    }
    res.json(teacherInfo);
})

// export router
module.exports = router;