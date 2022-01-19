* Sentences
  :PROPERTIES:
  :CUSTOM_ID: sentences
  :END:
Let's use SpaCy to analyze sentence structure. First, import all the usual libraries, and get a few test texts from Dubliners by splitting on chapter headings:

#+begin_src python
  import spacy
  import pandas as pd
  from collections import Counter
  %matplotlib inline
  import matplotlib.pyplot as plt
  plt.rcParams['figure.figsize'] = [10, 6]
#+end_src

#+begin_src python
  nlp = spacy.load('en_core_web_lg')
#+end_src

#+begin_src python
  dublinersParts = open('dubliners.md').read().split('##')
#+end_src

#+begin_src python
  dublinersParts = dublinersParts[1:]
#+end_src

#+begin_src python
  dublinersParts = dublinersParts[:6]
#+end_src

#+begin_src python
  len(dublinersParts)
#+end_src

#+begin_example
  6
#+end_example

#+begin_src python
  dublinersDocs = [nlp(text) for text in dublinersParts]
#+end_src

#+begin_src python
  dublinersLabels = ['The Sisters', 'An Encounter', 'Araby', 
                     'Eveline', 'After the Race', 'Two Gallants']
#+end_src

It's always a good idea to check the length of each text we're comparing.

#+begin_src python
  pd.Series([len(text) for text in dublinersDocs], 
            index=dublinersLabels).plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f66baedd940>
#+end_example

#+caption: png
[[file:16-Spacy-Sentences_files/16-Spacy-Sentences_10_1.png]]

And check the number of sentences in each:

#+begin_src python
  [len(list(doc.sents)) for doc in dublinersDocs]
#+end_src

#+begin_example
  [230, 204, 153, 135, 141, 316]
#+end_example

Make a list of all sentences in each. This list is going to be a list of lists: the outer list represents each story, and each inner list is a list of all the sentences in that story.

#+begin_src python
  allSents = [list(doc.sents) for doc in dublinersDocs]
#+end_src

Make a list of the lengths of each sentence. This is also going to be a list of lists, where each inner list is a list of the lengths of each sentence.

#+begin_src python
  sentLengths = [[len(sent) for sent in doc] for doc in allSents]
#+end_src

Now we can average those lists:

#+begin_src python
  avgSentLen = [sum(lengths)/len(lengths) for lengths in sentLengths]
#+end_src

If we wanted to, we could also write that the long way, using a =for= loop. Either method is valid. Use whatever you're most comfortable with. I find list comprehensions more useful, but you might prefer the readability of a =for= loop.

#+begin_src python
  averages = []
  for lengths in sentLengths: 
      total = sum(lengths)
      num = len(lengths)
      average = total/num
      averages.append(averages)
#+end_src

Let's peek at the average sentence lengths for each story:

#+begin_src python
  avgSentLen
#+end_src

#+begin_example
  [17.213043478260868,
   19.29901960784314,
   18.640522875816995,
   16.57037037037037,
   19.49645390070922,
   15.762658227848101]
#+end_example

They're pretty similar. We could plot them if we wanted to:

#+begin_src python
  pd.Series(avgSentLen).plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f66d3de7828>
#+end_example

#+caption: png
[[file:16-Spacy-Sentences_files/16-Spacy-Sentences_24_1.png]]

** Dependency Parsing
   :PROPERTIES:
   :CUSTOM_ID: dependency-parsing
   :END:
We can use SpaCy to parse the syntactic relationships between words. For example, in the phrase "the quick brown fox," the words "quick" and "brown" are adjectives describing "fox," so we could say that they're /dependent/ on "fox." First, I'll copy-and-paste some code here that I wrote earlier, to shoehorn SpaCy sentences into =ete3= objects, so that I can visualize them. You don't have to worry too much about how this code works (it's pretty complicated), and if you can't get it to work because you don't have the =ete3= library, don't worry about that, either, since there are different ways of visualizing syntax.

