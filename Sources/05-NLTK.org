* More about the NLTK
  :PROPERTIES:
  :CUSTOM_ID: more-about-the-nltk
  :END:

- Collocations
- Concordances
- Frequency distributions
- Dispersion plots
- Type/token ratios (sets)

#+begin_src python
  import nltk
  from nltk import word_tokenize as tokenize
  from nltk.book import text1, text2, text3, text4, text5, text6, text7, text8, text9
  import pandas as pd
  from nltk.corpus import inaugural
  %matplotlib inline
  import matplotlib.pyplot as plt
  plt.rcParams['figure.figsize'] = [10, 5]
#+end_src

A token is an instance of a type.

#+begin_src python
  porkySentence = "the the the the the the the that's all folks!"
#+end_src

#+begin_src python
  porkyTokens = tokenize(porkySentence)
#+end_src

#+begin_src python
  type(porkyTokens)
#+end_src

#+begin_example
  list
#+end_example

#+begin_src python
  len(porkyTokens)
#+end_src

#+begin_example
  12
#+end_example

#+begin_src python
  porkyTypes = set(porkyTokens)
#+end_src

#+begin_src python
  len(porkyTypes)
#+end_src

#+begin_example
  6
#+end_example

** Type/token ratio
   :PROPERTIES:
   :CUSTOM_ID: typetoken-ratio
   :END:
number of types / number of tokens

#+begin_src python
  def typeTokenRatio(tokens): 
      numTokens = len(tokens)
      numTypes = len(set(tokens))
      return numTypes/numTokens
#+end_src

#+begin_src python
  typeTokenRatio(porkyTokens)
#+end_src

#+begin_example
  0.5
#+end_example

#+begin_src python
  donaldDuck = "Quack gosh darnit quack what's the big idea?"
#+end_src

#+begin_src python
  donaldTokens = tokenize(donaldDuck)
#+end_src

#+begin_src python
  typeTokenRatio(donaldTokens)
#+end_src

#+begin_example
  1.0
#+end_example

*** Testing on Test Texts
    :PROPERTIES:
    :CUSTOM_ID: testing-on-test-texts
    :END:
#+begin_src python
  text1
#+end_src

#+begin_example
  <Text: Moby Dick by Herman Melville 1851>
#+end_example

#+begin_src python
  len(text1.tokens)
#+end_src

#+begin_example
  260819
#+end_example

#+begin_src python
  len(set(text1.tokens))
#+end_src

#+begin_example
  19317
#+end_example

#+begin_src python
  typeTokenRatio(text1.tokens)
#+end_src

#+begin_example
  0.07406285585022564
#+end_example

#+begin_src python
  typeTokenRatio(text4.tokens)
#+end_src

#+begin_example
  0.06692970116993173
#+end_example

#+begin_src python
  lengths = [len(text) for text in [text1, text2, text3, text4, text5]]
#+end_src

#+begin_src python
  lengths
#+end_src

#+begin_example
  [260819, 141576, 44764, 145735, 45010]
#+end_example

#+begin_src python
  ttrs = [typeTokenRatio(text[:40000]) for text in [text1, text2, text3, text4, text5]]
#+end_src

#+begin_src python
  labels = [text.name for text in [text1, text2, text3, text4, text5]]
#+end_src

#+begin_src python
  len(text5.tokens), len(set(text5.tokens))
#+end_src

#+begin_example
  (45010, 6066)
#+end_example

#+begin_src python
  len(text2.tokens), len(set(text2.tokens))
#+end_src

#+begin_example
  (141576, 6833)
#+end_example

#+begin_src python
  pd.Series(ttrs, index=labels).plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7fc334d7f518>
#+end_example

#+caption: png
[[file:05-NLTK_files/05-NLTK_28_1.png]]

#+begin_src python
  inauguralTokens = [tokenize(inaugural.raw(fileid)) 
                     for fileid in inaugural.fileids()]
#+end_src

Find the minimum length of all inaugural addresses:

#+begin_src python
  min([len(t) for t in inauguralTokens])
