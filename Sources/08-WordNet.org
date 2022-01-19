* Using WordNet
  :PROPERTIES:
  :CUSTOM_ID: using-wordnet
  :END:
WordNet, as the name implies, is a network of words, where words are connected by relations like =hyponym=, =hypernym=, =meronym=, and so on. You can use WordNet to generate wordlists (of, say, colors), or to categorize words. As usual, we'll start by importing the libraries we'll need.

#+begin_src python
  from nltk.corpus import wordnet as wn
  from nltk import word_tokenize, pos_tag
  import pandas as pd
  import numpy as np
  #from collections import Counter
  from nltk import Counter
  %matplotlib inline
#+end_src

Now let's look up any synset (set of synonyms, words which share a common meaning), using a string.

#+begin_src python
  dogSyns = wn.synsets('dog')
  dogSyns
#+end_src

#+begin_example
  [Synset('dog.n.01'),
   Synset('frump.n.01'),
   Synset('dog.n.03'),
   Synset('cad.n.01'),
   Synset('frank.n.02'),
   Synset('pawl.n.01'),
   Synset('andiron.n.01'),
   Synset('chase.v.01')]
#+end_example

If we grab the first one of these, we can explore its properties:

#+begin_src python
  dogSyn = dogSyns[0]
  dogSyn
#+end_src

#+begin_example
  Synset('dog.n.01')
#+end_example

#+begin_src python
  dogSyn.definition()
#+end_src

#+begin_example
  'a member of the genus Canis (probably descended from the common wolf) that has been domesticated by man since prehistoric times; occurs in many breeds'
#+end_example

Hyponyms are words that are more specific words in the lexical tree. All of the below are types of dogs, for instance:

#+begin_src python
  dogHypo = dogSyn.hyponyms()
  dogHypo
#+end_src

#+begin_example
  [Synset('basenji.n.01'),
   Synset('corgi.n.01'),
   Synset('cur.n.01'),
   Synset('dalmatian.n.02'),
   Synset('great_pyrenees.n.01'),
   Synset('griffon.n.02'),
   Synset('hunting_dog.n.01'),
   Synset('lapdog.n.01'),
   Synset('leonberg.n.01'),
   Synset('mexican_hairless.n.01'),
   Synset('newfoundland.n.01'),
   Synset('pooch.n.01'),
   Synset('poodle.n.01'),
   Synset('pug.n.01'),
   Synset('puppy.n.01'),
   Synset('spitz.n.01'),
   Synset('toy_dog.n.01'),
   Synset('working_dog.n.01')]
#+end_example

#+begin_src python
  dogHypo[-4].definition()
#+end_src

#+begin_example
  'a young dog'
#+end_example

We can also get hypernyms, or higher-level abstractions/categories. A dog is a type of a canine, for instance, and also a type of a domestic animal.

#+begin_src python
  dogSyn.hypernyms()
#+end_src

#+begin_example
  [Synset('canine.n.02'), Synset('domestic_animal.n.01')]
#+end_example

#+begin_src python
  canine = dogSyn.hypernyms()[0]
#+end_src

#+begin_src python
  canine.definition()
#+end_src

#+begin_example
  'any of various fissiped mammals with nonretractile claws and typically long muzzles'
#+end_example

#+begin_src python
  carnivore = canine.hypernyms()[0]
#+end_src

#+begin_src python
  carnivore
#+end_src

#+begin_example
  Synset('carnivore.n.01')
#+end_example

#+begin_src python
  carnivore.hypernyms()[0].hypernyms()[0].hypernyms()[0].hypernyms()
#+end_src

#+begin_example
  [Synset('chordate.n.01')]
#+end_example

Let's try a color:

#+begin_src python
  wn.synsets('yellow')
#+end_src

#+begin_example
  [Synset('yellow.n.01'),
   Synset('yellow.v.01'),
   Synset('yellow.s.01'),
   Synset('chicken.s.01'),
   Synset('yellow.s.03'),
   Synset('scandalmongering.s.01'),
   Synset('yellow.s.05'),
   Synset('jaundiced.s.01')]
#+end_example

#+begin_src python
  yellow = wn.synsets('yellow', pos='n')[0]
#+end_src

#+begin_src python
  color = wn.synsets('yellow', pos='n')[0].hypernyms()[0]
  color
#+end_src

#+begin_example
  Synset('chromatic_color.n.01')
#+end_example

#+begin_src python
  color.hyponyms()
#+end_src

