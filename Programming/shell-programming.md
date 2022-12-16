Shell
- shell variables untyped - consider them as strings
  - note that 1 is equivalent to "1"
- **name=value** assigns value to variable name
- **$name** replaced with value of variable name
- **$(command)** is evaluated by running command
  - 'command' is equivalent to $(command)
- single quotes group the characters within into a single word
  - can put a double quote between single quotes
- double quotes group the characters within into a single word
  - variables, commands and arithmetic are expanded inside double quotes
- **<<word** is called a here document
  - following lines until word specify multi-line string as command input
- **$((expression))** is evaluated as an arithmetic expression
  - expression is evaluated as C-like integer arithmetic
- Wildcard
  - The wildcard '\*' means it will match any number of characters or a set of characters
- Escape Characters
  - In a shell, the most common way to escape special characters is to use a backslash before the characters.
- for loops

``` shell
for i in 1 2 3 4 5
do
  echo "Looping ... number $i"
done
```

- while loops

``` shell
INPUT_STRING=hello
while [ "$INPUT_STRING" != "bye" ]
do
  echo "Please type something in (bye to quit)"
  read INPUT_STRING
  echo "You typed: $INPUT_STRING"
done
```

``` shell
#!/bin/sh
while read input_text
do
  case $input_text in
        hello)          echo English    ;;
        howdy)          echo American   ;;
        gday)           echo Australian ;;
        bonjour)        echo French     ;;
        "guten tag")    echo German     ;;
        *)              echo Unknown Language: $input_text
                ;;
   esac
done < myfile.txt
```

- [] is a symbolic link to test

``` shell
echo -en "Please guess the magic number: "
read X
echo $X | grep "[^0-9]" > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
  # If the grep found something other than 0-9
  # then it's not an integer.
  echo "Sorry, wanted a number"
else
  # The grep found only 0-9, so it's an integer. 
  # We can safely do a test on it.
  if [ "$X" -eq "7" ]; then
    echo "You entered the magic number!"
  fi
fi
```

- The case statement saves going through a whole set of `if .. then .. else` statements

``` shell
#!/bin/sh

echo "Please talk to me ..."
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	hello)
		echo "Hello yourself!"
		;;
	bye)
		echo "See you again!"
		break
		;;
	*)
		echo "Sorry, I don't understand"
		;;
  esac
done
```

- More on variables
  - The variable `$0` is the basename of the program as it was called.
  - `$1 .. $9` are the first 9 additional parameters the script was called with.
  - The variable `$@` is all parameters $1 .. whatever.
  - `$#` is the number of parameters the script was called with.

- `{}` is the parameter substitution/expansion
  - a parameter, in bash, is an entity that is used to store values

``` shell
foo=sun
echo $fooshine     # $fooshine is undefined
echo ${foo}shine   # displays the word "sunshine"
```

- Shell functions
  - `shift` is a bash built-in function which kind of removes arguments from the beginning of the argument list

``` shell
#!/bin/sh
# A simple script with a function...

add_a_user()
{
  USER=$1
  PASSWORD=$2
  shift; shift;
  # Having shifted twice, the rest is now comments ...
  COMMENTS=$@
  echo "Adding user $USER ..."
  echo useradd -c "$COMMENTS" $USER
  echo passwd $USER $PASSWORD
  echo "Added user $USER ($COMMENTS) with pass $PASSWORD"
}

###
# Main body of script starts here
###
echo "Start of script..."
add_a_user bob letmein Bob Holness the presenter
add_a_user fred badpassword Fred Durst the singer
add_a_user bilko worsepassword Sgt. Bilko the role model
echo "End of script..."
```