#+end_src

#+begin_example
  147
#+end_example

Make a list of all type/token ratios of all presidential addresses:

#+begin_src python
  ttr = [typeTokenRatio(presidentTokens) 
         for presidentTokens in inauguralTokens]
#+end_src

Make a list of all filenames, so we can use them as labels:

#+begin_src python
  labels = inaugural.fileids()
#+end_src

Now put everything into a Pandas series so we can plot it:

#+begin_src python
  pd.Series(ttr, index=labels).plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7fc32efe53c8>
#+end_example

#+caption: png
[[file:05-NLTK_files/05-NLTK_37_1.png]]

** Things you can do with NLTK Text() Objects
   :PROPERTIES:
   :CUSTOM_ID: things-you-can-do-with-nltk-text-objects
   :END:
#+begin_src python
  type(text1)
#+end_src

#+begin_example
  nltk.text.Text
#+end_example

#+begin_src python
  dir(text1)
#+end_src

#+begin_example
  ['_CONTEXT_RE',
   '_COPY_TOKENS',
   '__class__',
   '__delattr__',
   '__dict__',
   '__dir__',
   '__doc__',
   '__eq__',
   '__format__',
   '__ge__',
   '__getattribute__',
   '__getitem__',
   '__gt__',
   '__hash__',
   '__init__',
   '__init_subclass__',
   '__le__',
   '__len__',
   '__lt__',
   '__module__',
   '__ne__',
   '__new__',
   '__reduce__',
   '__reduce_ex__',
   '__repr__',
   '__setattr__',
   '__sizeof__',
   '__str__',
   '__subclasshook__',
   '__unicode__',
   '__weakref__',
   '_context',
   'collocations',
   'common_contexts',
   'concordance',
   'count',
   'dispersion_plot',
   'findall',
   'generate',
   'index',
   'name',
   'plot',
   'readability',
   'similar',
   'tokens',
   'unicode_repr',
   'vocab']
#+end_example

** Concordances
   :PROPERTIES:
   :CUSTOM_ID: concordances
   :END:
#+begin_src python
  text1.concordance('whale')
#+end_src

