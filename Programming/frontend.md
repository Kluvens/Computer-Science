# HTML

HTML is used for structure

List of items:
1. \<html>
2. \<head>
3. \<body>
4. \<button>: breate a button
5. \<title>: defines the title of the document
6. \<style>: defines style information (CSS) for a document
7. \<p class="attribute">: defines a paragraph where class indicates HTML attribute
8. \<link rel="stylesheet" href="css/styles.css">: combine css and html
9. \<script src="js/script.js">: add javascript on the document
10. \<h1>: header
11. \<strong>
12. \<img src="" alt=""/>
13. \<link />
14. \<span>: an inline container used to mark up a part of a text, or a part of a document. The span tag is much like the div element, but div is a block-level element and span is an inline element.
15. \<em>: emphasis
16. \<div>: defines a division or a section in an HTML document. It is used as a container for HTML elements - which is then styled with CSS or manipulated with Javascript.
17. \<input name="" placeholder=""/>
18. \<ul>: uordered list
19. \<li>: list element
20. \<ol>: ordered list

HTML example:
```
<!DOCTYPE html>
<html>

<head>
  <title>Brown Bears</title>
</head>

<body>
  <a href="./index.html">Brown Bear</a>
  <a href="./aboutme.html">About Me</a>
  <h1>The Brown Bear</h1>
    <ul>
      <li><a href="#introduction">Introduction</a></li>
      <li><a href="#habitat">Habitat</a></li>
      <li><a href="#media">Media</a></li>
    </ul>
  <div id="introduction">
    <h2>About Brown Bears</h2>
    <p>The brown bear (<em>Ursus arctos</em>) is native to parts of northern Eurasia and North America. Its conservation status is currently <strong>Least Concern</strong>.<br /><br /> There are many subspecies within the brown bear species, including the
      Atlas bear and the Himalayan brown bear.</p>
    <a href="https://en.wikipedia.org/wiki/Brown_bear" target="_blank">Learn More</a>
    <h3>Species</h3>
    <ul>
      <li>Arctos</li>
      <li>Collarus</li>
      <li>Horribilis</li>
      <li>Nelsoni (extinct)</li>
    </ul>
    <h3>Features</h3>
    <p>Brown bears are not always completely brown. Some can be reddish or yellowish. They have very large, curved claws and huge paws. Male brown bears are often 30% larger than female brown bears. They can range from 5 feet to 9 feet from head to toe.</p>
  </div>
  <div id="habitat">
    <h2>Habitat</h2>
    <h3>Countries with Large Brown Bear Populations</h3>
    <ol>
      <li>Russia</li>
      <li>United States</li>
      <li>Canada</li>
    </ol>
    <h3>Countries with Small Brown Bear Populations</h3>
    <p>Some countries with smaller brown bear populations include Armenia, Belarus, Bulgaria, China, Finland, France, Greece, India, Japan, Nepal, Poland, Romania, Slovenia, Turkmenistan, and Uzbekistan.</p>
  </div>
  <div id="media">
    <h2>Media</h2>
    <a href="https://en.wikipedia.org/wiki/Brown_bear" target="_blank"><img src="https://content.codecademy.com/courses/web-101/web101-image_brownbear.jpg"/></a>
    <video src="https://content.codecademy.com/courses/freelance-1/unit-1/lesson-2/htmlcss1-vid_brown-bear.mp4" height="240" width="320" controls>Video not supported</video>
  </div>
</body>

</html>
```

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

## Javascript Dates
```
const now = new Date();

now.valueOf();
// miliseconds after 1970

const now = new Date(2020, 11, 2, 7, 10)
```

## Javascript Regular Expression
```
const regex = new RegExp(/^a...s$/);
console.log(regex.test('alias')); // true
```

```
const string = 'Find me';
const pattern = /me/;

// search if the pattern is in string variable
const result1 = string.search(pattern);
console.log(result1); // 5

// replace the character with another character
const string1 = 'Find me';
string1.replace(pattern, 'found you'); // Find found you

// splitting strings into array elements
const regex1 = /[\s,]+/;
const result2 = 'Hello world! '.split(regex1);
console.log(result2); // ['Hello', 'world!', '']

// searching the phone number pattern
const regex2 = /(\d{3})\D(\d{3})-(\d{4})/g;
const result3 = regex2.exec('My phone number is: 555 123-4567.');
console.log(result3); // ["555 123-4567", "555", "123", "4567"]
```

## Javascript Dictionary
The Map object holds key-value pairs and remembers the original insertion order of the keys. 
Any value (both objects and primitive values) may be used as either a key or a value.

```
const map1 = new Map();

map1.set('a', 1);
map1.set('b', 2);
map1.set('c', 3);

console.log(map1.get('a'));
// expected output: 1

map1.set('a', 97);

console.log(map1.get('a'));
// expected output: 97

console.log(map1.size);
// expected output: 3

map1.delete('b');

console.log(map1.size);
// expected output: 2
```