#+begin_src python
  ## Code for visualizing sentences as trees. 
  import ete3
  from ete3 import Tree, TreeStyle, TextFace, add_face_to_node

  class sentenceTree(): 
      def __init__(self, sent): 
          """ Takes a SpaCy sentence as input. """ 
          self.sent = sent
          self.root = sent.root
          print(self.sent)
          self.sentDict = self.sentToDict(self.root)
          self.newick = self.newickify(self.sentDict) + ';'

      def isPunct(self, thing): 
          if type(thing) == str: 
              if thing.strip() in "!@#$%^&*()_+-=,./<>?;':[]\{}|`~": 
                  return True
          return False

      def sentToDict(self, node): 
          children = [child for child in node.children 
                     if self.isPunct(child.string.strip()) == False # ignore punctuation
                     and child.tag_ != 'SP'] #ignore spaces and newlines
          root = node.string.strip()
          if len(children) == 0: 
              return node.string.strip()
          return {node.string.strip(): [self.sentToDict(child) 
                                        for child in children]}

      def newickify(self, node): 
          if type(node) == str:
              return node.strip()
          root = list(node)[0]
          return '(' + ','.join([self.newickify(child) 
              for child in node[root] ]) + ')' + root
      
      def render(self, textMode=False): 
          """ 
          textMode=False will show a graphical tree. 
          textmode=True will show an ASCII tree. 
          """
          t = Tree(self.newick, format=1)
          if textMode: 
              print(t.get_ascii(show_internal=True))
          else: 
              ts = TreeStyle()
              ts.show_leaf_name = False
              #TODO: make this not be a function
              def my_layout(node):
                  F = TextFace(node.name, tight_text=False)
                  add_face_to_node(F, node, column=0, position="branch-right")
              ts.layout_fn = my_layout        
              return t.render('%%inline', tree_style=ts)
#+end_src

First, make a SpaCy document out of an example sentence.

#+begin_src python
  foxDoc = nlp("The quick brown fox jumped over the lazy dogs.")
#+end_src

Since =doc.sents= is a generator (a thing which creates lists), we have to force it into a list using =list()= before we can index it:

#+begin_src python
  foxSent = list(foxDoc.sents)[0]
#+end_src

Now we can use my code to render it:

#+begin_src python
  sentenceTree(foxSent).render()
#+end_src

#+begin_example
  The quick brown fox jumped over the lazy dogs.
#+end_example

#+caption: png
[[file:16-Spacy-Sentences_files/16-Spacy-Sentences_32_1.png]]

** Navigating the Sentence Tree Using SpaCy
   :PROPERTIES:
   :CUSTOM_ID: navigating-the-sentence-tree-using-spacy
   :END:
Let's explore the dependencies between various words and phrases using SpaCy. First, look at the sentence:

#+begin_src python
  foxSent
#+end_src

#+begin_example
  The quick brown fox jumped over the lazy dogs.
#+end_example

Every sentence has a root verb:

#+begin_src python
  foxSent.root
#+end_src

#+begin_example
  jumped
#+end_example

And every verb has a root form, or lemma:

#+begin_src python
  foxSent.root.lemma_
#+end_src

#+begin_example
  'jump'
#+end_example

Let's play around with the story "Eveline":

#+begin_src python
  evelineDoc = dublinersDocs[3]
#+end_src

Grab all the lemmas of all the root verbs, and make them into a Pandas Series object:

#+begin_src python
  s = pd.Series([sent.root.lemma_ for sent in evelineDoc.sents])
#+end_src

Now we can get their counts:

#+begin_src python
  evelineVerbs = s.value_counts()
  evelineVerbs.head()
#+end_src

#+begin_example
  be      25
  have     8
  use      5
  give     4
  come     4
  dtype: int64
#+end_example

Do the same for "Araby":

#+begin_src python
  arabyDoc = dublinersDocs[2]
#+end_src

#+begin_src python
  arabyVerbs = pd.Series([sent.root.lemma_ for sent in arabyDoc.sents]).value_counts()
  arabyVerbs.head()
#+end_src

#+begin_example
  be      19
  say      6
  ask      5
  hear     4
  go       4
  dtype: int64
#+end_example

We can now compare these two Series objects using a Pandas DataFrame. Since our data frame is enormous, let's look at just a few verbs:

#+begin_src python
  pd.DataFrame([evelineVerbs, arabyVerbs], 
               index=['Eveline', 'Araby'])[['be', 'have', 'think', 'want', 'walk']].fillna(0).plot(kind='bar')
#+end_src

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7f66badb8438>
#+end_example