#+begin_example
  Displaying 25 of 1226 matches:
  s , and to teach them by what name a whale - fish is to be called in our tongue
  t which is not true ." -- HACKLUYT " WHALE . ... Sw . and Dan . HVAL . This ani
  ulted ." -- WEBSTER ' S DICTIONARY " WHALE . ... It is more immediately from th
  ISH . WAL , DUTCH . HWAL , SWEDISH . WHALE , ICELANDIC . WHALE , ENGLISH . BALE
  HWAL , SWEDISH . WHALE , ICELANDIC . WHALE , ENGLISH . BALEINE , FRENCH . BALLE
  least , take the higgledy - piggledy whale statements , however authentic , in 
   dreadful gulf of this monster ' s ( whale ' s ) mouth , are immediately lost a
   patient Job ." -- RABELAIS . " This whale ' s liver was two cartloads ." -- ST
   Touching that monstrous bulk of the whale or ork we have received nothing cert
   of oil will be extracted out of one whale ." -- IBID . " HISTORY OF LIFE AND D
  ise ." -- KING HENRY . " Very like a whale ." -- HAMLET . " Which to secure , n
  restless paine , Like as the wounded whale to shore flies thro ' the maine ." -
  . OF SPERMA CETI AND THE SPERMA CETI WHALE . VIDE HIS V . E . " Like Spencer ' 
  t had been a sprat in the mouth of a whale ." -- PILGRIM ' S PROGRESS . " That 
  EN ' S ANNUS MIRABILIS . " While the whale is floating at the stern of the ship
  e ship called The Jonas - in - the - Whale . ... Some say the whale can ' t ope
   in - the - Whale . ... Some say the whale can ' t open his mouth , but that is
   masts to see whether they can see a whale , for the first discoverer has a duc
   for his pains . ... I was told of a whale taken near Shetland , that had above
  oneers told me that he caught once a whale in Spitzbergen that was white all ov
  2 , one eighty feet in length of the whale - bone kind came in , which ( as I w
  n master and kill this Sperma - ceti whale , for I could never hear of any of t
   . 1729 . "... and the breath of the whale is frequendy attended with such an i
  ed with hoops and armed with ribs of whale ." -- RAPE OF THE LOCK . " If we com
  contemptible in the comparison . The whale is doubtless the largest animal in c
#+end_example

#+begin_src python
  text1.concordance('whale')
#+end_src

#+begin_example
  Displaying 25 of 1226 matches:
  s , and to teach them by what name a whale - fish is to be called in our tongue
  t which is not true ." -- HACKLUYT " WHALE . ... Sw . and Dan . HVAL . This ani
  ulted ." -- WEBSTER ' S DICTIONARY " WHALE . ... It is more immediately from th
  ISH . WAL , DUTCH . HWAL , SWEDISH . WHALE , ICELANDIC . WHALE , ENGLISH . BALE
  HWAL , SWEDISH . WHALE , ICELANDIC . WHALE , ENGLISH . BALEINE , FRENCH . BALLE
  least , take the higgledy - piggledy whale statements , however authentic , in 
   dreadful gulf of this monster ' s ( whale ' s ) mouth , are immediately lost a
   patient Job ." -- RABELAIS . " This whale ' s liver was two cartloads ." -- ST
   Touching that monstrous bulk of the whale or ork we have received nothing cert
   of oil will be extracted out of one whale ." -- IBID . " HISTORY OF LIFE AND D
  ise ." -- KING HENRY . " Very like a whale ." -- HAMLET . " Which to secure , n
  restless paine , Like as the wounded whale to shore flies thro ' the maine ." -
  . OF SPERMA CETI AND THE SPERMA CETI WHALE . VIDE HIS V . E . " Like Spencer ' 
  t had been a sprat in the mouth of a whale ." -- PILGRIM ' S PROGRESS . " That 
  EN ' S ANNUS MIRABILIS . " While the whale is floating at the stern of the ship
  e ship called The Jonas - in - the - Whale . ... Some say the whale can ' t ope
   in - the - Whale . ... Some say the whale can ' t open his mouth , but that is
   masts to see whether they can see a whale , for the first discoverer has a duc
   for his pains . ... I was told of a whale taken near Shetland , that had above
  oneers told me that he caught once a whale in Spitzbergen that was white all ov
  2 , one eighty feet in length of the whale - bone kind came in , which ( as I w
  n master and kill this Sperma - ceti whale , for I could never hear of any of t
   . 1729 . "... and the breath of the whale is frequendy attended with such an i
  ed with hoops and armed with ribs of whale ." -- RAPE OF THE LOCK . " If we com
  contemptible in the comparison . The whale is doubtless the largest animal in c
#+end_example

#+begin_src python
  help(text1.concordance)
#+end_src

#+begin_example
  Help on method concordance in module nltk.text:

  concordance(word, width=79, lines=25) method of nltk.text.Text instance
      Print a concordance for ``word`` with the specified context window.
      Word matching is not case-sensitive.
      :seealso: ``ConcordanceIndex``
#+end_example

#+begin_src python
  text6.concordance('ni', width=60)
#+end_src

#+begin_example
  Displaying 25 of 69 matches:
  music stops ] HEAD KNIGHT OF NI : Ni ! KNIGHTS OF NI : Ni ! 
   stops ] HEAD KNIGHT OF NI : Ni ! KNIGHTS OF NI : Ni ! Ni ! 
  IGHT OF NI : Ni ! KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! A
  OF NI : Ni ! KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ARTHUR
   : Ni ! KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ARTHUR : Wh
   ! KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ARTHUR : Who are
  IGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ARTHUR : Who are you 
   OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ARTHUR : Who are you ? HEA
  re the Knights Who Say ... ' Ni '! RANDOM : Ni ! ARTHUR : No
  Who Say ... ' Ni '! RANDOM : Ni ! ARTHUR : No ! Not the Knig
   ! Not the Knights Who Say ' Ni '! HEAD KNIGHT : The same ! 
  eepers of the sacred words : Ni , Peng , and Neee - wom ! RA
  IGHT : The Knights Who Say ' Ni ' demand a sacrifice ! ARTHU
  rifice ! ARTHUR : Knights of Ni , we are but simple travelle
   these woods . HEAD KNIGHT : Ni ! KNIGHTS OF NI : Ni ! Ni ! 
  EAD KNIGHT : Ni ! KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! .
  NIGHT : Ni ! KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ... AR
   : Ni ! KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ... ARTHUR 
   ! KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ... ARTHUR : Ow 
  IGHTS OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ... ARTHUR : Ow ! Ow 
   OF NI : Ni ! Ni ! Ni ! Ni ! Ni ! ... ARTHUR : Ow ! Ow ! Ow 
  HEAD KNIGHT : We shall say ' ni ' again to you if you do not
  ARTHUR : A what ? KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! ARTHUR
  R : A what ? KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! ARTHUR and 
   what ? KNIGHTS OF NI : Ni ! Ni ! Ni ! Ni ! ARTHUR and PARTY
