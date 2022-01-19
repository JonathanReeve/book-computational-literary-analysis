#+begin_example
  import networkx as nx
  import spacy
  from collections import Counter
  from itertools import combinations
  import pandas as pd
  import holoviews as hv
  import numpy as np
  %matplotlib inline
  from matplotlib import pyplot as plt
  plt.rcParams['figure.figsize'] = [10, 8]
  hv.extension('bokeh')
  %output size=200
#+end_example

#+begin_html
  <style>div.hololayout {
    display: flex;
    align-items: center;
    margin: 0;
  }

  div.holoframe {
    width: 75%;
  }

  div.holowell {
    display: flex;
    align-items: center;
  }

  form.holoform {
    background-color: #fafafa;
    border-radius: 5px;
    overflow: hidden;
    padding-left: 0.8em;
    padding-right: 0.8em;
    padding-top: 0.4em;
    padding-bottom: 0.4em;
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
    margin-bottom: 20px;
    border: 1px solid #e3e3e3;
  }

  div.holowidgets {
    padding-right: 0;
    width: 25%;
  }

  div.holoslider {
    min-height: 0 !important;
    height: 0.8em;
    width: 100%;
  }

  div.holoformgroup {
    padding-top: 0.5em;
    margin-bottom: 0.5em;
  }

  div.hologroup {
    padding-left: 0;
    padding-right: 0.8em;
    width: 100%;
  }

  .holoselect {
    width: 92%;
    margin-left: 0;
    margin-right: 0;
  }

  .holotext {
    padding-left:  0.5em;
    padding-right: 0;
    width: 100%;
  }

  .holowidgets .ui-resizable-se {
    visibility: hidden
  }

  .holoframe > .ui-resizable-se {
    visibility: hidden
  }

  .holowidgets .ui-resizable-s {
    visibility: hidden
  }


  /* CSS rules for noUISlider based slider used by JupyterLab extension  */

  .noUi-handle {
    width: 20px !important;
    height: 20px !important;
    left: -5px !important;
    top: -5px !important;
  }

  .noUi-handle:before, .noUi-handle:after {
    visibility: hidden;
    height: 0px;
  }

  .noUi-target {
    margin-left: 0.5em;
    margin-right: 0.5em;
  }

  div.bk-hbox {
      display: flex;
      justify-content: center;
  }

  div.bk-hbox div.bk-plot {
      padding: 8px;
  }

  div.bk-hbox div.bk-data-table {
      padding: 20px;
  }
  </style>
#+end_html

#+begin_example
  nlp = spacy.load('en_core_web_lg')
#+end_example

#+begin_example
  moonstone = open('../moonstone.md').read()
#+end_example

#+begin_example
  moonstoneParts = moonstone.split('%%%%%')
#+end_example

#+begin_example
  betteredge, clack, bruff, blake = [moonstoneParts[i] for i in [1, 3, 5, 6]]
#+end_example

#+begin_example
  def getParaDocs(rawText):
      return [nlp(para) for para in rawText.split('\n\n')]

  def findPeople(doc):
      return [ent for ent in doc.ents if ent.label_ == 'PERSON']

  def findPeopleInParas(doc):
      return [findPeople(paraDoc) for paraDoc in doc]
#+end_example

#+begin_example
  betDocs = getParaDocs(betteredge)
  betPeeps = findPeopleInParas(betDocs)
#+end_example

#+begin_example
  clackDocs = getParaDocs(clack)
  clackPeeps = findPeopleInParas(clackDocs)
#+end_example

#+begin_example
  bruffDocs = getParaDocs(bruff)
  bruffPeeps = findPeopleInParas(bruffDocs)
#+end_example

#+begin_example
  blakeDocs = getParaDocs(blake)
  blakePeeps = findPeopleInParas(blakeDocs)
#+end_example

