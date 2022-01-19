* Word Frequencies, Distinctive Words
  :PROPERTIES:
  :CUSTOM_ID: word-frequencies-distinctive-words
  :END:
And an introduction to Pandas.

It's always a good idea to put all your import statements at the beginning of your notebook.

#+begin_src python
  # The Natural Language Processing Toolkit
  import nltk

  # We can rename long function names like this,
  # so that it's easier to type.
  from nltk import word_tokenize as tokenize
  from nltk import sent_tokenize as sentTokenize

  # This one is for counting things. 
  from collections import Counter

  # And here is the amazing data science library, Pandas.
  import pandas as pd

  # This magic command tells Jupyter to display plots (graphs) 
  # here in this notebook, and not elsewhere. 
  %matplotlib inline
#+end_src

Before, we tokenized a string with =nltk.word_tokenize()=. But now, we renamed this function to =tokenize()= in the =from ... import ... as= statement above, so now we can just run this:

#+begin_src python
  tokenize("The quick brown fox")
#+end_src

#+begin_example
  ['The', 'quick', 'brown', 'fox']
#+end_example

As usual, make sure we're in the right directory (i.e., the one with =moonstone.md= in it).

#+begin_src python
  %cd ..
#+end_src

#+begin_example
  /home/jon/Code/course-computational-literary-analysis
#+end_example

#+begin_src python
  %ls
#+end_src

