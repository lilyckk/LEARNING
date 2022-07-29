const mysql = require('mysql');
const dbConnection = mysql.createConnection({
    host: 'localhost',
    user:'root',
    password:'',
    database:'mydb'
})

dbConnection.connect((err)=>{
    if(err) throw err;
    console.log("Database Connected!")
})

module.exports = dbConnection;