#+begin_example
  def resolveName(name):
      name = name.text.lower().replace(',', '')
      if name in ['sergeant cuff', 'cuff', 'sergeant']: 
          return 'cuff'
      if name in ['rachel', 'miss verinder']:
          return 'rachel'
      if name in ['godfrey', 'godfrey ablewhite', 'ablewhite']:
          return 'ablewhite'
      if name in ['betteredge', 'gabriel']:
          return 'betteredge'
      if name in ['penelope']:
          return 'penelope'
      if name in ['herncastle']:
          return 'herncastle'
      if name in ['superintendent seegrave', 'seegrave']:
          return 'seegrave'
      if name in ['rosanna', 'spearman', 'rosanna spearman']:
          return 'rosanna'
      if name in ['blake', 'franklin blake', 'franklin']:
          return 'blake'
      if name in ['lucy', 'limping', 'limping lucy']:
          return 'lucy'
      if name in ['diamond', 'moonstone']:
          return 'diamond'
      if name in ['crusoe', 'robinson', 'robinson crusoe', 'robinson crusoes']:
          return 'robinson'
#+end_example

#+begin_example
  list(combinations((2,3,4,5),2))
#+end_example

#+begin_example
  [(2, 3), (2, 4), (2, 5), (3, 4), (3, 5), (4, 5)]
#+end_example

#+begin_example
  def findPairs(people):
      """ Given a list of lists, representing people in paragraphs, 
      return a dictionary where the key is the pairs of people
      (that appear in the same paragraph), and the value is the number of times
      they appear in paragraphs together. """
      allResolved = []
      allChars = []
      for para in people: 
          if len(para) >= 2: # We need at least two to form a pair. 
              pairs = []
              for ent in para:
                  resolved = resolveName(ent)
                  if resolved is not None and len(resolved)>0:
                      pairs.append(resolved)
                      allChars.append(resolved)
              if len(pairs) >= 2:
                  tup = tuple(set(pairs))
                  if len(tup) == 2:
                      allResolved.append(tuple(set(pairs)))
                  elif len(tup) > 2:
                      allResolved += combinations(tup, 2)
      return list(set(allChars)), dict(Counter(allResolved))
#+end_example

#+begin_example
  nodes, edges = findPairs(betPeeps)
#+end_example

#+begin_example
  nodes
#+end_example

#+begin_example
  ['blake',
   'cuff',
   'herncastle',
   'lucy',
   'diamond',
   'robinson',
   'rachel',
   'rosanna',
   'ablewhite',
   'seegrave',
   'penelope',
   'betteredge']
#+end_example

#+begin_example
  edges
#+end_example

#+begin_example
  {('ablewhite', 'betteredge'): 3,
   ('ablewhite', 'blake'): 4,
   ('ablewhite', 'cuff'): 2,
   ('ablewhite', 'diamond'): 1,
   ('ablewhite', 'penelope'): 5,
   ('ablewhite', 'rachel'): 15,
   ('ablewhite', 'seegrave'): 2,
   ('betteredge', 'penelope'): 3,
   ('betteredge', 'rachel'): 8,
   ('betteredge', 'robinson'): 1,
   ('betteredge', 'rosanna'): 24,
   ('blake', 'betteredge'): 4,
   ('blake', 'cuff'): 5,
   ('blake', 'lucy'): 2,
   ('blake', 'penelope'): 15,
   ('blake', 'rachel'): 15,
   ('blake', 'rosanna'): 12,
   ('cuff', 'betteredge'): 10,
   ('cuff', 'lucy'): 3,
   ('cuff', 'penelope'): 5,
   ('cuff', 'rachel'): 11,
   ('cuff', 'rosanna'): 26,
   ('diamond', 'ablewhite'): 1,
   ('diamond', 'betteredge'): 5,
   ('diamond', 'blake'): 1,
   ('diamond', 'cuff'): 3,
   ('diamond', 'penelope'): 1,
   ('diamond', 'rachel'): 11,
   ('diamond', 'rosanna'): 4,
   ('herncastle', 'betteredge'): 4,
   ('lucy', 'betteredge'): 2,
   ('lucy', 'penelope'): 2,
   ('lucy', 'rosanna'): 5,
   ('penelope', 'blake'): 3,
   ('penelope', 'cuff'): 1,
   ('penelope', 'rachel'): 21,
   ('penelope', 'robinson'): 1,
   ('penelope', 'rosanna'): 12,
   ('robinson', 'rachel'): 1,
   ('rosanna', 'penelope'): 1,
   ('rosanna', 'rachel'): 10,
   ('seegrave', 'ablewhite'): 1,
   ('seegrave', 'betteredge'): 3,
   ('seegrave', 'blake'): 1,
   ('seegrave', 'cuff'): 6,
   ('seegrave', 'penelope'): 1,
   ('seegrave', 'rachel'): 2,
   ('seegrave', 'rosanna'): 3}
