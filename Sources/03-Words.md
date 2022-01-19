* Words, Tokens, Stems, Lemmas
  :PROPERTIES:
  :CUSTOM_ID: words-tokens-stems-lemmas
  :END:
** and the NLTK
   :PROPERTIES:
   :CUSTOM_ID: and-the-nltk
   :END:
The NLTK is the Python Natural Language (processing) ToolKit. To use it, we import the package like this:

#+begin_src python
  import nltk
#+end_src

In addition to importing the NLTK, we also need to make sure to download the language models for English.

#+begin_src python
  nltk.download('book')
#+end_src

Also, make sure that we're in the directory where =moonstone.md= exists, or else we won't be able to load the file.

#+begin_src python
  %cd ..
#+end_src

#+begin_example
  /home/jon/Code/course-computational-literary-analysis
#+end_example

This will likely be different on your system, so don't just run this command blindly!

#+begin_src python
  %ls
#+end_src

#+begin_example
  [0m[01;34mHomework[0m/  [01;34mHW1[0m/  LICENSE  moonstone.md  [01;34mNotes[0m/  README.md
#+end_example

Note: as someone pointed out in the course chatroom, sometimes Windows doesn't load the file as unicode by default, so we have to tell it to do this explicitly:

#+begin_src python
  moonstoneRaw = open('moonstone.md', encoding="UTF-8").read()
#+end_src

Note that I've prepared my text ahead of time by marking the beginnings and ends of the Betteredge and Clack sections with =%%%%%=. (This is an arbitrary mark, and doesn't really mean anything.) This allows me to split the text like this:

#+begin_src python
  moonstoneParts = moonstoneRaw.split('%%%%%')
#+end_src

#+begin_src python
  len(moonstoneParts)
#+end_src

#+begin_example
  5
#+end_example

What's the second part look like?

#+begin_src python
  print(moonstoneParts[1][:500])
#+end_src

#+begin_example
  ### Chapter I

  In the first part of ROBINSON CRUSOE, at page one hundred and
  twenty-nine, you will find it thus written:

  “Now I saw, though too late, the Folly of beginning a Work before we
  count the Cost, and before we judge rightly of our own Strength to go
  through with it.”

  Only yesterday, I opened my ROBINSON CRUSOE at that place. Only this
  morning (May twenty-first, Eighteen hundred and fifty), came my lady’s
  nephew, Mr. Franklin Blake, and held a short conversation with me, as
  follows:
#+end_example

Yep, that's Betteredge. Now how about the fourth part?

#+begin_src python
  print(moonstoneParts[3][:500])
#+end_src

#+begin_example
  ### Chapter I

  I am indebted to my dear parents (both now in heaven) for having had
  habits of order and regularity instilled into me at a very early age.

  In that happy bygone time, I was taught to keep my hair tidy at all
  hours of the day and night, and to fold up every article of my clothing
  carefully, in the same order, on the same chair, in the same place at
  the foot of the bed, before retiring to rest. An entry of the day’s
  events in my little diary invariably preceded the folding up. Th
#+end_example

And that's certainly Miss Clack. Let's assign these both to variables.

#+begin_src python
  betteredge = moonstoneParts[1]
  clack = moonstoneParts[3]
#+end_src

** Tokens and Tokenizing
   :PROPERTIES:
   :CUSTOM_ID: tokens-and-tokenizing
   :END:
Tokens are word-like objects. Punctuation marks and parts of words, like "ca" and "n't" are also considered tokens by some tokenizers. Let's make a test sentence, and try to tokenize it.

#+begin_src python
  testSentence = """
  I am indebted to my dear parents (both now in heaven) 
  for having had habits of order and regularity 
  instilled into me at a very early age."""
#+end_src

#+begin_src python
  print(testSentence)
#+end_src

#+begin_example
  I am indebted to my dear parents (both now in heaven) 
  for having had habits of order and regularity 
  instilled into me at a very early age.
#+end_example

We'll use the nltk function =word_tokenize()=:

#+begin_src python
  nltk.word_tokenize(testSentence)
#+end_src

#+begin_example
  ['I',
   'am',
   'indebted',
   'to',
   'my',
   'dear',
   'parents',
   '(',
   'both',
   'now',
   'in',
   'heaven',
   ')',
   'for',
   'having',
   'had',
   'habits',
   'of',
   'order',
   'and',
   'regularity',
   'instilled',
   'into',
   'me',
   'at',
   'a',
   'very',
   'early',
   'age',
   '.']
#+end_example

How many tokens did it find?

#+begin_src python
  len(nltk.word_tokenize(testSentence))
#+end_src

#+begin_example
  30
#+end_example

Let's try another sentence.

#+begin_src python
  nltk.word_tokenize("An entry of the day’s events in my little diary invariably preceded the folding up.")
#+end_src

#+begin_example
  ['An',
   'entry',
   'of',
   'the',
   'day',
   '’',
   's',
   'events',
   'in',
   'my',
   'little',
   'diary',
   'invariably',
   'preceded',
   'the',
   'folding',
   'up',
   '.']
#+end_example

Notice what happens there with "day's"? What if our sentence contains a contraction?

#+begin_src python
  nltk.word_tokenize("I can't believe this!")
#+end_src

#+begin_example
  ['I', 'ca', "n't", 'believe', 'this', '!']
#+end_example

*** Stems and Stemming
    :PROPERTIES:
    :CUSTOM_ID: stems-and-stemming
    :END:
To stem a word, we first have to instantiate, or make a fresh copy of, our semmer object:

#+begin_src python
  stemmer = nltk.stem.LancasterStemmer()
#+end_src

Now let's test it on three different forms of the same stem:

#+begin_src python
  for word in ["believe", "belief", "believing"]:
      print(stemmer.stem(word))
#+end_src

#+begin_example
  believ
  believ
  believ
#+end_example

#+begin_src python
  stemmer.stem("believe")
#+end_src

#+begin_example
  'believ'
#+end_example

*** Lemmas and Lemmatizers
    :PROPERTIES:
    :CUSTOM_ID: lemmas-and-lemmatizers
    :END:
A lemma is the "dictionary form" of a word, so the lemma for "jumps" is "jump." Lemmatizing often doesn't transform the text as much as stemming. First, instantiate the lemmatizer:

#+begin_src python
  lemmatizer = nltk.stem.WordNetLemmatizer()
#+end_src

#+begin_src python
  lemmatizer.lemmatize("believe")
#+end_src

#+begin_example
  'believe'
#+end_example

#+begin_src python
  for word in ["believe", "belief", "believing"]:
      print(lemmatizer.lemmatize(word))
#+end_src

#+begin_example
  believe
  belief
  believing
#+end_example

#+begin_src python
  for word in ["happy", "happier", "happiest"]:
      print(lemmatizer.lemmatize(word))
#+end_src

#+begin_example
  happy
  happier
  happiest
#+end_example

#+begin_src python
  for word in ["jumps", "jumping", "jump"]:
      print(lemmatizer.lemmatize(word))
#+end_src

#+begin_example
  jump
  jumping
  jump
#+end_example

#+begin_src python
  testTokens = nltk.word_tokenize(testSentence)
#+end_src

*** Application: Comparing Miss Clack with Betteredge
    :PROPERTIES:
    :CUSTOM_ID: application-comparing-miss-clack-with-betteredge
    :END:
First, tokenize each text:

#+begin_src python
  clackTokens = nltk.word_tokenize(clack)
  betteredgeTokens = nltk.word_tokenize(betteredge)
#+end_src

Now compare the lengths of each:

#+begin_src python
  len(clackTokens), len(betteredgeTokens)
#+end_src

#+begin_example
  (36247, 94899)
#+end_example

Convert each token into its stem:

#+begin_src python
  clackStems = []
  for word in clackTokens: 
      stem = stemmer.stem(word)
      clackStems.append(stem)
#+end_src

#+begin_src python
  betteredgeStems = []
  for word in betteredgeTokens: 
      stem = stemmer.stem(word)
      betteredgeStems.append(stem)
#+end_src

Now let's create a word frequency table for each of these collections of stems.

#+begin_src python
  clackStemsDict = {}
  for stem in clackStems:
      # If our stem is not already in the dictionary, 
      # it has a frequency of one. 
      if stem not in clackStemsDict: 
          clackStemsDict[stem] = 1
      else: 
          # Otherwise, increase the count by one. 
          clackStemsDict[stem] = clackStemsDict[stem] + 1
#+end_src

#+begin_src python
  betteredgeStemsDict = {}
  for stem in betteredgeStems:
      # If our stem is not already in the dictionary, 
      # it has a frequency of one. 
      if stem not in betteredgeStemsDict: 
          betteredgeStemsDict[stem] = 1
      else: 
          betteredgeStemsDict[stem] = betteredgeStemsDict[stem] + 1
#+end_src

#+begin_src python
  len(clackTokens), len(betteredgeTokens)
#+end_src

#+begin_example
  (36247, 94899)
#+end_example

Let's compare the proportions of exclamation marks used by each. We're dividing by the total number of tokens in each, so that we're dealing with proportions, rather than raw counts:

#+begin_src python
  print(clackStemsDict['!'] / len(clackTokens)) 
  print(betteredgeStemsDict['!'] / len(betteredgeTokens))
#+end_src

#+begin_example
  0.0068419455403205785
  0.003530068809997998
#+end_example

Looks like Miss Clack uses exclamation point (!) about twice as much as Betteredge!!!

** Sentence Tokenization
   :PROPERTIES:
   :CUSTOM_ID: sentence-tokenization
   :END:
We can also tokenize by sentences instead of words

#+begin_src python
  betteredgeSents = nltk.sent_tokenize(betteredge)
  clackSents = nltk.sent_tokenize(clack)
#+end_src

#+begin_src python
  clackSents[:5]
#+end_src

#+begin_example
  [' \n\n### Chapter I\n\nI am indebted to my dear parents (both now in heaven) for having had\nhabits of order and regularity instilled into me at a very early age.',
   'In that happy bygone time, I was taught to keep my hair tidy at all\nhours of the day and night, and to fold up every article of my clothing\ncarefully, in the same order, on the same chair, in the same place at\nthe foot of the bed, before retiring to rest.',
   'An entry of the day’s\nevents in my little diary invariably preceded the folding up.',
   'The\n“Evening Hymn” (repeated in bed) invariably followed the folding up.',
   'And the sweet sleep of childhood invariably followed the “Evening Hymn.”\n\nIn later life (alas!)']
#+end_example

Let's see what some lengths of some sentences are:

#+begin_src python
  for sent in betteredgeSents[100:105]: 
      print(len(sent))
#+end_src

#+begin_example
  123
  100
  279
  80
  76
#+end_example

...and we can build up lists of sentence lengths for each character:

#+begin_src python
  clackSentenceLengths = []
  for sent in clackSents: 
      clackSentenceLengths.append(len(sent))
#+end_src

#+begin_src python
  betteredgeSentenceLengths = []
  for sent in betteredgeSents: 
      betteredgeSentenceLengths.append(len(sent))
#+end_src

Now we can find the average sentence length for each:

#+begin_src python
  sum(clackSentenceLengths)/len(clackSentenceLengths)
#+end_src

#+begin_example
  99.87649164677805
#+end_example

#+begin_src python
  sum(betteredgeSentenceLengths)/len(betteredgeSentenceLengths)
#+end_src

#+begin_example
  112.04363827549948
#+end_example