#+begin_example
  [Synset('blond.n.02'),
   Synset('blue.n.01'),
   Synset('brown.n.01'),
   Synset('complementary_color.n.01'),
   Synset('green.n.01'),
   Synset('olive.n.05'),
   Synset('orange.n.02'),
   Synset('pastel.n.01'),
   Synset('pink.n.01'),
   Synset('purple.n.01'),
   Synset('red.n.01'),
   Synset('salmon.n.04'),
   Synset('yellow.n.01')]
#+end_example

Each synset has a list of lemma names, or synonyms, associated with that meaning:

#+begin_src python
  color.lemma_names()
#+end_src

#+begin_example
  ['chromatic_color', 'chromatic_colour', 'spectral_color', 'spectral_colour']
#+end_example

#+begin_src python
  yellow.lemma_names()
#+end_src

#+begin_example
  ['yellow', 'yellowness']
#+end_example

#+begin_src python
  yellow.lemmas()
#+end_src

#+begin_example
  [Lemma('yellow.n.01.yellow'), Lemma('yellow.n.01.yellowness')]
#+end_example

We can also walk up or down the tree of associations. The =.tree()= method needs a function so it knows which way to walk. You can either write a function that just gets the hypernym of a word, like this:

#+begin_src python
  def getHypernyms(word):
      return word.hypernyms()
  yellow.tree(getHypernyms)
#+end_src

#+begin_example
  [Synset('yellow.n.01'),
   [Synset('chromatic_color.n.01'),
    [Synset('color.n.01'),
     [Synset('visual_property.n.01'),
      [Synset('property.n.02'),
       [Synset('attribute.n.02'),
        [Synset('abstraction.n.06'), [Synset('entity.n.01')]]]]]]]]
#+end_example

Or you can write the same thing with a bit of shorthand called a lambda function, which is just a function with no name.

#+begin_src python
  yellow.tree(lambda x: x.hypernyms())
#+end_src

#+begin_example
  [Synset('yellow.n.01'),
   [Synset('chromatic_color.n.01'),
    [Synset('color.n.01'),
     [Synset('visual_property.n.01'),
      [Synset('property.n.02'),
       [Synset('attribute.n.02'),
        [Synset('abstraction.n.06'), [Synset('entity.n.01')]]]]]]]]
#+end_example

#+begin_src python
  yellow.tree(lambda x: x.hyponyms())
#+end_src

#+begin_example
  [Synset('yellow.n.01'),
   [Synset('amber.n.01')],
   [Synset('brownish_yellow.n.01')],
   [Synset('canary_yellow.n.01')],
   [Synset('gamboge.n.02')],
   [Synset('greenish_yellow.n.01')],
   [Synset('old_gold.n.01')],
   [Synset('orange_yellow.n.01'), [Synset('ocher.n.01')]],
   [Synset('pale_yellow.n.01')]]
#+end_example

#+begin_src python
#+end_src

Let's try to do this with many words at a time, using the first paragraph of "The Garden Party."

#+begin_src python
  gardenPara = """And after all the weather was ideal. They could not have had a more perfect day for a garden-party if they had ordered it. Windless, warm, the sky without a cloud. Only the blue was veiled with a haze of light gold, as it is sometimes in early summer. The gardener had been up since dawn, mowing the lawns and sweeping them, until the grass and the dark flat rosettes where the daisy plants had been seemed to shine. As for the roses, you could not help feeling they understood that roses are the only flowers that impress people at garden-parties; the only flowers that everybody is certain of knowing. Hundreds, yes, literally hundreds, had come out in a single night; the green bushes bowed down as though they had been visited by archangels."""
#+end_src

#+begin_src python
  print(gardenPara)
#+end_src

#+begin_example
  And after all the weather was ideal. They could not have had a more perfect day for a garden-party if they had ordered it. Windless, warm, the sky without a cloud. Only the blue was veiled with a haze of light gold, as it is sometimes in early summer. The gardener had been up since dawn, mowing the lawns and sweeping them, until the grass and the dark flat rosettes where the daisy plants had been seemed to shine. As for the roses, you could not help feeling they understood that roses are the only flowers that impress people at garden-parties; the only flowers that everybody is certain of knowing. Hundreds, yes, literally hundreds, had come out in a single night; the green bushes bowed down as though they had been visited by archangels.
#+end_example

#+begin_src python
  gardenTokens = word_tokenize(gardenPara)
#+end_src

#+begin_src python
  len(gardenTokens)
#+end_src

#+begin_example
  152
#+end_example

POS tag it, and extract all the nouns:

