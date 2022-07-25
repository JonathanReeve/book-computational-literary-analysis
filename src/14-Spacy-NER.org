#+begin_src python
  import spacy
  from collections import Counter
  import pandas as pd
  import numpy as np
  %matplotlib inline
#+end_src

* Introduction to SpaCy
  :PROPERTIES:
  :CUSTOM_ID: introduction-to-spacy
  :END:
SpaCy is a natural language processing library, similar to the NLTK in some respects, but with many notable differences. - Where the NLTK is meant for teaching and learning natural language processing, SpaCy is designed for industrial applications (i.e. designed for speed and accuracy, not necessarily ease-of-use). - Instead of performing each function separately (=word_tokenize=, =pos_tag=, =lemmatize=), SpaCy does everything all at once. This has advantages and disadvantages. For example, processing with SpaCy takes a long time. But once a text is processed, no further processing is necessary---it just becomes a matter of accessing the data that's already there. - Because SpaCy stores a /lot/ of data about each text, this can easily lead to memory overflow errors. An easy way around this is to break the text up into individual parts, and to use functions wherever possible, to limit the amount of data stored in memory. It helps if you have a computer with a lot of RAM. You can also randomly sample chunks of text (like 1000-word chunks) at a time, and then take the average of all your random trials at the end. - While the NLTK's natural language processing is deterministic (built on human understanding of how language works), it's not quite as accurate as SpaCy's probabilistic (built on machine understanding of language) approach.

At the moment, SpaCy is the fastest, and almost the most accurate parser available.

First, load your language model, and store it as the variable =nlp=, which can then be run as a function:

#+begin_src python
  nlp = spacy.load('en_core_web_lg')
#+end_src

Now let's get a text to play around with. We'll use the first narrative from /The Moonstone/.

#+begin_src python
  moonstone = open('../moonstone.md').read()
#+end_src

#+begin_src python
  moonstoneParts = moonstone.split('%%%%%')
#+end_src

#+begin_src python
  bet = moonstoneParts[1]
#+end_src

Process it using SpaCy:

#+begin_src python
  moonstoneDoc = nlp(bet)
#+end_src

*** Exploring our SpaCy Doc
    :PROPERTIES:
    :CUSTOM_ID: exploring-our-spacy-doc
    :END:
Now we can start to explore what we can do with the resulting Doc object:

#+begin_src python
  type(moonstoneDoc)
#+end_src

#+begin_example
  spacy.tokens.doc.Doc
#+end_example

Verify that SpaCy has successfully parsed it:

#+begin_src python
  moonstoneDoc.is_parsed
#+end_src

#+begin_example
  True
#+end_example

Here are some things that we can do with this object:

#+begin_src python
  [method for method in dir(moonstoneDoc) if not method.startswith('_')]
#+end_src

#+begin_example
  ['cats',
   'char_span',
   'count_by',
   'doc',
   'ents',
   'extend_tensor',
   'from_array',
   'from_bytes',
   'from_disk',
   'get_extension',
   'get_lca_matrix',
   'has_extension',
   'has_vector',
   'is_parsed',
   'is_tagged',
   'mem',
   'merge',
   'noun_chunks',
   'noun_chunks_iterator',
   'print_tree',
   'sentiment',
   'sents',
   'set_extension',
   'similarity',
   'tensor',
   'text',
   'text_with_ws',
   'to_array',
   'to_bytes',
   'to_disk',
   'user_data',
   'user_hooks',
   'user_span_hooks',
   'user_token_hooks',
   'vector',
   'vector_norm',
   'vocab']
#+end_example

We can also get the length (in tokens) of the text:

#+begin_src python
  len(moonstoneDoc)
#+end_src

#+begin_example
  103519
#+end_example

SpaCy allows us to iterate over the text's words, as if the Doc were a list of tokens:

#+begin_src python
  for word in moonstoneDoc[40:50]:
      print(word)
#+end_src

#+begin_example
  late
  ,
  the
  Folly
  of
  beginning
  a
  Work
  before
  we
#+end_example

We can get a single word, too, so that we can do things with that individual word (token):

#+begin_src python
  written = moonstoneDoc[30]
  written
#+end_src

#+begin_example
  written
#+end_example