#+end_example

#+begin_src python
  text6.dispersion_plot(['Ni', 'shrubbery'])
#+end_src

#+caption: png
[[file:05-NLTK_files/05-NLTK_46_0.png]]

#+begin_src python
  text1.dispersion_plot(['whale', 'Ahab', 'Ishmael'])
#+end_src

#+caption: png
[[file:05-NLTK_files/05-NLTK_47_0.png]]

#+begin_src python
  text1.collocations()
#+end_src

#+begin_example
  Sperm Whale; Moby Dick; White Whale; old man; Captain Ahab; sperm
  whale; Right Whale; Captain Peleg; New Bedford; Cape Horn; cried Ahab;
  years ago; lower jaw; never mind; Father Mapple; cried Stubb; chief
  mate; white whale; ivory leg; one hand
#+end_example

#+begin_src python
  text2.collocations()
#+end_src

#+begin_example
  Colonel Brandon; Sir John; Lady Middleton; Miss Dashwood; every thing;
  thousand pounds; dare say; Miss Steeles; said Elinor; Miss Steele;
  every body; John Dashwood; great deal; Harley Street; Berkeley Street;
  Miss Dashwoods; young man; Combe Magna; every day; next morning
#+end_example

#+begin_src python
  text6.collocations()
#+end_src

#+begin_example
  BLACK KNIGHT; clop clop; HEAD KNIGHT; mumble mumble; Holy Grail;
  squeak squeak; FRENCH GUARD; saw saw; Sir Robin; Run away; CARTOON
  CHARACTER; King Arthur; Iesu domine; Pie Iesu; DEAD PERSON; Round
  Table; clap clap; OLD MAN; dramatic chord; dona eis
#+end_example

#+begin_src python
  text6.similar('shrubbery')
#+end_src

#+begin_example
  behind lady people pulp shrubber herring
#+end_example

#+begin_src python
  text1.similar('whale')
#+end_src

#+begin_example
  ship boat sea time captain world man deck pequod other whales air
  water head crew line thing side way body
#+end_example

** Create Your Own NLTK Text() Object
   :PROPERTIES:
   :CUSTOM_ID: create-your-own-nltk-text-object
   :END:

1. Load the text into a string.
2. Tokenize the text.
3. Instantiate a text object =Text()= with the tokens.

#+begin_src python
  from nltk.text import Text
#+end_src

#+begin_src python
  moonstone = open('moonstone.md', encoding='UTF-8').read()
  moonstoneTokens = tokenize(moonstone)
  moonstoneText = Text(moonstoneTokens)
#+end_src

#+begin_src python
  moonstoneText.dispersion_plot(['Betteredge', 'Blake', 'Clack', 'Bruff'])
#+end_src

#+caption: png
[[file:05-NLTK_files/05-NLTK_56_0.png]]
