const http = require('http')
const server = http.createServer((req, res)=>{
    res.writeHead(200,{'Content-Type':'text/html'});
    res.write('Hello world, Hey~');
    res.end()
})

server.listen(3000);

