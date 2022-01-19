* Corpora, Continued
  :PROPERTIES:
  :CUSTOM_ID: corpora-continued
  :END:
** And Scikit-Learn
   :PROPERTIES:
   :CUSTOM_ID: and-scikit-learn
   :END:
#+begin_src python
  from nltk.corpus import gutenberg
  from sklearn.feature_extraction.text import TfidfVectorizer
  import pandas as pd
  from sklearn.decomposition import PCA
  from matplotlib import pyplot as plt
  %matplotlib inline
  import matplotlib.pyplot as plt
  plt.rcParams['figure.figsize'] = [10, 10]
#+end_src

*TF-IDF*: Term frequency, adjusted for inverse document frequency. - Term frequency: the frequency with which words occur in your text - Inverse document frequency: the freq. with which words occur in your corpus.

Or, a fancy way of getting distinguishing words of a document. At the moment, we'll be using the TfidfVectorizer, but we'll be turning off IDF, and just using it to make tables of word frequencies.

Let's test it out on the NLTK's built-in =gutenberg= corpus of about 20 novels:

#+begin_src python
  gutenberg.fileids()
#+end_src

#+begin_example
  ['austen-emma.txt',
   'austen-persuasion.txt',
   'austen-sense.txt',
   'bible-kjv.txt',
   'blake-poems.txt',
   'bryant-stories.txt',
   'burgess-busterbrown.txt',
   'carroll-alice.txt',
   'chesterton-ball.txt',
   'chesterton-brown.txt',
   'chesterton-thursday.txt',
   'edgeworth-parents.txt',
   'melville-moby_dick.txt',
   'milton-paradise.txt',
   'shakespeare-caesar.txt',
   'shakespeare-hamlet.txt',
   'shakespeare-macbeth.txt',
   'whitman-leaves.txt']
#+end_example

Get tokens from particular works using =gutenberg.words()=:

#+begin_src python
  whitmanTokens = gutenberg.words('whitman-leaves.txt')
  whitmanRaw = gutenberg.raw('whitman-leaves.txt')
  hamletRaw = gutenberg.raw('shakespeare-hamlet.txt')
#+end_src

Or write a list comprehension that will do this for all the texts:

#+begin_src python
  allRaw = [gutenberg.raw(text) for text in gutenberg.fileids()]
#+end_src

Let's see how long each one is:

#+begin_src python
  pd.Series([len(text) for text in allRaw], 
            index=gutenberg.fileids()).plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f4d2715c0f0>
#+end_example

#+caption: png
[[file:10-Corpora-Scikit-Learn_files/10-Corpora-Scikit-Learn_9_1.png]]

#+begin_src python
  tfidf = TfidfVectorizer(use_idf=False, max_features=800)
#+end_src

#+begin_src python
  tf = tfidf.fit_transform([whitmanRaw, hamletRaw])
#+end_src

#+begin_src python
  tf
#+end_src

#+begin_example
  <2x800 sparse matrix of type '<class 'numpy.float64'>'
      with 1294 stored elements in Compressed Sparse Row format>
#+end_example

*Sparse matrix*: Matrix (table) with some values missing\\
*Dense matrix*: That matrix filled in (think: fillna(0)).

#+begin_src python
  tfDense = tf.todense()
#+end_src

#+begin_src python
  labels = tfidf.get_feature_names()
#+end_src

#+begin_src python
  labels[658:670]
#+end_src

#+begin_example
  ['sure',
   'surely',
   'swear',
   'sweet',
   'swift',
   'swiftly',
   'sword',
   'take',
   'talk',
   'tears',
   'teeming',
   'tell']
#+end_example

#+begin_src python
  whDF = pd.DataFrame(tfDense, index=['Whitman', 'Hamlet'], 
                      columns=labels)
#+end_src

#+begin_src python
  whDF
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

about

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

above

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

advance

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

after

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

again

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

againe

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

against

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

age

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

ages

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

ah

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

...

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

year

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

years

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

yellow

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

yet

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

you

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

young

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

your

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

yours

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

yourself

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

youth

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

Whitman

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.002465

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002689

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001867

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.009860

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.011877

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

0.002540

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003585

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002764

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002390

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

0.003287

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007619

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.00239

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.019571

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.114810

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.008814

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.027265

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001270

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.00381

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002465

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

Hamlet

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.008253

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

0.000000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.005647

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

0.014768

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.008687

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003475

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

0.000869

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

0.000000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000434

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.00000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016071

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.228902

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003909

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.109890

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002606

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.00000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006081

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

2 rows × 800 columns

#+begin_html
  </p>
#+end_html

Now we'll try again, but with all the texts. First, we instantiate our vectorizer, giving it all the options we want.

#+begin_src python
  tfidf = TfidfVectorizer(use_idf=False, max_features=800)
#+end_src

Next, convert our list of texts to a matrix of word frequencies:

#+begin_src python
  allTf = tfidf.fit_transform(allRaw)
#+end_src

What does it look like?

#+begin_src python
  allTf
#+end_src

#+begin_example
  <18x800 sparse matrix of type '<class 'numpy.float64'>'
      with 11276 stored elements in Compressed Sparse Row format>
#+end_example

Since it's a sparse matrix, we have to convert it to a dense matrix for Pandas to understand it:

#+begin_src python
  allTfDense = allTf.todense()
#+end_src

Here's a better list of labels:

#+begin_src python
  allTextLabels = [text.split('.')[0] for text in gutenberg.fileids()]
  allTextLabels[:3]
#+end_src

#+begin_example
  ['austen-emma', 'austen-persuasion', 'austen-sense']
