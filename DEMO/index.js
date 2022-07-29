const http = require('http');
const server = http.createServer((req,res)=>{
    // step 1 - create header 設定回應的格式 (text/html, application/json)
    // Content-Type 是一個Object物件 ，需要有鍵值
    res.writeHead(200,{'Content-Type':'text/html'})
   
    // step 2 - response Content 設定要回應前端的訊息
    res.write('Hello students, this is teacher michael lin.')
   
    // step 3 - end response 需要結束這個回應，不然網路會一直旋轉
    res.end();
})
//step 4 - setting port
server.listen(5000); // Server 要監聽 5000 這個 PORT
console.log('Server is start at port 5000');
