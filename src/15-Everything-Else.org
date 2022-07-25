* Everything Else
  :PROPERTIES:
  :CUSTOM_ID: everything-else
  :END:

- Sentiment Analysis
- Macro-Etymological Analysis

** Sentiment Analysis
   :PROPERTIES:
   :CUSTOM_ID: sentiment-analysis
   :END:
Sentiment analysis is an automated attempt to guess at the polarity of the sentiment conveyed in a given expression. For example, if you have a corpus of movie reviews, and you're interested in knowing whether a given review is likely favorable or unfavorable to the movie, and reviews have sentences like: "I really loved this movie!" and "I thought this movie was terrible," then you can use sentiment analysis to try to guess the sentiment conveyed. Sentiment analysis, as typically performed, usually has two types. /Lexical/ sentiment analysis looks up words in a dictionary. So you can imagine that it's not great with sentences like "I really didn't love this movie," since it will see "love" and will assume that it's a positive sentence. /Syntactic/ or /probabilisitic/ techniques, in contrast, take into account the structure of the sentence, and/or features learned (using machine learning) from labeled (manually entered) datasets, and are much better. But those techniques are much harder to do, so I'm just going to demonstrate a quick-and-dirty method, (i.e. easy, but inaccurate) using the =textblob= library.

If you don't already have =textblob= (and I don't think it comes with Anaconda), you might have to run =conda install -c conda-forge textblob= from a terminal or command-line, in order to install it on Anaconda.

#+begin_src python
  from textblob import TextBlob
  import pandas as pd
  from nltk import sent_tokenize
  %matplotlib inline
#+end_src

First, we'll get some test texts to play around with, from Dubliners:

#+begin_src python
  eveline = open('eveline.md').read()
#+end_src

#+begin_src python
  eveline[:200]
#+end_src

#+begin_example
  '\n## EVELINE\n\nSHE sat at the window watching the evening invade the avenue. Her head\nwas leaned against the window curtains and in her nostrils was the odour\nof dusty cretonne. She was tired.\n\nFew peop'
#+end_example

Make it into a =TextBlob= object:

#+begin_src python
  evelineBlob = TextBlob(eveline)
#+end_src

Which gives us access to the =.sentiment= property, containing both =.polarity= and =.subjectivity=. Polarity is whether the sentence is positive or negative; subjectivity is how much sentiment is present. A sentence like "I really love this OMG!!!1!" would have high subjectivity, for instance, while a sentence like "the cat is in the house" would have low subjectivity.

#+begin_src python
  evelineBlob.sentiment
#+end_src

#+begin_example
  Sentiment(polarity=-0.008591667278107956, subjectivity=0.45734867298426624)
#+end_example

#+begin_src python
  dubliners = open('dubliners.md').read()
#+end_src

#+begin_src python
  dubParts = dubliners.split('##')
#+end_src

Grab a few stories:

#+begin_src python
  nope, sisters, encounter, araby, eveline = dubParts[:5]
#+end_src

#+begin_src python
  eveline[:100]
#+end_src

#+begin_example
  ' EVELINE\n\nSHE sat at the window watching the evening invade the avenue. Her head\nwas leaned against '
#+end_example

#+begin_src python
  fourStories = [sisters, encounter, araby, eveline]
  allStories = dubParts[1:]
#+end_src

Turn them into =TextBlob= objects:

#+begin_src python
  fourBlobs = [TextBlob(text).sentiment
              for text in fourStories]
#+end_src

Grab their sentiment polarities:

#+begin_src python
  fourSentiments = [item.polarity
                   for item in fourBlobs]
#+end_src

#+begin_src python
  fourSentiments
#+end_src

#+begin_example
  [-0.008060086400893564,
   0.07032967290973487,
   -0.03624764467357063,
   -0.008591667278107956]
#+end_example

And plot them, labeling the rows while we're at it:

#+begin_src python
  pd.Series(fourSentiments, index=['The Sisters', 'An Encounter', 
                                   'Araby', 'Eveline']).plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f7746e95780>
#+end_example

#+caption: png
[[file:15-Everything-Else_files/15-Everything-Else_21_1.png]]

Let's try this again but with every sentence in "Eveline," as another example:

#+begin_src python
  eveline = open('eveline.md').read()
#+end_src

#+begin_src python
  evelineSents = sent_tokenize(eveline)
#+end_src

