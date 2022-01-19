* Plotting words in narrative time
  :PROPERTIES:
  :CUSTOM_ID: plotting-words-in-narrative-time
  :END:
Here's we'll use a new kind of object---a numpy Array---to bin together a numeric representation of token occurrence in narrative time. This is basically like creating what the NLTK calls a lexical dispersion plot, but we'll be making it ourselves.

First, as usual, import all the libraries we need to import:

#+begin_src python
  import nltk
  from nltk import word_tokenize
  import pandas as pd
  import numpy as np
  %matplotlib inline
#+end_src

We'll start by loading the file, as usual, and tokenizing it. I'm also lowercasing the file here, so that our searches will be case-insensitive.

#+begin_src python
  moonstone = open('/home/jon/Code/course-computational-literary-analysis/moonstone.md').read().lower()
  moonstoneTokens = word_tokenize(moonstone)
#+end_src

Now we'll just create a binary representation of whether each token is an exclamation point or not. If it is, write "1," and if it isn't, write "0." To do this, we'll use a list comprehension:

#+begin_src python
  isEx = [1 if token is "!" else 0 for token in moonstoneTokens]
#+end_src

How many exclamation points are there?

#+begin_src python
  sum(isEx)
#+end_src

#+begin_example
  992
#+end_example

Convert this to a Numpy array, so that we can work with it easier.

#+begin_src python
  isExArray = np.array(isEx)
  isExArray
#+end_src

#+begin_example
  array([0, 0, 0, ..., 0, 0, 0])
#+end_example

Now we can split this into 10 boxes along narrative time. The first will represent the first 10th of the novel (i.e. the first 100 pages of a 1,000 page novel), and so on.

#+begin_src python
  exBoxes = np.array_split(isExArray, 10)
#+end_src

Now we can take the sum of each box, to determine the number of exclamation points in each tenth of the novel.

#+begin_src python
  exSums = [np.sum(box) for box in exBoxes]
  exSums
#+end_src

#+begin_example
  [70, 86, 75, 94, 133, 142, 93, 134, 79, 86]
#+end_example

Then plot the results using Pandas.

#+begin_src python
  pd.Series(exSums).plot()
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f17b6e64b70>
#+end_example

#+caption: png
[[file:06-Narrative-Time_files/06-Narrative-Time_15_1.png]]

Here's all that code in a function:

#+begin_src python
  def narrativeTime(word, nBoxes=10): 
      binary = [1 if token.lower() == word.lower()
                else 0 for token in moonstoneTokens]
      array = np.array(binary)
      split = np.array_split(array, nBoxes)
      sums = [np.sum(box) for box in split]
      pd.Series(sums).plot()
#+end_src

Now we can feed lots of new parameters to that function, to plot them in narrative time, and with varying degrees of granularity:

#+begin_src python
  narrativeTime('true', 10)
#+end_src

#+caption: png
[[file:06-Narrative-Time_files/06-Narrative-Time_19_0.png]]

#+begin_src python
#+end_src