#+caption: png
[[file:16-Spacy-Sentences_files/16-Spacy-Sentences_49_1.png]]

#+begin_src python
  foxSent
#+end_src

#+begin_example
  The quick brown fox jumped over the lazy dogs.
#+end_example

#+begin_src python
  foxSent.root
#+end_src

#+begin_example
  jumped
#+end_example

#+begin_src python
  foxRoot = foxSent.root
#+end_src

Every root verb has dependencies, or "children":

#+begin_src python
  list(foxRoot.children)
#+end_src

#+begin_example
  [fox, over, .]
#+end_example

#+begin_src python
  fox = list(foxRoot.children)[0]
#+end_src

#+begin_src python
  fox
#+end_src

#+begin_example
  fox
#+end_example

And some children also have children (you can think of this kind of like a family tree):

#+begin_src python
  list(fox.children)
#+end_src

#+begin_example
  [The, quick, brown]
#+end_example

#+begin_src python
  frankSent = "Frank was very kind, manly, open-hearted."
#+end_src

#+begin_src python
  frankDoc = nlp(frankSent)
#+end_src

#+begin_src python
  frankSent = next(frankDoc.sents)
#+end_src

#+begin_src python
  frankSent
#+end_src

#+begin_example
  Frank was very kind, manly, open-hearted.
#+end_example

#+begin_src python
  sentenceTree(frankSent).render()
#+end_src

#+begin_example
  Frank was very kind, manly, open-hearted.
#+end_example

#+caption: png
[[file:16-Spacy-Sentences_files/16-Spacy-Sentences_63_1.png]]

If you want, you can write a function that navigates through this dependency graph, looking for, say, adjectives that are dependent on certain character names:

#+begin_src python
  def adjectivesDescribingCharacters(text, character):
      sents = [sent for sent in text.sents if character in sent.string]
      adjectives = []
      for sent in sents: 
          for word in sent: 
              if character in word.string:
                  for child in word.children:
                      if child.pos_ == 'ADJ': 
                          adjectives.append(child.string.strip())
      return Counter(adjectives).most_common(10)
#+end_src

#+begin_src python
  adjectivesDescribingCharacters(arabyDoc, 'sister')
#+end_src

#+begin_example
  [('his', 1)]
#+end_example

** Visualizing Using DisplaCy
   :PROPERTIES:
   :CUSTOM_ID: visualizing-using-displacy
   :END:
You can also visualize sentences a different way using SpaCy's built-in DisplaCy visualizer:

#+begin_src python
  spacy.displacy.render(frankDoc, jupyter=True, options={'distance': 90})
#+end_src

#+begin_example
  /usr/lib/python3.6/runpy.py:193: DeprecationWarning: Positional arguments to Doc.merge are deprecated. Instead, use the keyword arguments, for example tag=, lemma= or ent_type=.
    "__main__", mod_spec)
  /usr/lib/python3.6/runpy.py:193: DeprecationWarning: Positional arguments to Doc.merge are deprecated. Instead, use the keyword arguments, for example tag=, lemma= or ent_type=.
    "__main__", mod_spec)
  /usr/lib/python3.6/runpy.py:193: DeprecationWarning: Positional arguments to Doc.merge are deprecated. Instead, use the keyword arguments, for example tag=, lemma= or ent_type=.
    "__main__", mod_spec)
  /usr/lib/python3.6/runpy.py:193: DeprecationWarning: Positional arguments to Doc.merge are deprecated. Instead, use the keyword arguments, for example tag=, lemma= or ent_type=.
    "__main__", mod_spec)
#+end_example

#+begin_html
  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="0" class="displacy" width="680" height="317.0" style="max-width: none; height: 317.0px; color: #000000; background: #ffffff; font-family: Arial">
#+end_html

Frank NNP

was VBD

very RB

kind, JJ

manly, JJ

open- JJ

hearted. JJ

nsubj

advmod

advmod

amod

amod

acomp

#+begin_html
  </svg>
#+end_html

...which you can also use to show, for instance, named entities that SpaCy recognizes:

#+begin_src python
  spacy.displacy.render(frankDoc, style='ent', jupyter=True, options={'distance': 90})
#+end_src

Frank PERSON was very kind, manly, open-hearted.
