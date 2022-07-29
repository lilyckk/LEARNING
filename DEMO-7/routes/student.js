const express = require('express');
const router = express.Router();

router.get('/information',(req,res,next)=>{
    const studentInfo = {
        "name":"Tim",
        "department":"computer science",
        "age":22
    }
    res.json(studentInfo);
})

module.exports = router;