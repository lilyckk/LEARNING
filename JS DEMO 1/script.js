/*

// 用 function 製作計算機

function add(num1, num2) {
  //document.write(num1 + num2);
  return num1 + num2;
  document.write("你好");
}
// add(3,6)
document.write(add(3, 6));



function add(num1, num2) {
    document.write(num1 + num2);
    document.write("<br/>");
    return 10;
    document.write("你好");
  }
  
  value = add(3,2);
  document.write(value);

// ----------------------------------------------

//  用if , function 找出最大數

function max_num(num1, num2, num3) {
    if(num1 >= num2 && num1 >= num3){
        return num1;
    }
    else if(num2 >= num1 && num2 >= num3){
        return num2;
    }
    else{
        return num3;
    }
    
  }
  
    // value = max_num(81,81,81);
    // document.write(value); 

document.write(max_num(81,81,81));


// ----------------------------------------------

// 用 內建函式 Math.max()找出最大數

function max_num(num1, num2, num3){
    return(Math.max(num1, num2, num3));
}

document.write(max_num(88,65,254));


//  使用 物件 Object

var person = {
    name:"Bob",
    age:23,
    is_male:true,
    print_name:function(){
        document.write(this.is_male);
    }
};

person.print_name();

// var phrase = "hello";
// phrase.length();
// phrase.indexOf();



var movie = {
    title:"刻在你心底的名字",
    maker:"氧氣電影",
    duration:114,
    actors:[
        {
            name:"陳昊森",
            age:24,
            is_male:true
        },
        {
            name:"曾敬驊",
            age:23,
            is_male:true
        }
    ]
};

document.write(movie.maker);
document.write(movie.actors[1].is_male);


// ----------------------------------------------

// while 迴圈

var i = 1;

while(i<=9){
    document.write(i);
    document.write("<br/>");
    //i+=1;
    i++;
}

// ----------------------------------------------

// 密碼檢驗程式
// 版本1

var password = 123456;
var input;
var entry_count = 0;
var entry_limit = 3;
var out_of_limit = false;

while(password!=input && !out_of_limit ){
    entry_count++;
    if(entry_count<=entry_limit){
        input=prompt("請輸入密碼");
    }
    else{
        out_of_limit=true;
    }
}

if(out_of_limit){
    alert("超出輸入次數");
}
else{
    alert("登入成功");
}

// ----------------------------------------------
// 版本2

var password = 123456;
var input;
var i =1;

while(password != input && i<=3){
    input = prompt("請輸入密碼 (三次機會)");
    i++;
}
if(password == input){
    alert("登入成功");
}
else{
    alert("登入超過三次，不能再試");
}


// ----------------------------------------------

// for 迴圈

var i = 0;
while(i<10){
    document.write(i);
    document.write("<br/>");
    i++;
}

for(var i = 0; i<10; i++){
    document.write(i);
    document.write("<br/>");
}

var friends = ["Apple", "Banana", "Cat", "Dog", "Egg"];

for(var i = 0; i<friends.length;i++){
    document.write(friends[i]);
    document.write("<br/>");
}


// ----------------------------------------------

// 製作一個問答程式

var questions = [
    {
        prompt:"香蕉是什麼顏色?\n(a)紅色\n(b)綠色\n(c)黃色",
        answer:"c"
    },
    {
        prompt:"草莓是什麼顏色?\n(a)紅色\n(b)紫色\n(c)黃色",
        answer:"a"
    },
    {
        prompt:"1公尺等於幾公分?\n(a)1\n(b)10\n(c)100",
        answer:"c"
    }
]
var score = 0;
for(var i=0; i<questions.length; i++){
    var input = prompt(questions[i].prompt);
    if(input==questions[i].answer){
        score++;
        alert("答對了!");
    }
    else{
        alert("答錯了!")
    }
}

alert("總共答對了" + score + "題!");

// ----------------------------------------------

// 二維陣列、巢狀迴圈

var number = [
    [1,2,3],
    [4,5,6],
    [7,8,9],
    [0]
];

for(var i=0; i<number.length; i++){
    for(var j=0; j<number[i].length; j++){
        document.write(number[i][j]);
    }
    document.write("<br/>");
}

// ----------------------------------------------

// class 類別 = object 物件的模板  (第一個英文字母通常為大寫)

class Phone {
    constructor(number, year, is_waterproof) {
        this.number = number;
        this.year = year;
        this.is_waterproof = is_waterproof;
    }
    phone_age(){
        return 2022 - this.year;
    }
}

var phone1 = new Phone("123", 2020, false);

var phone2 = new Phone("456", 2018, false);

var phone3 = new Phone("789", 2018, true);

for(i=0;i<Phone.length;i++){
    document.write(Phone[i].number);
    document.write(Phone[i].year);
    document.write(Phone[i].is_waterproof);
    document.write(Phone[i].phone_age());
}

document.write(phone1.is_waterproof);

// var phone1 = {
//     number:"123",
//     year:2020,
//     is_waterproof:false,
//     phone_age:function(){
//         return 2022 - this.year;
//     }
// }

// var phone2 = {
//     number:"456",
//     year:2018,
//     is_waterproof:false,
//     phone_age:function(){
//         return 2022 - this.year;
//     }
// }

// var phone3 = {
//     number:"127893",
//     year:2018,
//     is_waterproof:true,
//     phone_age:function(){
//         return 2022 - this.year;
//     }
// }

// ----------------------------------------------

// 如何取得html元素
document.write()
window.document.write("哈哈哈");
window.prompt("哈哈");

var h1 = document.getElementById("header");
h1.innerText = "";
h1.style.backgroundColor = "red";
h1.style.color = "blue";
var link = document.getElementById("link");
link.href = "https://amazon.com";

*/

// ----------------------------------------------

// event listener 事件監聽器
// ex:在頁面上按了什麼按鈕，滑鼠滑過哪些地方，在鍵盤上按了什麼按鍵等等)

// function handle_click(element){
//     //alert("OK!");
//     //console.log(element);
//     element.innerText = "OK!"
//     element.style.color = "red";
// }

var btn = document.getElementById("btn");
btn.addEventListener("click", function(){
    //alert("OK!");
    this.innerText = "OK!";
    this.style.color = "red";
})

var img = document.getElementById("img");
img.addEventListener("mouseover", function(){
    this.src = "img2.png";
})

var img = document.getElementById("img");
img.addEventListener("mouseout", function(){
    this.src = "img1.png";
})

// ----------------------------------------------