How many sentences are there?

#+begin_src python
  len(evelineSents)
#+end_src

#+begin_example
  130
#+end_example

Make a list of all the polarities of all the sentences:

#+begin_src python
  evelineSentiments = [TextBlob(sent).sentiment.polarity
                      for sent in evelineSents]
#+end_src

And now we can iterate through all these, and the sentences too, zipping them together with =zip()= and writing a =for= loop to move through both of them at the same time:

#+begin_src python
  for sent, sentiment in zip(evelineSents, evelineSentiments): 
      print(sentiment, sent.replace('\n', ' ')[:80])
#+end_src

#+begin_example
  0.0  ## EVELINE  SHE sat at the window watching the evening invade the avenue.
  -0.4 Her head was leaned against the window curtains and in her nostrils was the odou
  -0.4 She was tired.
  -0.2 Few people passed.
  0.0715909090909091 The man out of the last house passed on his way home; she heard his footsteps cl
  -0.125 One time there used to be a field there in which they used to play every evening
  0.25625000000000003 Then a man from Belfast bought the field and built houses in it---not like their
  -0.1875 The children of the avenue used to play together in that field---the Devines, th
  0.0 Ernest, however, never played: he was too grown up.
  -0.1875 Her father used often to hunt them in out of the field with his blackthorn stick
  0.8 Still they seemed to have been rather happy then.
  -0.29999999999999993 Her father was not so bad then; and besides, her mother was alive.
  -0.125 That was a long time ago; she and her brothers and sisters were all grown up; he
  -0.1 Tizzie Dunn was dead, too, and the Waters had gone back to England.
  0.0 Everything changes.
  0.0 Now she was going to go away like the others, to leave her home.
  0.0 Home!
  0.225 She looked round the room, reviewing all its familiar objects which she had dust
  0.375 Perhaps she would never see again those familiar objects from which she had neve
  -0.2 And yet during all those years she had never found out the name of the priest wh
  0.0 He had been a school friend of her father.
  -0.5000000000000001 Whenever he showed the photograph to a visitor her father used to pass it with a
  0.0 She had consented to go away, to leave her home.
  0.7 Was that wise?
  0.0 She tried to weigh each side of the question.
  0.0 In her home anyway she had shelter and food; she had those whom she had known al
  -0.2916666666666667 Of course she had to work hard, both in the house and at business.
  0.0 What would they say of her in the Stores when they found out that she had run aw
  0.4 Say she was a fool, perhaps; and her place would be filled up by advertisement.
  0.5 Miss Gavan would be glad.
  0.0 She had always had an edge on her, especially whenever there were people listeni
  0.0 "Miss Hill, don't you see these ladies are waiting?"
  0.13636363636363635 "Look lively, Miss Hill, please."
  0.5 She would not cry many tears at leaving the Stores.
  -0.02121212121212122 But in her new home, in a distant unknown country, it would not be like that.
  0.0 Then she would be married---she, Eveline.
  0.0 People would treat her with respect then.
  0.0 She would not be treated as her mother had been.
  0.0 Even now, though she was over nineteen, she sometimes felt herself in danger of 
  0.0 She knew it was that that had given her the palpitations.
  -0.06666666666666667 When they were growing up he had never gone for her like he used to go for Harry
  0.0 And now she had nobody to protect her.
  -0.0851851851851852 Ernest was dead and Harry, who was in the church decorating business, was nearly
  0.0 Besides, the invariable squabble for money on Saturday nights had begun to weary
  -0.1 She always gave her entire wages---seven shillings---and Harry always sent up wh
  -0.09999999999999992 He said she used to squander the money, that she had no head, that he wasn't goi
  0.0 In the end he would give her the money and ask her had she any intention of buyi
  -0.07797619047619048 Then she had to rush out as quickly as she could and do her marketing, holding h
  -0.03833333333333334 She had hard work to keep the house together and to see that the two young child
  -0.2916666666666667 It was hard work---a hard life---but now that she was about to leave it she did 
  0.0 She was about to explore another life with Frank.
  0.78 Frank was very kind, manly, open-hearted.
  0.13636363636363635 She was to go away with him by the night-boat to be his wife and to live with hi
  0.20833333333333331 How well she remembered the first time she had seen him; he was lodging in a hou
  -0.2 It seemed a few weeks ago.
  0.0 He was standing at the gate, his peaked cap pushed back on his head and his hair
  -0.125 Then they had come to know each other.
  0.0 He used to meet her outside the Stores every evening and see her home.
  0.0 He took her to see The Bohemian Girl and she felt elated as she sat in an unaccu
  -0.59375 He was awfully fond of music and sang a little.
  -0.4 People knew that they were courting and, when he sang about the lass that loves 
  0.3 He used to call her Poppens out of fun.
  0.25 First of all it had been an excitement for her to have a fellow and then she had
  -0.1 He had tales of distant countries.
  0.0 He had started as a deck boy at a pound a month on a ship of the Allan Line goin
  0.0 He told her the names of the ships he had been on and the names of the different
  -1.0 He had sailed through the Straits of Magellan and he told her stories of the ter
  0.1 He had fallen on his feet in Buenos Ayres, he said, and had come over to the old
  0.0 Of course, her father had found out the affair and had forbidden her to have any
  0.0 "I know these sailor chaps," he said.
  -0.4 One day he had quarrelled with Frank and after that she had to meet her lover se
  0.0 The evening deepened in the avenue.
  0.0 The white of two letters in her lap grew indistinct.
  -0.125 One was to Harry; the other was to her father.
  0.6 Ernest had been her favourite but she liked Harry too.
  0.08333333333333336 Her father was becoming old lately, she noticed; he would miss her.
  0.78 Sometimes he could be very nice.
  0.025 Not long before, when she had been laid up for a day, he had read her out a ghos
  0.1 Another day, when their mother was alive, they had all gone for a picnic to the 
  0.3 She remembered her father putting on her mother's bonnet to make the children la
  -0.4 Her time was running out but she continued to sit by the window, leaning her hea
  -0.02777777777777779 Down far in the avenue she could hear a street organ playing.
  0.0 She knew the air.
  0.03333333333333334 Strange that it should come that very night to remind her of the promise to her 
  -0.06875 She remembered the last night of her mother's illness; she was again in the clos
  0.0 The organ-player had been ordered to go away and given sixpence.
  -0.15 She remembered her father strutting back into the sickroom saying:  "Damned Ital
  0.0 coming over here!"
  0.21666666666666667 As she mused the pitiful vision of her mother's life laid its spell on the very 
  0.0 She trembled as she heard again her mother's voice saying constantly with foolis
  0.0 Derevaun Seraun!"
  0.0 She stood up in a sudden impulse of terror.
  0.0 Escape!
  0.0 She must escape!
  0.0 Frank would save her.
  0.5 He would give her life, perhaps love, too.
  0.13636363636363635 But she wanted to live.
  -0.6 Why should she be unhappy?
  0.4928571428571428 She had a right to happiness.
  0.0 Frank would take her in his arms, fold her in his arms.
  0.0 He would save her.
  0.0 She stood among the swaying crowd in the station at the North Wall.
  0.0 He held her hand and she knew that he was speaking to her, saying something abou
  0.35 The station was full of soldiers with brown baggages.
  -0.13333333333333333 Through the wide doors of the sheds she caught a glimpse of the black mass of th
  0.0 She answered nothing.
  -0.23666666666666666 She felt her cheek pale and cold and, out of a maze of distress, she prayed to G
  -0.05 The boat blew a long mournful whistle into the mist.
  0.0 If she went, tomorrow she would be on the sea with Frank, steaming towards Bueno
  0.0 Their passage had been booked.
  0.0 Could she still draw back after all he had done for her?
  0.0 Her distress awoke a nausea in her body and she kept moving her lips in silent f
  0.0 A bell clanged upon her heart.
  0.0 She felt him seize her hand:  "Come!"
  0.0 All the seas of the world tumbled about her heart.
  0.0 He was drawing her into them: he would drown her.
  0.0 She gripped with both hands at the iron railing.
  0.0 "Come!"
  0.0 No!
  0.0 No!
  0.0 No!
  -0.6666666666666666 It was impossible.
  0.0 Her hands clutched the iron in frenzy.
  0.0 Amid the seas she sent a cry of anguish!
  0.0 "Eveline!
  0.0 Evvy!"
  0.0 He rushed beyond the barrier and called to her to follow.
  0.0 He was shouted at to go on but he still called to her.
  0.0 She set her white face to him, passive, like a helpless animal.
  0.5 Her eyes gave him no sign of love or farewell or recognition.
