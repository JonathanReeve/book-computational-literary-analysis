#+begin_src python
  from glob import glob
  from sklearn.feature_extraction.text import TfidfVectorizer
  from sklearn.decomposition import PCA
  import pandas as pd
  from matplotlib import pyplot as plt
  %matplotlib inline
  import matplotlib.pyplot as plt
  from random import choice
  plt.rcParams['figure.figsize'] = [8, 8]
#+end_src

* A Comparative Stylometry of Katherine Mansfield Stories
  :PROPERTIES:
  :CUSTOM_ID: a-comparative-stylometry-of-katherine-mansfield-stories
  :END:
What I've done in the background here is created individual text files for each of the Katherine Mansfield stories that we've read, and I've put them all in a directory called =Texts=. I'll just change into that directory first:

#+begin_src python
  %cd ../Texts
#+end_src

#+begin_example
  /home/jon/Code/course-computational-literary-analysis/Texts
#+end_example

Now I'll just make sure all the texts are there:

#+begin_src python
  %ls
#+end_src

#+begin_example
  daughters.md  first-ball.md          ma-parker.md  stranger.md  young.md
  dove.md       garden-party-story.md  marriage.md   voyage.md
#+end_example

And finally I'll use the =glob()= function from the =glob= library to get a list of all =.md= files. I have to sort them alphabetically, just in case blob doesn't care about their order.

#+begin_src python
  mansfieldStories = [open(story).read() for story in sorted(glob('*.md'))]
#+end_src

Now I'll generate labels from the filenames, since we'll need labels to label the points on the plot we're creating.

#+begin_src python
  mansfieldLabels = [story[:-3] for story in sorted(glob('*.md'))]
  mansfieldLabels
#+end_src

#+begin_example
  ['daughters',
   'dove',
   'first-ball',
   'garden-party-story',
   'ma-parker',
   'marriage',
   'stranger',
   'voyage',
   'young']
#+end_example

#+begin_src python
  mansfieldLabels = ["Daughters of the Late", "Mr and Mrs Dove", 'Her First Ball', 
                     'The Garden Party', 'Life of Ma Parker', 'Marriage a la Mode', 
                     'The Stranger', 'The Voyage', 'The Young Girl']
#+end_src

Peek at the first 200 characters of each one, to make sure everything is as expected:

#+begin_src python
  [story[:200] for story in mansfieldStories]
#+end_src

#+begin_example
  ['\n\nChapter 3.I.\n------------\n\nThe week after was one of the busiest weeks of their lives. Even when\nthey went to bed it was only their bodies that lay down and rested;\ntheir minds went on, thinking thi',
   "\n4. MR. AND MRS. DOVE.\n---------------------\n\nOf course he knew---no man better---that he hadn't a ghost of a chance,\nhe hadn't an earthly. The very idea of such a thing was preposterous.\nSo preposter",
   '\n\n10. HER FIRST BALL.\n-------------------\n\nExactly when the ball began Leila would have found it hard to say.\nPerhaps her first real partner was the cab. It did not matter that she\nshared the cab with',
   '2. THE GARDEN PARTY.\n--------------------\n\nAnd after all the weather was ideal. They could not have had a more\nperfect day for a garden-party if they had ordered it. Windless, warm,\nthe sky without a ',
   '\n6. LIFE OF MA PARKER.\n---------------------\n\nWhen the literary gentleman, whose flat old Ma Parker cleaned every\nTuesday, opened the door to her that morning, he asked after her\ngrandson. Ma Parker s',
   '\n7. MARRIAGE A LA MODE.\n----------------------\n\nOn his way to the station William remembered with a fresh pang of\ndisappointment that he was taking nothing down to the kiddies. Poor\nlittle chaps! It w',
   '\n\n12. THE STRANGER\n----------------\n\nIt seemed to the little crowd on the wharf that she was never going to\nmove again. There she lay, immense, motionless on the grey crinkled\nwater, a loop of smoke a',
   '\n\n8. THE VOYAGE.\n--------------\n\nThe Picton boat was due to leave at half-past eleven. It was a beautiful\nnight, mild, starry, only when they got out of the cab and started to\nwalk down the Old Wharf ',
   '\n5. THE YOUNG GIRL.\n------------------\n\nIn her blue dress, with her cheeks lightly flushed, her blue, blue eyes,\nand her gold curls pinned up as though for the first time---pinned up to\nbe out of the ']
#+end_example

And check their respective lengths, to see if we can adjust those somehow.

#+begin_src python
  [len(story) for story in mansfieldStories]
#+end_src

