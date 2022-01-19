* Word Embeddings
  :PROPERTIES:
  :CUSTOM_ID: word-embeddings
  :END:
Word embeddings are words embedded in vector space, or words converted to a set a numbers, based on their collocations. They're often described as /semantic/ vectors (as opposed to stylistic or syntactic), because they encode information that can be construed as carrying meaning.

Let's explore the vector space of some stories from /Dubliners/.

#+begin_src python
  import spacy
  import numpy as np
  import pandas as pd
  from matplotlib import pyplot as plt
  from sklearn.decomposition import PCA
  # Import a few new things for 3-D plotting. 
  from mpl_toolkits.mplot3d import Axes3D, proj3d
  # This magic command is used for interactive plots. 
  %matplotlib notebook
#+end_src

First, open our copy of /Dubliners/ and split it on =##= characters, as usual.

#+begin_src python
  dubliners = open('dubliners.md').read()
  dublinersParts = dubliners.split('##')
#+end_src

Then see which indices correspond to which parts.

#+begin_src python
  [(pair[0], pair[1][:50]) for pair in enumerate(dublinersParts)]
#+end_src

#+begin_example
  [(0, '---\nlayout: narrative\ntitle:  Dubliners\nauthor: Ja'),
   (1, ' THE SISTERS\n\nTHERE was no hope for him this time:'),
   (2, ' AN ENCOUNTER\n\nIT WAS Joe Dillon who introduced th'),
   (3, ' ARABY\n\nNORTH RICHMOND STREET, being blind, was a '),
   (4, ' EVELINE\n\nSHE sat at the window watching the eveni'),
   (5, ' AFTER THE RACE\n\nTHE cars came scudding in towards'),
   (6, ' TWO GALLANTS\n\nTHE grey warm evening of August had'),
   (7, " THE BOARDING HOUSE\n\nMRS. MOONEY was a butcher's d"),
   (8, ' A LITTLE CLOUD\n\nEIGHT years before he had seen hi'),
   (9, ' COUNTERPARTS\n\nTHE bell rang furiously and, when M'),
   (10, ' CLAY\n\nTHE matron had given her leave to go out as'),
   (11, ' A PAINFUL CASE\n\nMR. JAMES DUFFY lived in Chapeliz'),
   (12, ' IVY DAY IN THE COMMITTEE ROOM\n\nOLD JACK raked the'),
   (13, ' A MOTHER\n\nMR HOLOHAN, assistant secretary of the '),
   (14, ' GRACE\n\nTWO GENTLEMEN who were in the lavatory at '),
   (15, " THE DEAD\n\nLILY, the caretaker's daughter, was lit")]
#+end_example

Let's grab "Clay," which is number 10.

#+begin_src python
  clay = dublinersParts[10]
#+end_src

Load SpaCy.

#+begin_src python
  nlp = spacy.load('en_core_web_lg')
#+end_src

Process "Clay" using SpaCy.

#+begin_src python
  clayDoc = nlp(clay)
#+end_src

Now if we grab a word from "Clay" (this one is the word "forward"), we can take a look at its vector. It will just be 300 numbers, since this is just a list of numbers.

#+begin_src python
  clayDoc[25].vector
#+end_src