*** Exploring SpaCy Words
    :PROPERTIES:
    :CUSTOM_ID: exploring-spacy-words
    :END:
SpaCy words are /objects/, rather than strings, and so they contain a lot of information that can be accessed via their many methods. Here are a few things you can do with them:

#+begin_src python
  [method for method in dir(written) if not method.startswith('_')]
#+end_src

#+begin_example
  ['ancestors',
   'check_flag',
   'children',
   'cluster',
   'conjuncts',
   'dep',
   'dep_',
   'doc',
   'ent_id',
   'ent_id_',
   'ent_iob',
   'ent_iob_',
   'ent_type',
   'ent_type_',
   'get_extension',
   'has_extension',
   'has_vector',
   'head',
   'i',
   'idx',
   'is_alpha',
   'is_ancestor',
   'is_ascii',
   'is_bracket',
   'is_digit',
   'is_left_punct',
   'is_lower',
   'is_oov',
   'is_punct',
   'is_quote',
   'is_right_punct',
   'is_sent_start',
   'is_space',
   'is_stop',
   'is_title',
   'is_upper',
   'lang',
   'lang_',
   'left_edge',
   'lefts',
   'lemma',
   'lemma_',
   'lex_id',
   'like_email',
   'like_num',
   'like_url',
   'lower',
   'lower_',
   'n_lefts',
   'n_rights',
   'nbor',
   'norm',
   'norm_',
   'orth',
   'orth_',
   'pos',
   'pos_',
   'prefix',
   'prefix_',
   'prob',
   'rank',
   'right_edge',
   'rights',
   'sent_start',
   'sentiment',
   'set_extension',
   'shape',
   'shape_',
   'similarity',
   'string',
   'subtree',
   'suffix',
   'suffix_',
   'tag',
   'tag_',
   'text',
   'text_with_ws',
   'vector',
   'vector_norm',
   'vocab',
   'whitespace_']
#+end_example

You can get the word's POS (as in the NLTK's =pos_tag()= function), like this:

#+begin_src python
  written.tag_
#+end_src

#+begin_example
  'VBN'
#+end_example

Or a less specific tag (=VERB=, =NOUN=, =PUNCT=, etc.), like this:

#+begin_src python
  written.pos_
#+end_src

#+begin_example
  'VERB'
#+end_example

