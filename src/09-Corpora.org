* Corpora
  :PROPERTIES:
  :CUSTOM_ID: corpora
  :END:
(Plural of corpus. A corpus is a collection of texts.)

#+begin_src python
  from nltk.corpus import brown
  from collections import Counter
  import pandas as pd
  from nltk import word_tokenize, pos_tag
  %matplotlib inline
  import matplotlib.pyplot as plt
  plt.rcParams['figure.figsize'] = [10, 5]
#+end_src

** The Brown Corpus
   :PROPERTIES:
   :CUSTOM_ID: the-brown-corpus
   :END:
#+begin_src python
  brown.categories()
#+end_src

#+begin_example
  ['adventure',
   'belles_lettres',
   'editorial',
   'fiction',
   'government',
   'hobbies',
   'humor',
   'learned',
   'lore',
   'mystery',
   'news',
   'religion',
   'reviews',
   'romance',
   'science_fiction']
#+end_example

#+begin_src python
  newsWords = brown.words(categories=['news'])
  scifiWords = brown.words(categories=['science_fiction'])
#+end_src

#+begin_src python
  newsWordsL = [word.lower() for word in newsWords]
  scifiWordsL = [word.lower() for word in scifiWords]
#+end_src

#+begin_src python
  newsCounts = Counter(newsWordsL)
  scifiCounts = Counter(scifiWordsL)
#+end_src

#+begin_src python
  len(newsWordsL), len(scifiWordsL)
#+end_src

#+begin_example
  (100554, 14470)
#+end_example

#+begin_src python
  df = pd.DataFrame([newsCounts, scifiCounts], 
                    index=['news', 'scifi']).T.fillna(0)
#+end_src

#+begin_src python
  df['newsF'] = df['news']/len(newsWordsL)
  df['scifiF'] = df['scifi']/len(scifiWordsL)
#+end_src

#+begin_src python
  df['newsiness'] = df['newsF']- df['scifiF']
#+end_src

#+begin_src python
  df.sort_values('newsiness', ascending=False)
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

news

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

scifi

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

newsF

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

scifiF

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

newsiness

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

the

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

6386.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

723.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.063508

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.049965

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.013543

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

2020.0

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

0.020089

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.011334

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.008755

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

of

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

2861.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

329.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.028452

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.022737

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.005716

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

2130.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

236.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.021183

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016310

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004873

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

is

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

733.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

50.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007290

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003455

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

for

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

969.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

100.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.009637

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006911

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002726

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

389.0

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

0.003869

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001175

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002694

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

636.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

55.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006325

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003801

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002524

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

by

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

504.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

37.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.005012

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002557

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002455

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

mrs.

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

253.0

#+begin_html
  </td>
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

0.002516

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

0.002447

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

has

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

301.0

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

0.002993

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000622

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002371

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

new

#+begin_html
  </th>
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

9.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002397

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000622

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001775

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

who

#+begin_html
  </th>
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

13.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002665

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000898

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001767

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

170.0

#+begin_html
  </td>
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

0.001691

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

0.001622

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

state

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

153.0

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

0.001522

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

0.001522

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

are

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

330.0

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

0.003282

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001797

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001485

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

2186.0

#+begin_html
  </td>
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

0.021740

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.020318

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001422

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

president

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

142.0

#+begin_html
  </td>
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

0.001412

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

0.001343

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

year

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

142.0

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

0.001412

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000138

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001274

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

)

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

171.0

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

0.001701

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000553

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001148

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

also

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

2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001283

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000138

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001145

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

