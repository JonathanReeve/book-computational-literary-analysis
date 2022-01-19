* Python Basics

Before we can do real literary analysis with computers, we should explore the basics of the Python programming language.

Here's the one-line program that everyone typically learns as a first step to programming in any language:

#+begin_src python :results output
print("Hello world!")
#+end_src

#+RESULTS:
: Hello world!

There are a few things going on here. =print= is the name of a /function/, i.e., a set of instructions for doing something. The parentheses =()= say to /call/, or /execute/ the program, i.e., follow all the instructions. And the quoted message ="Hello world!"= is a /string/: a sequence of characters, or letters.

If you were to write it without the parentheses, it wouldn't work:

#+begin_src python
print "Hello world!"
#+end_src

#+RESULTS:

#+begin_example:
  File "<stdin>", line 3
    print "Hello world!"
          ^
SyntaxError: Missing parentheses in call to 'print'. Did you mean print("Hello world!")?
#+end_example

And if you were to write it without quotation marks, it wouldn't work, either:

#+begin_src python
print(Hello world!)
#+end_src

#+RESULTS:

#+begin_example
  File "<stdin>", line 3
    print(Hello world!)
                ^
SyntaxError: invalid syntax
#+end_example

That's because Python interprets unquoted words as a /name/, or something it's able to look up, like the name of a function or the name of a variable. Since neither =Hello= nor =world!= are names, we get an error.

So when we run the function =print()=, we should run it with something =print()= can handle. It can print a string (quoted text), a number, or the contents of some variable.

Notice that there's a subtle but important difference between these two function calls:

#+begin_src python :results output
print(56)
#+end_src

#+begin_example
  56
#+end_example

#+begin_src python :results output
print("56")
#+end_src

#+RESULTS:

#+begin_example
  56
#+end_example

That's because ="56"= is a /string/ (or =str=, as Python calls it), and =56= is an /integer/, or =int=. You can verify this with the =type()= function:

#+begin_src python :results raw :session session_init
type("56")
#+end_src

#+RESULTS:
<class 'str'>

#+begin_src python :results raw :session session_init
type(56)
#+end_src

#+RESULTS:
<class 'int'>

Types are important concepts in programming, since a computer doesn't know how to add a number to a string:

#+begin_src python :results raw :session session_init
"56" + 1
#+end_src

#+RESULTS:

** String Methods
:PROPERTIES:
   :CUSTOM_ID: functions-vs.-methods
   :END:

In Python, /methods/ are object-specific functions, accessed through a dot (=.=) syntax. So ="Hello world!".upper()= means to call the method =.upper()= on the string ="Hello world!=, uppercasing it:

#+begin_src python :results output
print("Hello world!".upper())
#+end_src

#+RESULTS:
: HELLO WORLD!

Objects don't all have the same available methods. For instance, the =int= or integer object doesn't have an =.upper()= method available, since you can't uppercase an integer.

To find what methods are available to what objects, use the =dir()= function.

#+begin_src python :results output
print(dir("Hello world!"))
#+end_Src

#+RESULTS:
: ['__add__', '__class__', '__contains__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__getitem__', '__getnewargs__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__iter__', '__le__', '__len__', '__lt__', '__mod__', '__mul__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__rmod__', '__rmul__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', 'capitalize', 'casefold', 'center', 'count', 'encode', 'endswith', 'expandtabs', 'find', 'format', 'format_map', 'index', 'isalnum', 'isalpha', 'isascii', 'isdecimal', 'isdigit', 'isidentifier', 'islower', 'isnumeric', 'isprintable', 'isspace', 'istitle', 'isupper', 'join', 'ljust', 'lower', 'lstrip', 'maketrans', 'partition', 'removeprefix', 'removesuffix', 'replace', 'rfind', 'rindex', 'rjust', 'rpartition', 'rsplit', 'rstrip', 'split', 'splitlines', 'startswith', 'strip', 'swapcase', 'title', 'translate', 'upper', 'zfill']