#+begin_example
  array([  4.68239993e-01,   1.26019996e-02,  -4.80599999e-01,
           2.95800000e-01,   9.10560012e-01,  -1.46450000e-02,
           3.00880009e-03,   8.53089988e-02,  -2.48060003e-01,
           2.81649995e+00,  -8.03479999e-02,   3.63480002e-01,
           3.03469986e-01,   2.71569997e-01,  -2.19740003e-01,
           1.43689997e-02,  -2.49650002e-01,   9.06090021e-01,
          -4.95359987e-01,   2.32350007e-01,   1.25389993e-01,
          -9.91590023e-02,   2.72879988e-01,  -4.77479994e-02,
          -1.51740000e-01,   3.76150012e-01,   1.64210007e-01,
          -3.55230004e-01,  -6.47309981e-03,  -4.70310003e-01,
          -4.31279987e-01,   1.97119996e-01,  -6.08889982e-02,
          -6.42979965e-02,   2.69109994e-01,  -3.01649988e-01,
           2.43430007e-02,   3.77389997e-01,  -4.73919995e-02,
          -7.63719976e-01,  -1.36730000e-01,   3.06380004e-01,
          -5.55329993e-02,  -4.28350002e-01,   1.60469994e-01,
           2.80490011e-01,  -1.51289999e-02,   1.13430001e-01,
          -5.31009972e-01,  -9.25990008e-03,   2.72989988e-01,
           7.21029984e-03,  -3.68259996e-01,  -1.89700007e-01,
           5.40530011e-02,   2.99549997e-02,  -3.21280003e-01,
           1.81549992e-02,   7.15600029e-02,   1.31280003e-02,
           1.97310001e-01,  -9.97940004e-02,   1.59979999e-01,
          -1.90500006e-01,  -6.42620027e-02,  -8.79729986e-02,
          -5.53740002e-02,  -3.48250002e-01,   3.14909995e-01,
          -7.18710013e-03,   3.36890012e-01,  -5.77259995e-02,
           3.02920014e-01,  -1.11800001e-03,  -2.83950001e-01,
          -1.53899997e-01,   5.39399981e-02,  -3.96770000e-01,
           2.95020014e-01,   3.37469995e-01,   2.31890008e-03,
           4.88689989e-01,  -1.23580001e-01,   4.53280002e-01,
           4.19650003e-02,  -1.75720006e-02,  -8.35999995e-02,
          -1.80759996e-01,   4.93649989e-01,   4.23790008e-01,
           4.06760007e-01,  -3.42399999e-02,   1.14629999e-01,
           1.88099995e-01,  -2.63200015e-01,  -4.25690003e-02,
          -2.08069995e-01,  -3.42700005e-01,   6.11560009e-02,
           1.14710003e-01,  -1.14340000e-01,  -5.31440020e-01,
           2.42740005e-01,  -1.74529999e-01,  -1.78479999e-01,
          -7.77769983e-01,   2.59649992e-01,   4.63190004e-02,
          -2.91269988e-01,  -2.60879993e-01,  -1.17600001e-01,
          -1.75119996e-01,   9.18150023e-02,  -8.53220001e-02,
           4.41240013e-01,  -3.78730008e-04,  -2.66719997e-01,
          -1.38990000e-01,   1.21750003e-02,   1.16760001e-01,
          -3.97780016e-02,  -2.83890009e-01,  -2.82770004e-02,
           7.38849998e-01,   3.49519998e-01,   8.65209997e-02,
           5.45229986e-02,   3.23839992e-01,  -1.52180001e-01,
           2.71160007e-01,  -1.42790005e-01,   1.27430007e-01,
          -4.33329999e-01,  -5.63570000e-02,   1.03380002e-01,
          -2.13589996e-01,  -8.18869993e-02,   4.20680009e-02,
           1.53219998e-01,   1.06760003e-01,  -1.22099996e+00,
          -5.28200017e-03,  -2.58810014e-01,  -3.19079995e-01,
           2.62330007e-02,  -5.44659972e-01,  -1.64159998e-01,
          -1.98080003e-01,   2.11009994e-01,   2.50429988e-01,
          -1.49120003e-01,  -1.06160005e-03,  -9.80189964e-02,
           2.23810002e-01,  -7.44889975e-02,  -2.66139992e-02,
           2.04809994e-01,   3.80070001e-01,   4.95959997e-01,
          -3.30260009e-01,   2.81109989e-01,   4.26649988e-01,
          -4.61730003e-01,  -3.34589988e-01,  -1.25970006e-01,
           3.89699996e-01,   2.88700014e-01,   1.71650007e-01,
          -8.33379999e-02,   5.17579988e-02,   7.83319995e-02,
           1.20779999e-01,  -2.22849995e-02,  -7.15699971e-01,
          -3.51420008e-02,  -3.54840010e-01,   5.79060018e-02,
           3.02910000e-01,   1.42569998e-02,  -9.29000005e-02,
          -4.36170012e-01,  -2.16169998e-01,   3.71769994e-01,
          -1.16849998e-02,  -6.26849979e-02,  -1.48449996e-02,
          -1.62330002e-01,  -2.24360004e-01,  -2.39800006e-01,
           1.20609999e-01,   1.90830007e-01,  -3.08490008e-01,
           4.00869995e-01,   3.17239994e-03,  -1.39680002e-02,
           8.05559978e-02,   1.72399998e-01,  -2.02450007e-01,
          -1.38760000e-01,   4.32799995e-01,   5.11769988e-02,
          -1.23290002e-01,  -1.32569999e-01,  -8.12380016e-02,
           1.74730003e-01,   2.82929987e-01,  -6.04309998e-02,
          -3.27159986e-02,  -2.79040009e-01,  -2.61090007e-02,
           1.66480005e-01,  -5.93309999e-01,   2.70610005e-01,
          -2.90929992e-02,   1.82830002e-02,   4.79739994e-01,
          -6.48270026e-02,   4.15900014e-02,   2.00159997e-02,
           3.94110009e-02,  -1.07910000e-01,  -3.29079986e-01,
           1.56059995e-01,   6.41269982e-01,   2.03600004e-01,
          -5.47299981e-01,   2.29729995e-01,   1.47960007e-01,
           3.19279999e-01,   2.15130001e-01,  -1.95749998e-02,
          -6.91170022e-02,  -5.35870008e-02,   4.05739993e-01,
           1.74950004e-01,  -6.06069982e-01,  -6.91540003e-01,
           2.01450005e-01,   4.04199988e-01,   1.11489996e-01,
           2.05249995e-01,   1.32589996e-01,  -1.06749997e-01,
           5.15630007e-01,  -3.86409998e-01,   2.78140008e-02,
          -1.74390003e-01,   3.09779998e-02,   6.57820031e-02,
           3.93970013e-01,   3.59029993e-02,  -3.54169995e-01,
          -2.81560004e-01,  -2.31439993e-01,   1.47750005e-01,
          -3.96860018e-02,   5.16149998e-01,  -3.81240010e-01,
          -3.96479994e-01,   2.20039994e-01,  -5.97259998e-02,
           1.22400001e-01,   1.42519996e-01,   2.37440005e-01,
           9.04159993e-02,  -3.10810003e-02,  -6.30749986e-02,
           9.87320021e-02,   2.37629995e-01,  -2.41129994e-01,
           2.72749990e-01,  -1.75470002e-02,  -4.16330010e-01,
          -3.92390013e-01,   7.71040022e-02,   2.74069995e-01,
           4.69619989e-01,  -1.20389998e-01,   1.60720006e-01,
           4.34439987e-01,  -2.30100006e-01,   9.58100036e-02,
          -4.90759999e-01,   5.80510020e-01,   3.33029985e-01,
          -2.07859993e-01,  -1.19429998e-01,  -4.10270005e-01,
           3.53500009e-01,   1.44099995e-01,   1.10459998e-01,
          -1.44360000e-02,  -1.11780003e-01,  -1.69080004e-01,
           4.50309999e-02,  -4.61879998e-01,  -1.59730002e-01,
           2.33419999e-01,  -1.04539998e-01,   1.46449998e-01], dtype=float32)