(

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

168.0

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

0.001671

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000553

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001118

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

home

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

132.0

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

0.001313

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000207

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001105

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

two

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

10.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001730

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000691

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001039

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

house

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

97.0

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

0.000965

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

0.000965

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

last

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

177.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

12.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001760

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000829

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000931

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

406.0

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

0.004038

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003110

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000928

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

week

#+begin_html
  </th>
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

1.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000935

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

0.000866

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

city

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

93.0

#+begin_html
  </td>
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

0.000925

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

0.000856

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

an

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

311.0

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

0.003093

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002281

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000812

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
  </tr>
#+end_html

#+begin_html
  <tr>
#+end_html

#+begin_html
  <th>
#+end_html

helva

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

26.0

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

0.001797

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.001797

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

ekstrohm

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

26.0

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

0.001797

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.001797

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

what

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

95.0

#+begin_html
  </td>
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

0.000945

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002833

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.001889

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

267.0

#+begin_html
  </td>
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

0.002655

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004630

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.001975

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

did

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

38.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000636

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002626

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.001990

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

we

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

107.0

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

0.001064

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003110

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.002046

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

them

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

96.0

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

0.000955

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003248

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.002293

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

could

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

87.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

49.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000865

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003386

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.002521

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

all

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

181.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

66.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001800

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004561

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.002761

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

428.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

102.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004256

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007049

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.002793

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

38.0

#+begin_html
  </td>
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

0.000378

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003179

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.002801

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

314.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

88.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.003123

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006082

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.002959

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

5188.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

791.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.051594

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.054665

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.003071

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

246.0

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

0.002446

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.005529

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.003082

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

93.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

58.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000925

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004008

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.003083

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

no

#+begin_html
  </th>
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

62.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.001193

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004285

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.003091

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

77.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

59.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000766

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004077

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.003312

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

but

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

283.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

89.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002814

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006151

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.003336

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

not

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

257.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

95.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002556

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006565

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.004009

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

121.0

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

0.001203

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.005667

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.004464

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

179.0

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

0.001780

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006773

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.004992

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

66.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

96.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000656

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006634

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.005978

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

478.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

158.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.004754

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.010919

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.006165

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

717.0

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

0.007130

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.013822

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.006691

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

he

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

642.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

191.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006385

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.013200

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.006815

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

281.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

143.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.002795

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.009883

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.007088

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

``

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

732.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

235.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.007280

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016240

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.008961

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

''

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

702.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

235.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.006981

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.016240

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.009259

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

?

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

90.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

158.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.000895

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.010919

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.010024

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

4030.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

786.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.040078

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.054319

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-0.014241

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

14227 rows × 5 columns

#+begin_html
  </p>
#+end_html

#+begin_src python
  newsPOS = pos_tag(newsWordsL)
  scifiPOS = pos_tag(scifiWordsL)
#+end_src

#+begin_src python
  newsPOS[0]
#+end_src

#+begin_example
  ('the', 'DT')
#+end_example

#+begin_src python
  newsP = [pair[1] for pair in newsPOS]
  scifiP = [pair[1] for pair in scifiPOS]
#+end_src

#+begin_src python
  newsP[:20]
#+end_src

#+begin_example
  ['DT',
   'NN',
   'NN',
   'JJ',
   'NN',
   'VBD',
   'PDT',
   'DT',
   'NN',
   'IN',
   'JJ',
   'JJ',
   'JJ',
   'NN',
   'VBD',
   '``',
   'DT',
   'NN',
   "''",
   'IN']
#+end_example

#+begin_src python
  newsPOSCounts = Counter(newsP)
  scifiPOSCounts = Counter(scifiP)
#+end_src

#+begin_src python
  df = pd.DataFrame([newsPOSCounts, scifiPOSCounts], 
               index=['news', 'scifi'])
  df
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

\(</th>  <th>''</th>  <th>(</th>  <th>)</th>  <th>,</th>  <th>.</th>  <th>:</th>  <th>CC</th>  <th>CD</th>  <th>DT</th>  <th>...</th>  <th>VBD</th>  <th>VBG</th>  <th>VBN</th>  <th>VBP</th>  <th>VBZ</th>  <th>WDT</th>  <th>WP</th>  <th>WP\)

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

WRB

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

``

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

news

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

735

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

168

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

171

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

5188

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

4158

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

763

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2752

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2197

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

10101

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

3900

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1388

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

2308

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1157

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1677

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

394

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

377

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

22

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

288

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

732

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

scifi

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

NaN

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

245

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

8

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

8

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

791

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

990

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

150

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

425

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

69

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1277

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

940

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

201

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

345

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

195

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

106

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

54

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

57

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

3

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

68

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

235

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

2 rows × 42 columns

#+begin_html
  </p>
#+end_html

#+begin_src python
  df = df.fillna(0).T
#+end_src

#+begin_src python
  df['newsF'] = df['news'] / len(newsWordsL)
  df['scifiF'] = df['scifi'] / len(scifiWordsL)
#+end_src

#+begin_src python
  df[['newsF', 'scifiF']].plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f07ac162e48>
#+end_example

#+caption: png
[[file:09-Corpora_files/09-Corpora_20_1.png]]

** Corpus DB
   :PROPERTIES:
   :CUSTOM_ID: corpus-db
   :END:
You can use my API, Corpus-DB, to easily extract metadata and full text from Project Gutenberg. For example, to get Wilkie Collins novels, you can run something like this. First, import the API interface module =requests= and the JSON parsing module, =json=. (Remember, this is bad practice. Always put your import statements in the first or second cell when you're doing this yourself.)

#+begin_src python
  import requests
  import json
#+end_src

Then request metadata from corpus-db:

#+begin_src python
  response = requests.get('http://corpus-db.org/api/author/Collins, Wilkie')
#+end_src

Verify that the request returned OK:

#+begin_src python
  response.ok
#+end_src

#+begin_example
  True
#+end_example

Parse the response (i.e. the metadata as JSON):

#+begin_src python
  parsed = json.loads(response.text)
#+end_src

Then look at the titles we got:

#+begin_src python
  [item['title'] for item in parsed]
#+end_src

#+begin_example
  ['The Moonstone',
   'The Haunted Hotel: A Mystery of Modern Venice',
   'The Woman in White',
   'No Name',
   'Man and Wife',
   'The Black Robe',
   "A Rogue's Life",
   'Miss or Mrs.?',
   'The Law and the Lady',
   'The New Magdalen',
   'The Two Destinies',
   'The Frozen Deep',
   'After Dark',
   'The Evil Genius: A Domestic Story',
   "My Lady's Money",
   '"I Say No"',
   'Little Novels',
   'Armadale',
   'The Queen of Hearts',
   'The Legacy of Cain',
   'A Fair Penitent',
   'Antonina; Or, The Fall of Rome',
   'Poor Miss Finch',
   "Jezebel's Daughter",
   'The Guilty River',
   'Basil',
   'Blind Love',
   'The Dead Alive',
   'Heart and Science: A Story of the Present Time',
   'Hide and Seek',
   'The Fallen Leaves',
   "L'hôtel hanté",
   'John Jagon henki tahi kuollutko vai elävä?',
   'Ilman menestyksettä: Joulukertomus',
   'Sisar Rosa',
   'Rambles Beyond Railways; or, Notes in Cornwall taken A-foot',
   'Kamala yösija',
   'The Dead Secret: A Novel',
   'My Miscellanies, Vol. 1 (of 2)',
   'My Miscellanies, Vol. 2 (of 2)',
   'Valkopukuinen nainen I: Perheromaani',
   'Valkopukuinen nainen II: Perheromaani']
#+end_example

#+begin_src python
  pd.DataFrame(parsed)
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

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

LCC

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

_repo

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

_version

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

alternative_title

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

author

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

authoryearofbirth

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

authoryearofdeath

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

contributor

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

covers

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

tableOfContents

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

title

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

titlepage_image

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

type

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

url

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

wikipedia

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

wp_info

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

wp_literary_genres

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

wp_publication_date

#+begin_html
  </th>
#+end_html

#+begin_html
  <th>
#+end_html

wp_subjects

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

0

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

148

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Moonstone_155

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Moonstone

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/155

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['https://fr.wikipedia.org/wiki/La_Pierre_de_l...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Mystery_fiction', 'Epistolary_novel']

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Novels_first_published_in_serial_form', '199...

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

1

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

163

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Haunted-Hotel--A-Mystery-of-Modern-Venice_170

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Haunted Hotel: A Mystery of Modern Venice

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/170

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

2

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

574

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Woman-in-White_583

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Woman in White

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/583

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['https://fr.wikipedia.org/wiki/La_Femme_en_bl...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Mystery_fiction', 'Sensation_novel']

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Harper_&_Brothers_books', 'Victorian_novels'...

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

3

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1421

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

No-Name_1438

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

No Name

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1438

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['https://en.wikipedia.org/wiki/No_Name_(novel)']

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Mystery_fiction', 'Sensation_novel']

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Novels_by_Wilkie_Collins', '1862_novels', 'N...

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

4

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1569

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Man-and-Wife_1586

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Man and Wife

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1586

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

5

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1570

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Black-Robe_1587

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Black Robe

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1587

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Epistolary_novel', 'Sensation_novel', 'Myste...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['1881_novels', 'Epistolary_novels', 'British_...

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

6

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1571

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

A-Rogue-s-Life_1588

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

A Rogue's Life

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1588

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

7

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1604

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Miss-or-Mrs.-_1621

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Miss or Mrs.?

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1621

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

8

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1605

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Law-and-the-Lady_1622

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Law and the Lady

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1622

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['https://fr.wikipedia.org/wiki/Seule_contre_l...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Mystery_fiction']

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Novels_by_Wilkie_Collins', '1875_novels', 'B...

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

9

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1606

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-New-Magdalen_1623

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The New Magdalen

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1623

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

10

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1607

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Two-Destinies_1624

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Two Destinies

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1624

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

11

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1608

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Frozen-Deep_1625

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Frozen Deep

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1625

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Plays_by_Wilkie_Collins', 'Plays_by_Charles_...

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

12

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1609

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

After-Dark_1626

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

Leaves from Leah's diary -- The traveler's sto...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

After Dark

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1626

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['https://en.wikipedia.org/wiki/After_Dark_(sh...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Mystery_fiction', 'Short_story']

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Short_stories_by_Wilkie_Collins', '1856_shor...

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

13

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1610

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Evil-Genius--A-Domestic-Story_1627

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Evil Genius: A Domestic Story

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1627

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

14

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1611

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

My-Lady-s-Money_1628

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

My Lady's Money

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1628

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

15

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1612

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

-I-Say-No-_1629

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.1.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

"I Say No"

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1629

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Mystery_fiction', 'Sensation_novel']

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Novels_by_Wilkie_Collins', '1862_novels', 'N...

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

16

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1613

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Little-Novels_1630

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

Mrs. Zant and the ghost -- Miss Morris and the...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Little Novels

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1630

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

17

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1877

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Armadale_1895

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Armadale

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1895

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['https://en.wikipedia.org/wiki/Armadale_(nove...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Sensation_novel', 'Mystery_fiction']

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['British_mystery_novels', 'Novels_by_Wilkie_C...

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

18

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1899

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Queen-of-Hearts_1917

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Queen of Hearts

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1917

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

19

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1957

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Legacy-of-Cain_1975

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Legacy of Cain

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/1975

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

20

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

1988

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

A-Fair-Penitent_2006

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

A Fair Penitent

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/2006

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

21

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

3538

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Antonina--Or-The-Fall-of-Rome_3606

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Antonina; Or, The Fall of Rome

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/3606

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

22

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

3564

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Poor-Miss-Finch_3632

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Poor Miss Finch

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/3632

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Sensation_novel']

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['1872_novels', 'Novels_by_Wilkie_Collins']

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

23

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

3565

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Jezebel-s-Daughter_3633

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Jezebel's Daughter

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/3633

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

24

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

3566

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Guilty-River_3634

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Guilty River

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/3634

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

25

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

4536

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Basil_4605

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.2.0

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

[{'cover_type': 'generated', 'image_path': 'co...

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Basil

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/4605

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['1852_novels', 'Novels_by_Wilkie_Collins']

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

26

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

7763

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Blind-Love_7890

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.0.1

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'contributor': {'agent_name': 'Besant, Walter...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Blind Love

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/7890

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['https://en.wikipedia.org/wiki/Blind_Love_(no...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'http://www.w3.org/1999/02/22-rdf-syntax-ns#t...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

['Unfinished_novels', '1889_novels', 'Novels_b...

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

27

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

7764

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Dead-Alive_7891

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.0.1

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Dead Alive

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/7891

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

28

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

7765

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Heart-and-Science--A-Story-of-the-Present-Time...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.0.1

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Heart and Science: A Story of the Present Time

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/7892

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

29

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

7766

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Hide-and-Seek_7893

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.0.1

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Hide and Seek

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/7893

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

30

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

7767

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The-Fallen-Leaves_7894

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

0.0.1

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Fallen Leaves

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

http://www.gutenberg.org/ebooks/7894

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

31

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

14364

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

L'hôtel hanté

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

32

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

18673

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

John Jagon henki tahi kuollutko vai elävä?

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

33

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

19153

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Ilman menestyksettä: Joulukertomus

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

34

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

22310

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Sisar Rosa

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

35

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

27192

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'DA'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Rambles Beyond Railways; or, Notes in Cornwall...

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

36

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

33874

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Kamala yösija

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

37

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

41851

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

The Dead Secret: A Novel

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

38

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

42652

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

My Miscellanies, Vol. 1 (of 2)

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

39

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

43109

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

{'PR'}

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

My Miscellanies, Vol. 2 (of 2)

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

40

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

52677

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

set()

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Valkopukuinen nainen I: Perheromaani

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

41

#+begin_html
  </th>
#+end_html

#+begin_html
  <td>
#+end_html

52678

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

set()

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Collins, Wilkie

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1824

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

1889

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Valkopukuinen nainen II: Perheromaani

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

Text

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

#+begin_html
  </td>
#+end_html

#+begin_html
  <td>
#+end_html

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

42 rows × 46 columns

#+begin_html
  </p>
#+end_html

Cool. Maybe we just need only the first 10 or so, though. Get the IDs of the first 10:

#+begin_src python
  first10Collins = [item['id'] for item in parsed[:10]]
#+end_src

Now for each of these IDs, we'll get the full text from corpus-db, like this:

#+begin_src python
  def getFullText(bookID): 
      response = requests.get('http://corpus-db.org/api/id/' + bookID + '/fulltext')
      if response.ok: 
          print('Got full text for ' + bookID)
          parsed = json.loads(response.text)
          if len(parsed)>0 and 'text' in parsed[0]: t
              return parsed[0]['text']
      else: 
          print('Response came back bad: ' + response.status)
#+end_src

#+begin_src python
  moonstoneResponse = getFullText('155.0')
#+end_src

#+begin_example
  Got full text for 155.0
#+end_example

#+begin_src python
  moonstoneResponse[:30]
#+end_src

#+begin_example
  '\n\n\n\n\n\n\nTHE MOONSTONE\n\nA Romanc'
#+end_example

#+begin_src python
  collinsTexts = [getFullText(bookID) for bookID in first10Collins]
#+end_src

#+begin_example
  Got full text for 155.0
  Got full text for 170.0
  Got full text for 583.0
  Got full text for 1438.0
  Got full text for 1586.0
  Got full text for 1587.0
  Got full text for 1588.0
  Got full text for 1621.0
  Got full text for 1622.0
  Got full text for 1623.0
#+end_example

Now we can verify that we have the full text of the first 10 Collins works:

#+begin_src python
  [text[:100].strip() for text in collinsTexts]
#+end_src

#+begin_example
  ['THE MOONSTONE\n\nA Romance\n\nby Wilkie Collins\n\n\n\n\nPROLOGUE\n\nTHE STORMING OF SERINGAPATAM (1799)',
   'THE HAUNTED HOTEL\n\nA Mystery of Modern Venice\n\n\nby\n\nWilkie Collins (1824-1889)\n\n\n\n(aft',
   'The Woman in White\n\n\nby\n\nWilkie Collins\n\n\n\n\nCONTENTS\n\nFirst Epoch\n\n  THE STORY BEGUN BY',
   'NO NAME\n\n\nby Wilkie Collins\n\n\n     [editorial note: italics are indicated by the underscore',
   'MAN AND WIFE\n\nby Wilkie Collins\n\n\n\n\nPROLOGUE.--THE IRISH MARRIAGE.\n\n\n\nPart the First.\n\n\n\nTHE VI',
   'THE BLACK ROBE\n\nby Wilkie Collins\n\n\n\n\nBEFORE THE STORY.\n\n\n\n\nFIRST SCENE.--BOULOGNE-SUR-MER.--TH',
   "A ROGUE'S LIFE\n\nby Wilkie Collins\n\n\n\n\nINTRODUCTORY WORDS.\n\nThe following pages were written mor",
   'MISS OR MRS.?\n\nby Wilkie Collins\n\n\n\n\nPERSONS OF THE STORY.\n\n     Sir Joseph Graybrooke. . . . .',
   'THE LAW AND THE LADY\n\nby Wilkie Collins\n\n\n\n\nNOTE:\n\nADDRESSED TO THE READER.\n\nIN offering this b',
   'THE NEW MAGDALEN\n\nby Wilkie Collins\n\n\n\n\nTO THE MEMORY OF CHARLES ALLSTON COLLINS. (9th April, 1']
#+end_example

#+begin_src python
  "HELLO".lower()
#+end_src

#+begin_example
  'hello'
#+end_example

#+begin_src python
  "HELLO".lower
#+end_src

#+begin_example
  <function str.lower>
#+end_example

#+begin_src python
#+end_src