#+end_example

Now get the word labels:

#+begin_src python
  allWordLabels = tfidf.get_feature_names()
#+end_src

Now put it all in a Pandas DataFrame, along with the labels:

#+begin_src python
  allDf = pd.DataFrame(allTfDense, index=allTextLabels, columns=allWordLabels)
  allDf
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

10

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

11

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

12

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

13

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

14

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

15

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

16

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

17

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

18

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

19

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

...

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

ye

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

yea

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

year

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

years

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

yes

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

yet

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

you

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

young

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

your

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

yourself

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

austen-emma

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.000147

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000515

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

0.002060

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004193

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.009196

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.008019

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.145660

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.014125

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.026778

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004120

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

austen-persuasion

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.000134

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000134

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000134

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000134

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000134

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000269

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000269

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000134

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000134

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000134

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

0.000269

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

0.003627

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007791

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006448

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007791

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.084362

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.011284

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016657

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001881

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

austen-sense

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000096

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

0.000096

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

0.005198

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004717

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.005872

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007509

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.114655

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.009916

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.037159

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003658

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

bible-kjv

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.021160

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.021000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.019671

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.019041

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.018651

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.017932

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016902

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.015053

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016003

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.015143

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

0.039812

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003398

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003688

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.005388

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000040

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006827

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.026158

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002999

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.017842

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
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

blake-poems

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.007529

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

0.000000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007529

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.013552

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001506

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016564

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
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

bryant-stories

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.001809

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000201

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001407

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004423

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.005629

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002011

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.092885

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003016

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.017491

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000603

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

burgess-busterbrown

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000664

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001992

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006640

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001992

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.075034

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001992

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004648

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001992

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

carroll-alice

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000383

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

0.000767

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000383

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004984

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.009584

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.157565

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001917

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.023769

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003834

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

chesterton-ball

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.000131

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000131

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000653

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000131

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001698

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001829

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.008882

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.008751

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.139233

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006139

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.025339

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001045

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

chesterton-brown

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000875

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002479

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004521

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.009771

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.100923

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006417

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.013272

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001458

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

chesterton-thursday

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000552

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000736

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

0.000552

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007913

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.008281

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.134159

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002760

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.020428

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001840

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

edgeworth-parents

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000069

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

0.000069

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

0.003395

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

0.002772

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003811

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.010463

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007830

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.202673

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.009285

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.048780

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004296

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

melville-moby_dick

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.000196

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000049

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000049

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000147

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000049

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000049

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000049

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000049

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000049

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000049

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

0.023186

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000688

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001326

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004716

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003684

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016947

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.043916

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003930

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.012232

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001277

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

milton-paradise

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.013702

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000304

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000304

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000913

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

0.034712

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003045

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000457

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.008069

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
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

shakespeare-caesar

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.004033

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002689

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

0.000000

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004033

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.028232

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.262824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000672

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.100156

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
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

shakespeare-hamlet

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.004825

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001754

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

0.000439

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002193

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016229

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.231150

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003948

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.110970

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
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

shakespeare-macbeth

#+begin_html
  </th>
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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.000000

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

0.002325

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

0.000000

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

0.001550

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.044176

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.159652

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003100

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.097651

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
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

whitman-leaves

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

0.000523

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000523

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000598

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000449

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000374

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000374

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000299

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000224

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000224

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000299

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

0.002392

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000075

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003289

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007626

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000449

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.019587

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.114908

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.008822

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.027288

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003813

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

18 rows × 800 columns

#+begin_html
  </p>
#+end_html

* Stylometry
  :PROPERTIES:
  :CUSTOM_ID: stylometry
  :END:
Stylometry is the "measurement of style." It's a way to show how the style of writers is similar or different. Style, in this case, deals with the 800 most frequent words, which are function words, rather than content words---they show not what

Or, comparison of most frequent words.

#+begin_src python
  tfidf = TfidfVectorizer(use_idf=False, max_features=800)
#+end_src

#+begin_src python
  allTf = tfidf.fit_transform(allRaw).todense()
#+end_src

#+begin_src python
  allTf.shape
#+end_src

#+begin_example
  (18, 800)
#+end_example

#+begin_src python
  pca = PCA(2)
#+end_src

#+begin_src python
  pcaOut = pca.fit_transform(allTf)
#+end_src

#+begin_src python
  pcaOut
#+end_src

#+begin_example
  array([[ 0.32333505, -0.08381139],
         [ 0.22136693, -0.1140211 ],
         [ 0.29950241, -0.07478352],
         [-0.2457221 ,  0.08488495],
         [-0.26052024,  0.09992633],
         [-0.13392442, -0.14444047],
         [ 0.10127414, -0.23486152],
         [ 0.0123094 , -0.16840572],
         [-0.10519774, -0.09191935],
         [-0.12196108, -0.14224833],
         [-0.120221  , -0.11867094],
         [ 0.13612398, -0.07050656],
         [-0.16890033, -0.04802805],
         [-0.0279306 ,  0.16799588],
         [ 0.16958361,  0.31548159],
         [ 0.14650093,  0.29245297],
         [ 0.05878538,  0.26462148],
         [-0.28440432,  0.06633375]])
#+end_example

#+begin_src python
  xs, ys = pcaOut[:,0], pcaOut[:,1]
  for i in range(len(xs)): 
      plt.scatter(xs[i], ys[i])
      plt.annotate(allTextLabels[i], (xs[i], ys[i]))
#+end_src

#+caption: png
[[file:10-Corpora-Scikit-Learn_files/10-Corpora-Scikit-Learn_40_0.png]]