#+begin_example
  [40291, 18347, 14225, 30014, 13713, 21669, 24910, 17373, 12000]
#+end_example

#+begin_src python
  min([len(story) for story in mansfieldStories])
#+end_src

#+begin_example
  12000
#+end_example

#+begin_src python
  mansfieldStories = [story[:13000] for story in mansfieldStories[:-1]]
#+end_src

Let's remove the last one, and truncate each story to 13,000 characters, so that we're comparing the same amount of text in each, roughly speaking.

#+begin_src python
  [len(story) for story in mansfieldStories]
#+end_src

#+begin_example
  [13000, 13000, 13000, 13000, 13000, 13000, 13000, 13000]
#+end_example

And let's not forget to remove the last label, too.

#+begin_src python
  mansfieldLabels = mansfieldLabels[:-1]
#+end_src

Now we can initialize our vectorizer (just the thing that counts all the words, in this case). We have to give it all the options we want to set here. Here I'm turning off IDF (i.e. not adjusting for the frequency with which each word occurs in the corpus), and I'm limiting the matrix to the top 800 most frequent words.

#+begin_src python
  tfidf = TfidfVectorizer(use_idf=False, max_features=800)
#+end_src

Next, calculate the term frequencies of each word in these stories, and make the resulting matrix dense:

#+begin_src python
  tf = tfidf.fit_transform(mansfieldStories).todense()
#+end_src

Reduce the dimensions to 2 using PCA, so we can plot it:

#+begin_src python
  pca = PCA(n_components=2)
#+end_src

#+begin_src python
  pcaOut = pca.fit_transform(tf)
#+end_src

And finally plot our results:

#+begin_src python
  xs, ys = pcaOut[:,0], pcaOut[:,1]
  for i in range(len(xs)): 
      plt.scatter(xs[i], ys[i])
      plt.annotate(mansfieldLabels[i], (xs[i], ys[i]))
#+end_src

#+caption: png
[[file:12-Stylometry2_files/12-Stylometry2_28_0.png]]

If we tweak the parameters a bit, we can see different textual similarities. For instance, if we adjust the =min_df= and =max_df=, we can specify that we want to see words that occur in at least 2 stories (which will ignore most names and other story-specific words), and not words that occur in more than 50% of stories (which will ignore function words). This will give us mostly content words that are specific to each story. By turning on IDF, we can adjust each frequency for how often they occur in the corpus, accentuating this slicing methos:

#+begin_src python
  tfidf = TfidfVectorizer(use_idf=True, 
                          stop_words='english', min_df=2, max_df=.5)
#+end_src

#+begin_src python
  tf = tfidf.fit_transform(mansfieldStories).todense()
#+end_src

#+begin_src python
  wordLabels = tfidf.get_feature_names()
#+end_src

#+begin_src python
  df = pd.DataFrame(tf, index=mansfieldLabels, columns=wordLabels)
#+end_src

#+begin_src python
  pcaOut = pca.fit_transform(tf)
#+end_src

#+begin_src python
  xs, ys = pcaOut[:,0], pcaOut[:,1]
  for i in range(len(xs)): 
      plt.scatter(xs[i], ys[i])
      plt.annotate(mansfieldLabels[i], (xs[i], ys[i]))
#+end_src

#+caption: png
[[file:12-Stylometry2_files/12-Stylometry2_35_0.png]]

** Adding in word/theme annotations
   :PROPERTIES:
   :CUSTOM_ID: adding-in-wordtheme-annotations
   :END:
In addition to plotting each of these stories, we can create new "stories" which only contain words from some themes we're interested in. Then we can see where our stories fall in relation to these theme documents.

#+begin_src python
  marriageWords = 'marriage marry husband wife wedding'
  flowerWords = 'flower lilly daisy rose bloom blossom'
  mansfieldStories = mansfieldStories + [marriageWords, flowerWords]
  mansfieldLabels = mansfieldLabels + ['marriage', 'flowers']
#+end_src

#+begin_src python
  tfidf = TfidfVectorizer(use_idf=True, stop_words='english')
#+end_src

#+begin_src python
  tf = tfidf.fit_transform(mansfieldStories).todense()
#+end_src

#+begin_src python
  pcaOut = pca.fit_transform(tf)
#+end_src

#+begin_src python
  xs, ys = pcaOut[:,0], pcaOut[:,1]
  for i in range(len(xs)): 
      plt.scatter(xs[i], ys[i])
      plt.annotate(mansfieldLabels[i], (xs[i], ys[i]))
#+end_src

#+caption: png
[[file:12-Stylometry2_files/12-Stylometry2_41_0.png]]