#+end_example

Now let's plot, say, all the nouns in "Clay":

#+begin_src python
  clayNouns = [w for w in clayDoc if w.pos_ == "NOUN"]
#+end_src

#+begin_src python
  clayNouns[:10]
#+end_src

#+begin_example
  [matron, leave, women, tea, evening, kitchen, span, cook, copper, boilers]
#+end_example

How many are there?

#+begin_src python
  len(clayNouns)
#+end_src

#+begin_example
  442
#+end_example

Grab all the vectors for all the nouns, then make a list of labels while we're at it.

#+begin_src python
  clayVecs = [w.vector for w in clayNouns]
  clayLabels = [w.string.strip() for w in clayNouns]
#+end_src

Instantiate a PCA object, and tell it we're going to be trying to reduce our 300-dimensional vectors to just 3.

#+begin_src python
  pca = PCA(n_components=3)
#+end_src

Perform the PCA dimensionality reduction.

#+begin_src python
  pcaOut = pca.fit_transform(clayVecs)
#+end_src

Verify that we have a 442x3 matrix, where 442 is the number of nouns in "Clay," and 3 is the number of dimensions (soon to be the X, Y, and Z axes in our plot).

#+begin_src python
  pcaOut.shape
#+end_src

#+begin_example
  (442, 3)
#+end_example

Here's a function to plot these points on a scatter plot, in 3D, and annotate it using the labels we created:

#+begin_src python
  def plotResults(df, labels): 
      fig = plt.figure()
      ax = fig.add_subplot(111, projection='3d')
      ax.scatter(df[0], df[1], df[2], marker='o')
      for i, label in enumerate(labels):
          ax.text(df.loc[i][0], df.loc[i][1], df.loc[i][2], label)
#+end_src

The function requires that we pass it in as a DataFrame.

#+begin_src python
  df = pd.DataFrame(pcaOut)
#+end_src

Now we can plot the results:

#+begin_src python
  plotResults(df, clayLabels)
#+end_src

#+begin_example
  <IPython.core.display.Javascript object>
#+end_example

** Word Similarities
   :PROPERTIES:
   :CUSTOM_ID: word-similarities
   :END:
We can also compute word similarities (cosine distances between word vectors) using SpaCy's =.similarity()= method for words. First, let's grab some random nouns:

#+begin_src python
  clayNouns[100:110]
#+end_src

#+begin_example
  [hands, petticoats, sleeves, blouses, arms, mugs, cook, dummy, tea, milk]
#+end_example

#+begin_src python
  hands = clayNouns[100]
  petticoats = clayNouns[101]
  sleeves, blouses = clayNouns[102], clayNouns[103]
  arms = clayNouns[104]
#+end_src

How similar are hands and petticoats?

#+begin_src python
  hands.similarity(petticoats)
#+end_src

#+begin_example
  0.12848523
#+end_example

How about hands and arms?

#+begin_src python
  hands.similarity(arms)
#+end_src

#+begin_example
  0.64497548
#+end_example

And sleeves and blouses?

#+begin_src python
  sleeves.similarity(blouses)
#+end_src

#+begin_example
  0.60364556
#+end_example