#+end_example

#+begin_example
  help(makeNetworkXGraph)
#+end_example

#+begin_example
  Help on function makeNetworkXGraph in module __main__:

  makeNetworkXGraph(nodes, edges)
      Given a list of nodes (in this case, characters), and edges
      (the number of times pairs appear in paragraphs together), construct a 
      NetworkX graph.
#+end_example

#+begin_example
  def makeNetworkXGraph(nodes, edges):
      """ Given a list of nodes (in this case, characters), and edges
      (the number of times pairs appear in paragraphs together), construct a 
      NetworkX graph."""
      g = nx.Graph()
      g.add_nodes_from(nodes)
      for pair, count in edges.items():
          g.add_edge(pair[0], pair[1], weight=count)
      return g
#+end_example

#+begin_example
  def plotNetworkXGraph(nodes, edges):
      g = makeNetworkXGraph(nodes, edges)
      weights = np.array([count for pair, count in edges.items()])
      nx.draw_networkx(makeNetworkXGraph(nodes, edges), alpha=0.8, 
                       width=weights/2, edge_color='pink')
#+end_example

#+begin_example
  plotNetworkXGraph(*findPairs(betPeeps))
#+end_example

#+caption: png
[[file:19-Social-Network_files/19-Social-Network_19_0.png]]

#+begin_example
  plotNetworkXGraph(*findPairs(clackPeeps))
#+end_example

#+caption: png
[[file:19-Social-Network_files/19-Social-Network_20_0.png]]

#+begin_example
  plotNetworkXGraph(*findPairs(blakePeeps))
#+end_example

#+caption: png
[[file:19-Social-Network_files/19-Social-Network_21_0.png]]

#+begin_example
  plotNetworkXGraph(*findPairs(bruffPeeps))
#+end_example

#+caption: png
[[file:19-Social-Network_files/19-Social-Network_22_0.png]]

#+begin_example
  g = makeNetworkXGraph(*findPairs(betPeeps))
  pd.Series(nx.eigenvector_centrality(g)).plot(kind='bar')
#+end_example

#+begin_example
  <matplotlib.axes._subplots.AxesSubplot at 0x7fdaaa06e748>
#+end_example

#+caption: png
[[file:19-Social-Network_files/19-Social-Network_23_1.png]]

The Holoview library has a different way it wants networks to be arranged, for it to understand it. It wants it in the form =[source, target, value]= (i.e. three colums). So we have to do a little bit of reconfiguring. But then we can plot a heatmap and a chord diagram.

#+begin_example
  nodes, edges = findPairs(betPeeps)
  df = pd.DataFrame([(pair[0], pair[1], int(weight)) 
                     for pair, weight in edges.items()], 
                     columns=['source', 'target', 'value'])
#+end_example

#+begin_example
  hv.HeatMap(df)
#+end_example

<<1e0d55af-2ba4-4a51-a6c6-6c7b9bcb41b3>>

<<8ef520ab-0545-4f32-a3c0-ace8bfda09bc>>

#+begin_example
  hv.Chord(df)
#+end_example

<<f08be671-6d47-46e2-b3ac-822b5d173658>>

<<a03ffeb7-404e-48e7-bd0d-abeb4353f52e>>
