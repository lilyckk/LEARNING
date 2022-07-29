const express = require('express');
const router = express.Router();
const dbConnect = require('../config/db');

// R - read
router.get('/',(req,res,next)=>{
    // query('sql',(err,result))
    dbConnect.query("SELECT * FROM students",(err,result) => {
        if (err) {
            throw err;
        }
        res.json(result);
    })
});

// C - create
router.post('/',(req,res,next)=>{
    dbConnect.query(
        "INSERT INTO students(name,age,email,department) VALUES(?,?,?,?)",
        [req.body.name,req.body.age,req.body.email,req.body.department],(err,result)=>{
            if(err){
                throw err;
            } else{
                res.send('insert successfullly!')
            }
        }
    );
});

router.post('/',(req,res,next)=>{
    dbConnect.query(
        "INSERT INTO students(name,age,email,department) VALUES(?,?,?,?)",
        [req.body.name,req.body.age,req.body.email,req.body.department],(err,result)=>{
            if(err){
                throw err;
            } else{
                res.send('insert successfullly!')
            }
        }
    );
});

// U - update
router.patch('/',(req,res,next)=>{
    dbConnect.query("update students set age=? where id= ?",[req.body.age,req.body.id],(err,result)=>{
        if(err){
            throw err;
        }
        else{
            res.send('updated successfully!')
        }
    })
})

// D - delete

module.exports = router;