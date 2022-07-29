const http = require('http');
const server = http.createServer((req,res)=>{
    const returnObj = {};
    returnObj.name = 'Lily';
    returnObj.gender = 'Female';
    res.writeHead(200,{'content-type':'application/json'})
    res.write(JSON.stringify(returnObj));
    res.end();
})

const PORT = 3000;
server.listen(PORT)
console.log('Server listening on port', PORT);