#+end_example

Finally, plot the sentiment polarity, by sentence:

#+begin_src python
  pd.Series(evelineSentiments).plot()
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f4e9929ec50>
#+end_example

#+caption: png
[[file:15-Everything-Else_files/15-Everything-Else_32_1.png]]

We can smooth that out using rolling averages:

#+begin_src python
  pd.Series(evelineSentiments).rolling(window=20).mean().plot()
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f4e94eda668>
#+end_example

#+caption: png
[[file:15-Everything-Else_files/15-Everything-Else_34_1.png]]

We could also try that by paragraph, if we wanted:

#+begin_src python
  evelineParas = eveline.split('\n\n')
#+end_src

#+begin_src python
  len(evelineParas)
#+end_src

#+begin_example
  28
#+end_example

#+begin_src python
  evelinePSentiments = [TextBlob(par).sentiment.polarity
                       for par in evelineParas]
#+end_src

#+begin_src python
  evelinePSentiments
#+end_src

#+begin_example
  [0.0,
   -0.4,
   -0.008890374331550792,
   0.021428571428571415,
   0.0,
   0.26166666666666666,
   0.0,
   0.13636363636363635,
   0.5,
   -0.0835873617123617,
   -0.060557040998217446,
   0.0,
   -0.4,
   0.193,
   -0.0775462962962963,
   0.0,
   0.14444444444444446,
   0.0,
   0.17034632034632033,
   -0.07518518518518519,
   0.0,
   0.0,
   0.0,
   0.0,
   -0.8333333333333333,
   0.0,
   0.25,
   0.0]