(=.tag= and =.pos=, without the underscores, are numeric representations of these. You can use those if you don't care about human readability, and want your code to be a little faster.)

You can also get the lemma for the word, which is its "dictionary form":

#+begin_src python
  written.lemma_
#+end_src

#+begin_example
  'write'
#+end_example

The =.i= property contains the index of the token. For instance, this "written" is the 30th token:

#+begin_src python
  written.i
#+end_src

#+begin_example
  30
#+end_example

With punctuation, like this comma, you can see how the =.tag= and the =.pos= properties differ:

#+begin_src python
  moonstoneDoc[41].tag_
#+end_src

#+begin_example
  ','
#+end_example

#+begin_src python
  moonstoneDoc[41].pos_
#+end_src

#+begin_example
  'PUNCT'
#+end_example

One caveat: the word /object/ is distinct from the word's string, so to count these, or otherwise treat them as strings, we first have to extract their text:

#+begin_src python
  type(written)
#+end_src

#+begin_example
  spacy.tokens.token.Token
#+end_example

#+begin_src python
  written.text
#+end_src

#+begin_example
  'written'
#+end_example

And sometimes that text contains whitespace, so we might also have to run =written.text.strip()=, which takes out leading and trailing whitespace.

*** Named Entity Recognition
    :PROPERTIES:
    :CUSTOM_ID: named-entity-recognition
    :END:
Named entity recognition, or NER, is a subfield of natual language processing that deals with the automatic identification of people, places, things, and other related "names." This sometimes includes numbers, dates, and other things. You can tell whether a word is a named entity, and if so, what type of entity it is, like this:

#+begin_src python
  written.ent_type_
#+end_src

#+begin_example
  ''
#+end_example

Explore the types of entities in the first 500 words of /The Moonstone/:

#+begin_src python
  for word in moonstoneDoc[50:150]: 
      if len(word.text.strip()) > 0 and len(word.ent_type_) > 0: 
          print(word.text.strip(), ':', word.ent_type_)
#+end_src

#+begin_example
  Only : DATE
  yesterday : DATE
  ROBINSON : ORG
  CRUSOE : PRODUCT
  this : TIME
  morning : TIME
  May : DATE
  twenty : DATE
  - : DATE
  first : DATE
  Eighteen : CARDINAL
  hundred : CARDINAL
  and : CARDINAL
  fifty : CARDINAL
  Franklin : PERSON
  Blake : PERSON
  Betteredge : PERSON
  Franklin : PERSON
#+end_example

As you can see, it gets somethings wrong (it thinks "Robinson Crusoe" is an organization and a product, respectively), but it gets a lot right. We can extract places like this:

#+begin_src python
  for word in moonstoneDoc[:2000]: 
      if len(word.ent_type_) > 0: 
          if word.ent_type_ == 'GPE': 
              print(word)
#+end_src

#+begin_example
  Yorkshire
  India


  Yorkshire
#+end_example

And times like this:

#+begin_src python
  for word in moonstoneDoc[:2000]: 
      if len(word.ent_type_) > 0: 
          if word.ent_type_ == 'TIME': 
              print(word)
#+end_src

#+begin_example
  this


  morning
  twelve
  hours
  Two
  hours
  the
  morning
  the
  evening
#+end_example

Alternatively, we can write this as a list comprehension:

#+begin_src python
  times = [word.text for word in moonstoneDoc if word.ent_type_ == 'TIME']
#+end_src

#+begin_src python
  type(times)
#+end_src

#+begin_example
  list
#+end_example

We can count our list of times, put this into a Pandas Series, and plot them, to try to show what kinds of times occur most often in Betteredge's narrative:

#+begin_src python
  pd.Series(Counter(times))[['dawn', 'morning', 'afternoon', 'noon',
                             'evening', 'night']].plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f9bbe8cddd8>
#+end_example

#+caption: png
[[file:14-Spacy-NER_files/14-Spacy-NER_50_1.png]]

We can also do this with "o'clock" times:

#+begin_src python
  pd.Series(Counter(times))[['one', 'two', 'three', 'four', 'five', 'six',
                             'seven', 'eight', 'nine', 'ten', 'eleven',
                             'twelve']].plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f9bbe796fd0>
#+end_example

#+caption: png
[[file:14-Spacy-NER_files/14-Spacy-NER_52_1.png]]

And we can also see how frequently times and dates occur in narrative time. We could either do this the way we've learned, by turning it into a binary representation, and splitting it:

#+begin_src python
  binary = np.array([1 if word.ent_type_ == 'TIME' else 0 for word in moonstoneDoc])
  split = np.array_split(binary, 20)
  pd.Series(split).sum().plot()
#+end_src

Or we could do this a slightly different way:

#+begin_src python
  times = pd.Series(np.histogram([word.i for word in moonstoneDoc if word.ent_type_ == 'TIME'], bins=50)[0])
  times.plot()
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f9b9fe0a898>
#+end_example

#+caption: png
[[file:14-Spacy-NER_files/14-Spacy-NER_56_1.png]]

#+begin_src python
  dates = pd.Series(np.histogram([word.i for word in moonstoneDoc if word.ent_type_ == 'DATE'], bins=50)[0])
  dates.plot()
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f9ba4389080>
#+end_example

#+caption: png
[[file:14-Spacy-NER_files/14-Spacy-NER_57_1.png]]

These seem to happen with an interesting regularity. Do they correlate with chapter headings?

#+begin_src python
  chaps = pd.Series(np.histogram([word.i for word in moonstoneDoc if word.text.strip().lower() == 'chapter'], bins=50)[0])
  chaps.plot()
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f9ba4371d30>
#+end_example

#+caption: png
[[file:14-Spacy-NER_files/14-Spacy-NER_59_1.png]]

#+begin_src python
  datesNormed = dates/np.linalg.norm(dates) # Normalize, kind of
  chapsNormed = chaps/np.linalg.norm(chaps)
  timesNormed = times/np.linalg.norm(times)
  df = pd.DataFrame([datesNormed, chapsNormed], index=['dates', 'chaps']).T
  df.plot()
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f9ba449bb38>
#+end_example

#+caption: png
[[file:14-Spacy-NER_files/14-Spacy-NER_60_1.png]]