#+begin_example
  [0m[01;34mHomework[0m/  LICENSE       ngram-pos-experiments.ipynb  README.md
  [01;34mHW1[0m/       moonstone.md  [01;34mNotes[0m/
#+end_example

#+begin_src python
  moonstone = open('/home/jon/Code/course-computational-literary-analysis/moonstone.md').read()
#+end_src

The NLTK tokenizer doesn't seem to be able to understand hyphenated words, so we can replace all hyphens with hyphens surrounded with spaces. This can allow the NLTK tokenizer to recognize words better if there is punctuation around it.

#+begin_src python
  moonstone = moonstone.replace('-', ' - ')
#+end_src

As before, we've edited the moonstone markdown file, adding these =%%%%%= markers to mark where narratives begin and end. This can allow us to extract certain narratives with these commands:

#+begin_src python
  moonstoneParts = moonstone.split('%%%%%')
#+end_src

#+begin_src python
  bet = moonstoneParts[1]
#+end_src

#+begin_src python
  betSentences = sentTokenize(bet)
#+end_src

#+begin_src python
  bet10sents = betSentences[:10]
#+end_src

#+begin_src python
  bet = moonstoneParts[1]
#+end_src

#+begin_src python
  clack = moonstoneParts[3]
#+end_src

#+begin_src python
  bruff = moonstoneParts[4]
#+end_src

#+begin_src python
  emsent = []
#+end_src

#+begin_src python
  type(emsent)
#+end_src

#+begin_example
  list
#+end_example

#+begin_src python
  emsent = []
#+end_src

#+begin_src python
  emsent.append('item')
#+end_src

#+begin_src python
  emsent
#+end_src

#+begin_example
  ['item']
#+end_example

#+begin_src python
  tokenize("this is a test!")
#+end_src

#+begin_example
  ['this', 'is', 'a', 'test', '!']
#+end_example

#+begin_src python
  "this is a test!".split()
#+end_src

#+begin_example
  ['this', 'is', 'a', 'test!']
#+end_example

#+begin_src python
  from nltk.stem import PorterStemmer
  from nltk.stem import WordNetLemmatizer
#+end_src

#+begin_src python
  stemmer = PorterStemmer()
  lemmatizer = WordNetLemmatizer()
#+end_src

#+begin_src python
  for word in ["inform", "information", "informative"]: 
      print(stemmer.stem(word))
#+end_src

#+begin_example
  inform
  inform
  inform
#+end_example

#+begin_src python
  for word in ["jump", "jumps", "jumping"]:
      print(lemmatizer.lemmatize(word))
#+end_src

#+begin_example
  jump
  jump
  jumping
#+end_example

Now we can tokenize them all:

#+begin_src python
  betTokens = tokenize(bet)
  clackTokens = tokenize(clack)
  bruffTokens = tokenize(bruff)
  moonstoneTokens = tokenize(moonstone)
#+end_src

** Functions
   :PROPERTIES:
   :CUSTOM_ID: functions
   :END:
Functions, like =for= loops, are good ways to do things repeatedly. We can run some task over a series of objects this way. Here's a simple function that multiplies a number by two:

#+begin_src python
  def timesTwo(inputNumber):
      numberTimesTwo = inputNumber * 2
      return numberTimesTwo
#+end_src

If we want, we can make this a little fancier, by checking to make sure that we get an integer passed to us first.

#+begin_src python
  def timesTwo(inputNumber):
      if type(inputNumber) is not int: 
          return "I don't want to multiply this by two, because it's not an integer," +\
                 "and I'm afraid of what might happen!!!!!!!!!!"
      numberTimesTwo = inputNumber * 2
      return numberTimesTwo
#+end_src

Now we can call the function we just made:

#+begin_src python
  timesTwo(5)
#+end_src

#+begin_example
  10
#+end_example

#+begin_src python
  timesTwo("Hello!")
#+end_src

#+begin_example
  "I don't want to multiply this by two, because it's not an integer,and I'm afraid of what might happen!!!!!!!!!!"
#+end_example

#+begin_src python
  "the the the the the the the that's all folks".count("the")
#+end_src

#+begin_example
  7
#+end_example

#+begin_src python
  porky = tokenize("the the the the the the the that's all folks")
#+end_src

#+begin_src python
  len(porky)
#+end_src

#+begin_example
  11
#+end_example

#+begin_src python
  7/11
#+end_src

#+begin_example
  0.6363636363636364
#+end_example

#+begin_src python
  name = "Rachel, Franklin, Godfrey".split(', ')
#+end_src

#+begin_src python
  len(name)
#+end_src

#+begin_example
  3
#+end_example

Functions are useful for running some series of tasks repeatedly on something. Let's say I have a list of numbers, and I was to multiply each by two:

#+begin_src python
  listOfNumbers = [3, 6, 9, 11, 2, 0]
#+end_src

#+begin_src python
  for number in listOfNumbers: 
      print(timesTwo(number))
#+end_src

#+begin_example
  6
  12
  18
  22
  4
  0
#+end_example

I can also write a function that returns =True= or =False=, which will then speak directly to an =if= statement later:

#+begin_src python
  def isDelicious(fruit): 
      if fruit == "apple": 
          return True
      else: 
          return False
#+end_src

#+begin_src python
  if isDelicious("kiwi"): 
      print("Yay! My kiwi is delicious!")
  else: 
      print("My kiwi is not delicious!!!!! Oh noes!!!!!")
#+end_src

#+begin_example
  My kiwi is not delicious!!!!! Oh noes!!!!!
#+end_example

Here's an example of a function that takes two inputs:

#+begin_src python
  def makeLovers(loverA, loverB): 
      return loverA + " and " + loverB + ", sitting in a tree, K-I-S-S-I-N-G"
#+end_src

#+begin_src python
  makeLovers('Rachel', 'Franklin')
#+end_src

#+begin_example
  'Rachel and Franklin, sitting in a tree, K-I-S-S-I-N-G'
#+end_example

** Word Frequencies
   :PROPERTIES:
   :CUSTOM_ID: word-frequencies
   :END:
Let's analyze the frequencies of the words in each narrative we've read so far. Now that we've tokenized each, we can lowercase each token, so that we're not paying attention to whether a word starts a sentence or not.

#+begin_src python
  clackTokensLower = []
  for token in clackTokens: 
      clackTokensLower.append(token.lower())
#+end_src

Or you can use a more advanced pattern, called a "list comprehension." The clackTokensLower line below is equivalent to the one in the cell above. It's just a shorter and nicer way of writing that.

#+begin_src python
  # Using list comprehensions
  clackTokensLower = [token.lower() for token in clackTokens]
  betTokensLower = [token.lower() for token in betTokens]
  bruffTokensLower = [token.lower() for token in bruffTokens]
  moonstoneTokensLower = [token.lower() for token in moonstoneTokens]
#+end_src

#+begin_src python
  clackTokensLower[:10]
#+end_src

#+begin_example
  ['#', '#', '#', 'chapter', 'i', 'i', 'am', 'indebted', 'to', 'my']
#+end_example

We can use the =Counter()= object we imported above from the =collections= module to count anything in a list, like our list of lowercased tokens.

#+begin_src python
  clackCounts = Counter(clackTokensLower)
  betCounts = Counter(betTokensLower)
  bruffCounts = Counter(bruffTokensLower)
  moonstoneCounts = Counter(moonstoneTokensLower)
#+end_src

Let's try it out. How many times does Miss Clack use exclamation points?

#+begin_src python
  clackCounts['!']
#+end_src

#+begin_example
  248
#+end_example

Betteredge? Bruff?

#+begin_src python
  betCounts['!']
#+end_src

#+begin_example
  335
#+end_example

#+begin_src python
  moonstoneCounts['!']
#+end_src

#+begin_example
  992
#+end_example

Now let's build up a dictionary where we compare the relative proportions of words in Clack's narrative and in Betteredge's narrative.

#+begin_src python
  clacknesses = {}
  for word in clackCounts: 
      # How many times does Miss Clack use this word? 
      clackCount = clackCounts[word]
      
      # Adjust for the number of words in Miss Clack's narrative. 
      clackProportion = clackCount / len(clackTokensLower)
      
      # How many times does Betteredge use this word?

      # Instead of indexing the word directly, which 
      # would fail if the word isn't in our dictionary, 
      # we can use the dictionary `.get()` method, which allows
      # us to say what we want it to return if the word isn't in the 
      # dictionary (in this case, 0). 
      betCount = betCounts.get(word, 0)
      betProportion = betCount / len(betTokensLower)
      
      # Define "clackness" as the difference in proportions
      # between Clack's and Betteredge's narratives
      clackness = (clackProportion - betProportion)*100
      #print(word, clackness)
      clacknesses[word] = clackness
#+end_src

Now we can sort the dictionary, and print out the top 20 words with highest scores for "Clackness":

#+begin_src python
  clacknessesSorted = sorted(clacknesses, key=clacknesses[1], reverse=True)
  for word in clacknessesSorted[:20]: 
      print(word, clacknesses[word])
#+end_src

#+begin_example
  i 0.4429010077119939
  ! 0.3274994929197816
  my 0.30563630809693193
  godfrey 0.2840785409841493
  aunt 0.2517972218755506
  dear 0.22362791586109432
  ablewhite 0.20260033138523487
  which 0.19439841508607547
  . 0.1793568699493528
  me 0.16722308784032766
  ? 0.1664868114811185
  bruff 0.14715259442612658
  rachel 0.13792359136233168
  be 0.1358510308172969
  clack 0.133266731488864
  to 0.13055750276120756
  not 0.11583947816151018
  by 0.11576953929629424
  is 0.11332884057165499
  of 0.10531846752790189
#+end_example

** Word Frequencies as a Pandas Data Frame
   :PROPERTIES:
   :CUSTOM_ID: word-frequencies-as-a-pandas-data-frame
   :END:
That was the long way of doing it. Now here is a slightly easier way, using Pandas. First, make a new Pandas DataFrame object, and give it a list of all of our counts. I'm also giving it some labels, so that the table is easier to read.

#+begin_src python
  frequencies = pd.DataFrame([clackCounts, betCounts, bruffCounts, moonstoneCounts], 
                            index = ['Clack', 'Betteredge', 'Bruff', 'All'])
#+end_src

Since Pandas doesn't know how to handle words that are not in a particular dictionary, it calls them "NaN" or "not a number." We know that if a word isn't in a dictionary, it doesn't appear in that character's narrative, so we can replace these with zero (and that will make our calculations easier below).

#+begin_src python
  frequencies = frequencies.fillna(0)
#+end_src

Transpose it! Just because columns are easier to work with than rows.

#+begin_src python
  frequencies = frequencies.T
#+end_src

We can divide by the total number of tokens in each speaker to transform the raw counts into proportions of counts. We can multiply this by 100 to make it a little easier to read (and to make it seem more like a percentage).

#+begin_src python
  frequencies['clackP'] = (frequencies['Clack'] / len(clackTokens)) * 100
  frequencies['betP'] = (frequencies['Betteredge'] / len(betTokens)) * 100
  frequencies['bruffP'] = (frequencies['Bruff'] / len(bruffTokens)) * 100
  frequencies['allP'] = (frequencies['All'] / len(moonstoneTokens)) * 100
#+end_src

Now we can define the distinctiveness of certain words among characters by looking at how much more they say a certain word than the average for the text:

#+begin_src python
  frequencies['clackness'] = frequencies['clackP'] - frequencies['allP']
  frequencies['bruffness'] = frequencies['bruffP'] - frequencies['allP']
#+end_src

Sorting for "bruffness," for instance, we see the words distinctive of bruff:

#+begin_src python
  frequencies.sort_values('bruffness', ascending=False)
#+end_src

#+begin_html
  <style>
      .dataframe thead tr:only-child th {
          text-align: right;
      }

      .dataframe thead th {
          text-align: left;
      }

      .dataframe tbody tr th {
          vertical-align: top;
      }
  </style>
#+end_html

#+begin_html
  <table border="1" class="dataframe">
#+end_html

#+begin_html
  <thead>
#+end_html

#+begin_html
  <tr style="text-align: right;">
#+end_html

#+begin_html
  <th>
#+end_html

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

Clack

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

Betteredge

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

Bruff

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

All

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

clackP

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

betP

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

bruffP

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

allP

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

clackness

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

bruffness

#+begin_html
  </th>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  </thead>
#+end_html

#+begin_html
  <tbody>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

of

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

854.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2135.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

395.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

5603.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.329578

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.224260

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3.246220

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.370296

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.040718

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.875924

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

the

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1592.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

4838.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

671.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

12166.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

4.342726

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

5.040266

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

5.514464

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

5.146710

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.803984

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.367754

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

had

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

294.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

803.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

141.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1959.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.801986

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.836572

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.158777

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.828736

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.026750

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.330041

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

to

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1084.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2713.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

391.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

6955.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.956982

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.826424

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3.213346

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.942247

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.014735

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.271100

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

was

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

350.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

958.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

149.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2353.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.954745

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.998052

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.224523

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.995414

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.040669

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.229109

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

that

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

377.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1069.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

164.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2647.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.028397

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.113692

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.347798

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.119788

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.091391

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.228009

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

i

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

943.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2044.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

326.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

5818.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.572356

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.129455

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.679158

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.461249

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.111107

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.217909

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

indians

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

6.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

52.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

32.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

120.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016367

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.054174

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.262985

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.050765

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.034398

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.212220

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

verinder

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

64.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

73.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

40.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

291.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.174582

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.076052

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.328731

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.123105

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.051477

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.205626

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

would

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

67.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

119.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

44.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

391.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.182765

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.123975

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.361604

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.165409

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.017357

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.196195

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

in

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

626.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1674.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

234.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

4092.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.707630

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.743986

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.923077

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.731082

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.023452

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.191995

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

indian

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

6.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

38.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

28.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

91.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016367

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.039589

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.230112

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.038497

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.022130

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.191615

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

their

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

31.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

135.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

36.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

268.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.084563

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.140644

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.295858

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.113375

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.028812

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.182483

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

they

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

41.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

207.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

43.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

405.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.111842

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.215654

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.353386

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.171331

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.059490

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.182055

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

which

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

174.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

269.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

73.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

988.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.474645

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.280246

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.599934

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.417964

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.056681

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.181970

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

his

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

205.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

566.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

94.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1447.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.559208

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.589663

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.772518

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.612140

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.052932

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.160379

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

luker

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

41.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

7.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

24.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

122.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.111842

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007293

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.197239

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.051611

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.060231

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.145628

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

be

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

185.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

354.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

68.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

994.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.504651

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.368800

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.558843

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.420502

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.084149

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.138341

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

murthwaite

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

21.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

19.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

47.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.021878

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.156147

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.019883

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.019883

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.136264

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

moonstone

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

22.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

65.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

25.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

167.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.060013

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.067718

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.205457

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.070648

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.010635

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.134809

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

will

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

98.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

180.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

42.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

513.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.267329

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.187525

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.345168

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.217020

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.050309

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.128148

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

her

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

331.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

828.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

98.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1611.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.902916

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.862617

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.805391

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.681518

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.221398

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.123873

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

it

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

351.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

970.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

139.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2409.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.957473

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.010554

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.142341

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.019105

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.061632

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.123236

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

office

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

15.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

27.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.005456

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003125

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.123274

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.011422

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.005966

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.111852

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

first

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

34.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

133.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

31.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

342.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.092747

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.138560

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.254767

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.144680

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.051933

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.110087

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

him

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

129.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

383.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

62.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

953.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.351892

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.399012

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.509533

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.403158

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.051266

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.106376

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

at

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

220.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

558.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

92.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1555.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.600125

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.581329

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.756082

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.657828

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.057702

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.098254

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

money

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

4.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

33.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

16.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

82.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.010911

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.034380

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.131492

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.034689

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.023778

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.096803

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

mr.

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

242.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

609.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

91.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1550.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.660138

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.634461

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.747863

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.655713

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004425

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.092151

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

position

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

14.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

11.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

15.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

74.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.038190

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.011460

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.123274

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.031305

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006885

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.091969

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

...

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

...

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

got

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

18.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

127.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

4.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

241.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.049101

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.132310

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.032873

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.101953

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.052852

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.069080

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

from

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

117.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

280.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

29.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

746.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.319158

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.291706

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.238330

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.315588

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003569

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.077258

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

door

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

32.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

83.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

224.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.087291

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.086470

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016437

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.094761

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.007470

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.078325

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

;

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

124.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

420.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

39.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

945.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.338253

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.437559

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.320513

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.399773

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.061521

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.079260

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

again

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

47.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

144.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

9.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

366.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.128209

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.150020

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.073964

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.154833

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.026624

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.080868

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

your

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

104.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

268.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

26.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

707.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.283696

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.279204

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.213675

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.299090

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.015394

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.085414

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

there

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

57.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

238.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

17.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

539.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.155487

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.247950

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.139711

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.228019

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.072532

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.088308

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

rachel

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

130.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

208.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

13.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

465.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.354620

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.216696

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.106838

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.196714

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.157906

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.089876

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

as

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

216.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

825.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

80.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1771.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.589214

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.859491

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.657462

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.749205

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.159991

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.091742

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

our

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

46.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

144.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

272.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.125481

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.150020

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016437

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.115067

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.010414

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.098630

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

room

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

73.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

123.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

8.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

393.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.199133

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.128142

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.065746

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.166255

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.032878

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.100509

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

rosanna

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

206.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

241.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.214612

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.101953

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.101953

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.101953

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

cuff

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

186.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

248.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002728

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.193776

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.104914

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.102186

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.104914

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

said

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

124.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

383.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

30.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

845.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.338253

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.399012

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.246548

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.357469

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.019217

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.110921

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

betteredge

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

120.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

324.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002728

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.125017

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016437

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.137065

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.134337

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.120629

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

t

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

105.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

309.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

18.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

635.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.286424

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.321919

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.147929

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.268631

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.017793

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.120702

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

she

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

267.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

617.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

45.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1194.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.728334

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.642795

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.369822

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.505110

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.223224

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.135288

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

a

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

569.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1498.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

162.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3467.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.552143

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.560628

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.331361

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.466681

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.085461

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.135320

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

“

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

481.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1212.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

139.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3057.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.312093

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.262671

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.142341

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.293235

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.018858

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.150894

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

”

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

481.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1212.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

139.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3057.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.312093

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.262671

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.142341

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.293235

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.018858

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.150894

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

franklin

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

23.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

387.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

7.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

526.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.062740

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.403180

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.057528

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.222519

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.159779

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.164991

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

out

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

54.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

343.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

10.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

626.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.147304

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.357340

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.082183

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.264823

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.117520

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.182641

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

'

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

369.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1191.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

108.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2546.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.006574

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.240793

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.887574

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.077061

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.070487

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.189487

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

!

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

248.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

335.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

27.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

992.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.676505

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.349006

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.221893

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.419656

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.256849

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.197763

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

sergeant

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

4.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

385.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

496.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.010911

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.401096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.209828

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.198917

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.209828

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

and

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

653.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1945.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

200.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

4447.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.781282

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2.026316

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.643655

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.881261

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.099979

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.237606

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

you

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

333.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

806.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

92.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2435.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.908372

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.839697

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.756082

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1.030104

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.121732

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.274022

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

,

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

2107.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

6281.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

707.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

14413.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

5.747565

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

6.543594

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

5.810322

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

6.097282

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.349717

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.286960

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

-

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

215.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

549.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

26.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1261.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.586486

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.571952

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.213675

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.533454

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.053032

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.319779

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

.

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1391.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3470.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

411.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

8819.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3.794430

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3.615073

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3.377712

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3.730794

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.063636

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.353082

#+begin_html
  </td>
#+end_html

#+begin_html
  </tr>
#+end_html

#+begin_html
  </tbody>
#+end_html

#+begin_html
  </table>
#+end_html

#+begin_html
  <p>
#+end_html

10821 rows × 10 columns

#+begin_html
  </p>
#+end_html

Notice that =.= is token which is the least distinctive of Bruff. Is this because he has longer sentences? Let's test that theory. Here I'll create a list of sentence lengths.

#+begin_src python
  bruffSentLens = [len(sent) for sent in nltk.sent_tokenize(bruff)]
#+end_src

...and then find the average of all of them.

#+begin_src python
  sum(bruffSentLens)/len(bruffSentLens)
#+end_src

#+begin_example
  124.6065934065934
#+end_example

Since this is something I'm going to want to do repeatedly, I can abstract this into a function:

#+begin_src python
  def averageSentLen(text): 
      sentLengths = [len(sent) for sent in nltk.sent_tokenize(text)]
      return sum(sentLengths)/len(sentLengths)
#+end_src

#+begin_src python
  averageSentLen(bruff)
#+end_src

#+begin_example
  124.6065934065934
#+end_example

#+begin_src python
  averageSentLen(clack)
#+end_src

#+begin_example
  100.13305489260144
#+end_example

#+begin_src python
  averageSentLen(bet)
#+end_src

#+begin_example
  112.3322818086225
#+end_example

Yep. Bruff has the longest sentences of anyone, so far.