#+end_example

#+begin_src python
  pd.Series(evelinePSentiments).plot()
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f4e9502bcf8>
#+end_example

#+caption: png
[[file:15-Everything-Else_files/15-Everything-Else_40_1.png]]

* Macro-Etymological Analysis
  :PROPERTIES:
  :CUSTOM_ID: macro-etymological-analysis
  :END:
Macro-etymological analysis simply looks up the parent languages, and parent language families, of each word in your text, and tabulates them accordingly. For this import statement to work, you must first have run =git clone= on [[https://github.com/JonathanReeve/macro-etym][the =macroetym= repository]], and either make sure the module is in your current working directory, or globally available, after installing it with something like =pip3 install .= or =conda install .=. This isn't easy to do, so let me know if you have trouble installing this, and we can work through it together.

#+begin_src python
  from macroetym import main
#+end_src

First, create a macro-etym =Text= object, and tell it the language is English. =Macro-etym= uses the standard three-letter language codes.

#+begin_src python
  eveText = main.Text(eveline, lang='eng')
#+end_src

Then, get language stats for "Eveline":

#+begin_src python
  eveText.getStats()
#+end_src

#+begin_example
  {'ang': 59.471094710947106,
   'deu': 0.36900369003690037,
   'dum': 0.36900369003690037,
   'fas': 0.12300123001230011,
   'fra': 5.07380073800738,
   'frm': 2.3062730627306274,
   'fro': 13.284132841328415,
   'grc': 1.107011070110701,
   'heb': 0.36900369003690037,
   'ita': 0.18450184501845018,
   'lat': 6.826568265682657,
   'non': 4.059040590405904,
   'xno': 6.4575645756457565}
#+end_example

That tells us that "Eveline" has 59% words of Old English (=ang= is the three-letter language code for Old English), 13% words of Old French origin, 9% words of Latin origin, etc. This can tell us a lot about the level of formality of the text, or its generic resonances. We can also get language family stats, too:

#+begin_src python
  eveText.getFamilyStats()
#+end_src

#+begin_example
  {'Germanic': [('ang', 59.471094710947106),
    ('non', 4.059040590405904),
    ('deu', 0.36900369003690037),
    ('dum', 0.36900369003690037)],
   'Hellenic': [('grc', 1.107011070110701)],
   'Indo-Iranian': [('fas', 0.12300123001230011)],
   'Latinate': [('fro', 13.284132841328415),
    ('fra', 5.07380073800738),
    ('xno', 6.4575645756457565),
    ('lat', 6.826568265682657),
    ('frm', 2.3062730627306274),
    ('ita', 0.18450184501845018)],
   'Semitic': [('heb', 0.36900369003690037)]}
#+end_example

#+begin_src python
#+end_src

#+begin_src python
#+end_src