Ignoring the double-underscored names for the moment (those are usually reserved for Python's internal use), you'll see there are a lot of things that you can do with a string. Lowercase it:

#+begin_src python :results value :session session_init
myString = "Here is a string"
myString.lower()
#+end_src

#+RESULTS:
: here is a string

Replace something in it:

#+begin_src python :results raw :session session_init
"here is a string".replace('string', 'example')
#+end_src

#+RESULTS:
here is a example

Split it according to some separator:

#+begin_src python :results raw :session session_init
"here-is-a-string".split('-')
#+end_src

#+RESULTS:
['here', 'is', 'a', 'string']

You'll notice that many of th string methods start with =is=, like =isalpha= and =isnumeric=. You can use these to test the properties of a string:

#+begin_src python :results raw :session session_init
"string".isalpha()
#+end_src

#+RESULTS:
True

#+begin_src python :results raw :session session_init
"32".isalpha()
#+end_src

#+RESULTS:
False

=True= and =False= are /Boolean/ values. But we'll get to those later.


** List Methods
:PROPERTIES:
   :CUSTOM_ID: list-methods
   :END:

/Lists/ are a Python data type that can contain a number of items, like strings. They're expressed as comma-separated values inside square brackets. For example:

#+begin_src python :results raw :session session_init
ulysses_characters = ["Bloom", "Stephen", "Molly"]
type(ulysses_characters)
#+end_src

#+RESULTS:
<class 'list'>

Like with strings, lists have a number of methods which only work with lists:

#+begin_src python :results raw :session session_init
dir(list)
#+end_src

#+RESULTS:
['__add__', '__class__', '__class_getitem__', '__contains__', '__delattr__', '__delitem__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__getitem__', '__gt__', '__hash__', '__iadd__', '__imul__', '__init__', '__init_subclass__', '__iter__', '__le__', '__len__', '__lt__', '__mul__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__reversed__', '__rmul__', '__setattr__', '__setitem__', '__sizeof__', '__str__', '__subclasshook__', 'append', 'clear', 'copy', 'count', 'extend', 'index', 'insert', 'pop', 'remove', 'reverse', 'sort']

You can =.append()= items to the end of a list:

#+begin_src python :results replace :session session_init
ulysses_characters.append("The Citizen")
print(ulysses_characters)
#+end_src

#+RESULTS:
: None

Similarly, you can =.count()= the number of items in a list. This is useful if you have a list of words. Let's say we have a sentence, and we want to count some of its words. First, we might split the sentence into words, using the =.split()= string method:

#+begin_src python :results output :session session_init
universal_truth = "It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife."
universal_truth_words = universal_truth.split()
print(universal_truth_words)
#+end_src

#+RESULTS:
: ['It', 'is', 'a', 'truth', 'universally', 'acknowledged,', 'that', 'a', 'single', 'man', 'in', 'possession', 'of', 'a', 'good', 'fortune,', 'must', 'be', 'in', 'want', 'of', 'a', 'wife.']

Notice that =.split()= gives us a =list=. We can then use the =.count()= list method, to count the number of times the word /a/ occurs.

#+begin_src python :results output :session session_init
print(universal_truth_words.count('a'))
#+end_src

#+RESULTS:
: 4


** Indexing Lists
   :PROPERTIES:
   :CUSTOM_ID: indexing-lists
   :END:
Getting particular items out of a list is a common practice in Python programming.

#+begin_src python
  myList.index('banana')
#+end_src

#+begin_example
  2
#+end_example

#+begin_src python
  myList[0]
#+end_src

#+begin_example
  'apple'
#+end_example

#+begin_src python
  myList[2]
#+end_src

#+begin_example
  'banana'
#+end_example

#+begin_src python
  myList[50]
#+end_src

#+begin_example
  ---------------------------------------------------------------------------

  IndexError                                Traceback (most recent call last)

  <ipython-input-16-a8ca54ea4e9e> in <module>()
  ----> 1 myList[50]


  IndexError: list index out of range
#+end_example

#+begin_src python
  myList[-5]
#+end_src

#+begin_example
  ---------------------------------------------------------------------------

  IndexError                                Traceback (most recent call last)

  <ipython-input-17-6056870ef1ce> in <module>()
  ----> 1 myList[-5]


  IndexError: list index out of range
#+end_example

#+begin_src python
  myList[0:4]
#+end_src

#+begin_example
  ['apple', 'orange', 'banana', 'apple']
#+end_example

#+begin_src python
  myList[:4]
#+end_src

#+begin_example
  ['apple', 'orange', 'banana', 'apple']
#+end_example

#+begin_src python
  myList[2:]
#+end_src

#+begin_example
  ['banana', 'apple']
#+end_example

** For Loops
   :PROPERTIES:
   :CUSTOM_ID: for-loops
   :END:
A =for= loop can allow us to do something with every item in our list:

#+begin_src python
  for thing in myList: 
      print(thing + "s are delicious")
#+end_src

#+begin_example
  apples are delicious
  oranges are delicious
  bananas are delicious
  apples are delicious
#+end_example

** Dictionaries
:PROPERTIES:
   :CUSTOM_ID: dictionaries
   :END:

Dictionaries are pairs of /keys/ and /values/. A /key/ is used to retrieve a /value/. For example, if I have a dictionary called =fruit=, which represents, say, the amount of fruit I have in my refrigerator at home, it will look like this:

#+begin_src python
  fruit = {"apples": 5, "kiwi": 2, "bananas": 50}
#+end_src

Now I can do some things with this dictionary, like get keys out of it, and their associated values.

#+begin_src python
  # Go through each key in `fruit` and call it `f`
  for f in fruit: 
      # Then build up a string using that key (f, the name of the fruit), and its 
      # associated value, `fruit[f]`, representing the number of fruits that I have. 
      # Note that since `fruit[f]` is actually an integer, we have to turn it into
      # a string first using the `str()` function. 
      print("I Have " + str(fruit[f]) + " " + f + " and they are really delicious!")
#+end_src

#+begin_example
  I Have 5 apples and they are really delicious!
  I Have 2 kiwi and they are really delicious!
  I Have 50 bananas and they are really delicious!
#+end_example

Note that =f= is just an arbitrary symbol. It can be anything. I can even call this =thingy= if I want. It just means "what I'm going to call the thing when I'm at its point in the loop."

Here's another way of building up a string, using the =.format()= string method:

#+begin_src python
  for thingy in fruit: 
      print("I have {} {} and they are really delicious!".format(fruit[f], thingy))
#+end_src

#+begin_example
  I have 50 apples and they are really delicious!
  I have 50 kiwi and they are really delicious!
  I have 50 bananas and they are really delicious!
#+end_example

*** Getting stuff out of dictionaries
    :PROPERTIES:
    :CUSTOM_ID: getting-stuff-out-of-dictionaries
    :END:
One of the most important things we need to know is how to get stuff out of dictionaries. How many bananas do we have?

#+begin_src python
  fruit['bananas']
#+end_src

#+begin_example
  50
#+end_example

Now what if, instead of a single number for a value, we have a list of numbers?

#+begin_src python
  fruit = {"apples": [3, 4, 5], "kiwi": [2], "bananas": 100}
#+end_src

Then we can index that list after we get the list from the dictionary, by chaining these indices:

#+begin_src python
  fruit['apples'][2]
#+end_src

#+begin_example
  5
#+end_example

*** Putting stuff in dictionaries
    :PROPERTIES:
    :CUSTOM_ID: putting-stuff-in-dictionaries
    :END:
We can also create a new item, and assign a value to it, like this:

#+begin_src python
  fruit['cherries'] = [8, 3]
#+end_src

#+begin_src python
  fruit
#+end_src

#+begin_example
  {'apples': [3, 4, 5], 'bananas': 100, 'cherries': [8, 3], 'kiwi': [2]}
#+end_example

** Application: lists of words
   :PROPERTIES:
   :CUSTOM_ID: application-lists-of-words
   :END:
Imagine we have a list that we created by splitting a string:

#+begin_src python
  franklin = "The poor ill-used Indians have been most unjustly put in prison"
#+end_src

#+begin_src python
  franklin = franklin.split()
#+end_src

#+begin_src python
  franklin
#+end_src

#+begin_example
  ['The',
   'poor',
   'ill-used',
   'Indians',
   'have',
   'been',
   'most',
   'unjustly',
   'put',
   'in',
   'prison']
#+end_example

We can run a =for= loop over it, just like we would with any list. What if we want to shout each word, for instance?

#+begin_src python
  for word in franklin: 
      print(word.upper() + '!!!!!!!!')
#+end_src

#+begin_example
  THE!!!!!!!!
  POOR!!!!!!!!
  ILL-USED!!!!!!!!
  INDIANS!!!!!!!!
  HAVE!!!!!!!!
  BEEN!!!!!!!!
  MOST!!!!!!!!
  UNJUSTLY!!!!!!!!
  PUT!!!!!!!!
  IN!!!!!!!!
  PRISON!!!!!!!!
#+end_example
