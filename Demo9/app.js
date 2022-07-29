const bodyParser = require('body-parser');
const express = require('express');
const app = express();
const PORT = 3000;
const studentsRouter = require('./routes/students')

app.set('view engine', 'ejs');

app.use(bodyParser.urlencoded({ extended: true}));
app.use(bodyParser.json());
app.use('/students',studentsRouter)

app.get('/',function(req,res){
    res.render('index.ejs');
})

app.listen(PORT,()=>{
    console.log('Server is  listening on port:' + PORT);
})