#+begin_src python
  gardenPOS = pos_tag(gardenTokens)
#+end_src

#+begin_src python
  gardenPOS[:10]
#+end_src

#+begin_example
  [('And', 'CC'),
   ('after', 'IN'),
   ('all', 'PDT'),
   ('the', 'DT'),
   ('weather', 'NN'),
   ('was', 'VBD'),
   ('ideal', 'JJ'),
   ('.', '.'),
   ('They', 'PRP'),
   ('could', 'MD')]
#+end_example

#+begin_src python
  gardenNouns = [pair[0] for pair in gardenPOS 
                 if pair[1] in ['NNS', 'NN', 'NNP']]
#+end_src

#+begin_src python
  gardenNouns
#+end_src

#+begin_example
  ['weather',
   'day',
   'Windless',
   'warm',
   'sky',
   'cloud',
   'blue',
   'haze',
   'gold',
   'summer',
   'gardener',
   'dawn',
   'lawns',
   'grass',
   'rosettes',
   'daisy',
   'plants',
   'roses',
   'roses',
   'flowers',
   'people',
   'garden-parties',
   'flowers',
   'everybody',
   'Hundreds',
   'hundreds',
   'night',
   'bushes',
   'archangels']
#+end_example

#+begin_src python
  synsets = []
  hypers = []
  for word in gardenNouns: 
      ss = wn.synsets(word, pos='n')
      if len(ss) > 0: 
          synsets.append(ss[0])
          hypers.append(ss[0].hypernyms())
          if len(ss[0].hypernyms()) > 0: 
              hypers.append(ss[0].hypernyms()[0].hypernyms())
#+end_src

#+begin_src python
  hypers
#+end_src

#+begin_example
  [[Synset('atmospheric_phenomenon.n.01')],
   [Synset('physical_phenomenon.n.01')],
   [Synset('time_unit.n.01')],
   [Synset('measure.n.02')],
   [Synset('atmosphere.n.05')],
   [Synset('gas.n.02')],
   [Synset('physical_phenomenon.n.01')],
   [Synset('natural_phenomenon.n.01')],
   [Synset('chromatic_color.n.01')],
   [Synset('color.n.01')],
   [Synset('aerosol.n.01')],
   [Synset('cloud.n.01')],
   [Synset('precious_metal.n.01')],
   [Synset('valuable.n.01')],
   [Synset('season.n.02')],
   [Synset('time_period.n.01')],
   [Synset('horticulturist.n.01')],
   [Synset('expert.n.01')],
   [Synset('hour.n.02')],
   [Synset('clock_time.n.01')],
   [Synset('field.n.01')],
   [Synset('tract.n.01')],
   [Synset('gramineous_plant.n.01')],
   [Synset('herb.n.01')],
   [Synset('adornment.n.01')],
   [Synset('decoration.n.01')],
   [Synset('flower.n.01')],
   [Synset('angiosperm.n.01')],
   [Synset('building_complex.n.01')],
   [Synset('structure.n.01')],
   [Synset('shrub.n.01')],
   [Synset('woody_plant.n.01')],
   [Synset('shrub.n.01')],
   [Synset('woody_plant.n.01')],
   [Synset('angiosperm.n.01')],
   [Synset('spermatophyte.n.01')],
   [Synset('group.n.01')],
   [Synset('abstraction.n.06')],
   [Synset('angiosperm.n.01')],
   [Synset('spermatophyte.n.01')],
   [Synset('large_integer.n.01')],
   [Synset('integer.n.01')],
   [Synset('large_integer.n.01')],
   [Synset('integer.n.01')],
   [Synset('time_period.n.01')],
   [Synset('fundamental_quantity.n.01')],
   [Synset('woody_plant.n.01')],
   [Synset('vascular_plant.n.01')],
   [Synset('angel.n.01')],
   [Synset('spiritual_being.n.01')]]
#+end_example

Since this is a list of lists, but each sublist contains only one item, we can flatten it like this:

#+begin_src python
  flatHypers = [item[0] for item in hypers]
#+end_src

Which would then allow us to do a quantitative analysis of sorts, using =Counter=.

#+begin_src python
  Counter(flatHypers).most_common(5)
#+end_src

#+begin_example
  [(Synset('angiosperm.n.01'), 3),
   (Synset('woody_plant.n.01'), 3),
   (Synset('physical_phenomenon.n.01'), 2),
   (Synset('time_period.n.01'), 2),
   (Synset('shrub.n.01'), 2)]
#+end_example
