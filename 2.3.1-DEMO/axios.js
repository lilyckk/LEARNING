const axios = require('axios');

//獲得資訊
axios.get('http://localhost:3000').then((response)=>{
    console.log(response.data);
})