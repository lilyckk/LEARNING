// 引入express
const express = require('express')

// 建立Router，Router是express裡面的api，因此需要引用express
const router = express.Router();

// req -> request, res -> response
// next -> funtion, middleware 
// (若Router裡面有加上function或middleware的話，要在最後一行上
// 加上next讓他繼續去執行到下一層的程式碼
// 有next -> 下一個function)
router.get('/clothes',(req,res,next)=>{
    // clothes是json格式，json = 一個object包成key&value
    // 有時會加上array
    // -> [{key:value},{key:value}]

    // json格式中若有一個以上的話就要用Array包起來
    // 若要將資料push上去時，array可做存取的動作
    const clothesArray = []     
    const clothes = {
        "name":"T-shirt",
        "price":200,
        "inventory":10
    }
    const clothes2 = {
        "name":"shirt",
        "price":100,
        "inventory":10
    }

    // 要把資料(clothes) push進剛剛建立的Array之中 
    // (也可用迴圈)
    clothesArray.push(clothes)   
    clothesArray.push(clothes2)

    // 要return出一個j.son檔，所以用response
    res.json(clothesArray);      
})

// 重點 : export router 
// 讓主程式知道，把router給export出去
// 把這支程式(product.js)封裝成一個module，並且export出去，名字叫router
// export出去的東西是router，router就是剛剛封包的express的router (為get的method)
// 裡面會回應clothesArray
module.exports = router;