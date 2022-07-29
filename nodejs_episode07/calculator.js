// 加法
function add(num1, num2){
    return num1 + num2;
}

// 減法
function subtract(num1, num2){
    return num1 - num2;
}

// 乘法
function multiply(num1, num2){
    return num1 * num2;
}

// 除法
function divide(num1, num2){
    return num1 / num2;
}


// 將檔案裡的這兩個function輸出( module, exprt )，讓其他程序能夠引入和調用
// 同時輸出多個函數 : module.exports 一開始是個空object，可提供key-value 
// 在module.exports object裡面添加新數據
// 把 add 函數賦予 module.exports object 裡的 add 屬性

// 法一
// module.exports.add = add; //add = 要輸出的函數名
// module.exports.subtract = subtract; //add = 要輸出的函數名

// 法二 可把 module 省略掉
// exports.add = add; //add = 要輸出的函數名
// exports.subtract = subtract; //add = 要輸出的函數名

// 法三 把一個 object 賦予 module.exports，在大括號裡輸入 key, value
// module.exports = {
//     add: add,
//     subtract: subtract,
// }

// 法四 若 key, value 值相同，可省略 key
module.exports = {
    add,
    subtract,
    multiply,
    divide,
}