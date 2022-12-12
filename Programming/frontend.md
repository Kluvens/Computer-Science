# HTML

List of items:
1. \<html>
2. \<head>
3. \<body>
4. \<button>: breate a button
5. \<title>: defines the title of the document
6. \<style>: defines style information (CSS) for a document
7. \<p>: defines a paragraph

# CSS

# JavaScript

## Basics
Variable declaration and assignment:
```
const newVar = 10;

// const cannot be redeclared
// use let you wish to reassign the variable
// and use const if you do not wish to reassign the variable
// use lowerChamelCase for variables
```

Javascript Function:
```
// Function to compute the product of p1 and p2
function myFunction(p1, p2) {
  return p1 * p2;
}
```

Before Arrow:
```
hello = function() {
  return "Hello World!";
}
```

With Arrow Function:
```
hello = () => {
  return "Hello World!";
}
```

Anonymous Function:
```
let show = function() {
    console.log('Anonymous function');
};

show();
```

Switch statement:
```
switch (new Date().getDay()) {
  case 4:
  case 5:
    text = "Soon it is Weekend";
    break;
  case 0:
  case 6:
    text = "It is Weekend";
    break;
  default:
    text = "Looking forward to the Weekend";
}
```

map in Javascript:
```
const numbers = [65, 44, 12, 4];
const newArr = numbers.map(myFunction)

function myFunction(num) {
  return num * 10;
}
```

filter in Javascript:
```
const ages = [32, 33, 16, 40];
const result = ages.filter(checkAdult);

function checkAdult(age) {
  return age >= 18;
}
```

reduce in Javascript:
```
const numbers = [15.5, 2.3, 1.1, 4.7];
document.getElementById("demo").innerHTML = numbers.reduce(getSum, 0);

function getSum(total, num) {
  return total + Math.round(num);
}
```

callback in Javascript (passing in a function):
```
function greeting(name) {
  alert(`Hello, ${name}`);
}

function processUserInput(callback) {
  const name = prompt("Please enter your name.");
  callback(name);
}

processUserInput(greeting);
```
