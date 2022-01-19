#+begin_src python
  from sklearn.decomposition import PCA
  from sklearn.feature_extraction.text import TfidfVectorizer
  import pandas as pd
  from matplotlib import pyplot as plt
  import requests
  import json
  %matplotlib inline
  import matplotlib.pyplot as plt
  plt.rcParams['figure.figsize'] = [10, 10]
#+end_src

* A Comparative Stylometry
  :PROPERTIES:
  :CUSTOM_ID: a-comparative-stylometry
  :END:
We'll make texts of all the narrators in /The Moonstone/ again, so that we can compare their styles.

#+begin_src python
  moonstone = open('../moonstone.md').read()
#+end_src

#+begin_src python
  moonstoneParts = moonstone.split('%%%%%')
#+end_src

#+begin_src python
  bet1 = moonstoneParts[1]
#+end_src

#+begin_src python
  # Write it out to a file to make it easier.
  open('bet1.txt', 'w').write(bet1)
#+end_src

#+begin_example
  430752
#+end_example

#+begin_src python
  clack = moonstoneParts[3]
#+end_src

#+begin_src python
  bruff = moonstoneParts[5]
#+end_src

#+begin_src python
  blake = moonstoneParts[6]
#+end_src

#+begin_src python
  jennings = moonstoneParts[7]
#+end_src

#+begin_src python
  blake2 = moonstoneParts[8]
#+end_src

#+begin_src python
  cuff = moonstoneParts[9]
#+end_src

#+begin_src python
  candy = moonstoneParts[10]
#+end_src

#+begin_src python
  bet2 = moonstoneParts[11]
#+end_src

#+begin_src python
  tfidf = TfidfVectorizer(use_idf=False, max_features=100)
#+end_src

#+begin_src python
  allChars = [bet1, clack, bruff, blake, jennings, 
              blake2, cuff, candy, bet2]
#+end_src

#+begin_src python
  [len(char) for char in allChars]
#+end_src

#+begin_example
  [430752, 169326, 57208, 236679, 80103, 39579, 24886, 4333, 4367]
#+end_example

And we'll need labels for these so that we can put labels on all the points we're going to create in our plot.

#+begin_src python
  allCharsLabels = ['Betteredge-1', 'Clack', 'Bruff', 'Blake', 'Jennings',
                    'Blake-2', 'Cuff', 'Candy', 'Betteredge-2']
#+end_src

#+begin_src python
  allChars2 = allChars[:-3]
#+end_src

Let's cut out a few of the shorter texts, and break each one into two parts of equal sizes, just to check and make sure everything's working.

#+begin_src python
  [len(char) for char in allChars2]
#+end_src

#+begin_example
  [430752, 169326, 57208, 236679, 80103, 39579]
#+end_example

#+begin_src python
  allChars3 = [char[:24000] for char in allChars2]
#+end_src

#+begin_src python
  allChars4 = [char[24000:39000] for char in allChars2]
#+end_src

Create a big list of all the labels, prepending =1-= and =2-= to each, so that we know which part we're seeing:

#+begin_src python
  allCharsLabels1 = ['1-'+label for label in allCharsLabels][:6]
  allCharsLabels2 = ['2-'+label for label in allCharsLabels][:6]
#+end_src

#+begin_src python
  allCharsPieces = allChars3 + allChars4
#+end_src

#+begin_src python
  allCharsPiecesLabels = allCharsLabels1 + allCharsLabels2
#+end_src

Compute word frequencies (i.e. a term frequency matrix) for all words in all narratives:

#+begin_src python
  tfTable = tfidf.fit_transform(allCharsPieces).todense()
#+end_src

Check the "shape" of the matrix. Here, 12 means that we have 12 documents (narratives), and 100 means that we're looking at the top 100 most frequent words (from =max_features= above).

#+begin_src python
  tfTable.shape
#+end_src

#+begin_example
  (12, 100)
#+end_example

Now reduce the number of dimensions in that matrix from 100 to 2, so that we can plot it easier and see the relationships easier:

#+begin_src python
  pca = PCA(n_components=2)
#+end_src

#+begin_src python
  pcaOut = pca.fit_transform(tfTable)
#+end_src

Plot the results. Here I have several lists (X points, Y points, and labels) and I'm going through each using their indices. Iterating through indices (=for i in range(len())=) helps us loop over several lists at a time.

#+begin_src python
  xs, ys = pcaOut[:,0], pcaOut[:,1]
  for i in range(len(xs)): 
      plt.scatter(xs[i], ys[i])
      plt.annotate(allCharsPiecesLabels[i], (xs[i], ys[i]))
#+end_src

#+caption: png
[[file:11-Stylometry_files/11-Stylometry_36_0.png]]

* Comparative Stylometry of Dickens and Collins
  :PROPERTIES:
  :CUSTOM_ID: comparative-stylometry-of-dickens-and-collins
  :END:
Let's compare the styles of several novels by Charles Dickens and Wilkie Collins. To amass a corpus of novels, I'll use =corpus-db.org=, an API which allows you to easily get metadata and full text for Project Gutenberg texts. We'll use the python =requests= library to get things from the Internet, and the =json= library to parse our results.

#+begin_src python
  response = requests.get('http://corpus-db.org/api/author/Collins, Wilkie')
#+end_src

Check to make sure the response came back OK. Since this is an experimental server, it doesn't always work.

#+begin_src python
  response.ok
#+end_src

#+begin_example
  True
#+end_example

Provided the above is True, we can parse our results, turing the JSON string into a Python dictionary.

#+begin_src python
  parsed = json.loads(response.text)
#+end_src

Now let's peek at some of the titles we got:

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

That's too many. And some of the ones at the end aren't in English. So let's get just the first 6 or so novels.

#+begin_src python
  collinsIDs = [item['id'] for item in parsed][:6]
#+end_src

Now let's write another query to get the full texts. This should take a long time, since we're getting the full text of all Collins novels here:

#+begin_src python
  response = requests.get('http://corpus-db.org/api/author/Collins, Wilkie/fulltext')
#+end_src

#+begin_src python
  response.ok
#+end_src

#+begin_example
  True
#+end_example

#+begin_src python
  parsed = json.loads(response.text)
#+end_src

#+begin_src python
  collinsNovels = [item['text'] for item in parsed[:6]]
#+end_src

Now let's do the same for Dickens:

#+begin_src python
  response = requests.get('http://corpus-db.org/api/author/Dickens, Charles')
#+end_src

#+begin_src python
  response.ok
#+end_src

#+begin_example
  True
#+end_example

#+begin_src python
  parsed = json.loads(response.text)
#+end_src

#+begin_src python
  [(item['id'], item['title']) for item in parsed]
#+end_src

#+begin_example
  [('46.0', 'A Christmas Carol in Prose; Being a Ghost Story of Christmas'),
   ('98.0', 'A Tale of Two Cities'),
   ('564.0', 'The Mystery of Edwin Drood'),
   ('580.0', 'The Pickwick Papers'),
   ('588.0', "Master Humphrey's Clock"),
   ('644.0', "The Haunted Man and the Ghost's Bargain"),
   ('650.0', 'Pictures from Italy'),
   ('653.0',
    'The Chimes: A Goblin Story of Some Bells That Rang an Old Year out and a New Year In'),
   ('675.0', 'American Notes'),
   ('676.0', 'The Battle of Life'),
   ('678.0', 'The Cricket on the Hearth: A Fairy Tale of Home'),
   ('699.0', "A Child's History of England"),
   ('700.0', 'The Old Curiosity Shop'),
   ('730.0', 'Oliver Twist'),
   ('766.0', 'David Copperfield'),
   ('786.0', 'Hard Times'),
   ('807.0', 'Hunted Down: The Detective Stories of Charles Dickens'),
   ('809.0', 'Holiday Romance'),
   ('810.0', "George Silverman's Explanation"),
   ('821.0', 'Dombey and Son'),
   ('824.0', 'Speeches: Literary and Social'),
   ('872.0', 'Reprinted Pieces'),
   ('882.0',
    'Sketches by Boz, Illustrative of Every-Day Life and Every-Day People'),
   ('883.0', 'Our Mutual Friend'),
   ('888.0', 'The Lazy Tour of Two Idle Apprentices'),
   ('912.0', 'Mudfog and Other Sketches'),
   ('914.0', 'The Uncommercial Traveller'),
   ('916.0', 'Sketches of Young Couples'),
   ('917.0', "Barnaby Rudge: A Tale of the Riots of 'Eighty"),
   ('918.0', 'Sketches of Young Gentlemen'),
   ('922.0', 'Sunday Under Three Heads'),
   ('924.0', 'To Be Read at Dusk'),
   ('927.0', 'The Lamplighter'),
   ('963.0', 'Little Dorrit'),
   ('967.0', 'Nicholas Nickleby'),
   ('968.0', 'Martin Chuzzlewit'),
   ('1023.0', 'Bleak House'),
   ('1289.0', 'Three Ghost Stories'),
   ('1392.0', 'The Seven Poor Travellers'),
   ('1394.0', 'The Holly-Tree'),
   ('1400.0', 'Great Expectations'),
   ('1406.0', 'The Perils of Certain English Prisoners'),
   ('1407.0', 'A Message from the Sea'),
   ('1413.0', "Tom Tiddler's Ground"),
   ('1414.0', "Somebody's Luggage"),
   ('1415.0', 'Doctor Marigold'),
   ('1416.0', "Mrs. Lirriper's Lodgings"),
   ('1419.0', 'Mugby Junction'),
   ('1421.0', "Mrs. Lirriper's Legacy"),
   ('1422.0', 'Going into Society'),
   ('1423.0', 'No Thoroughfare'),
   ('1435.0', 'Miscellaneous Papers'),
   ('1465.0', 'The Wreck of the Golden Mary'),
   ('1467.0', 'Some Christmas Stories'),
   ('2324.0', 'A House to Let'),
   ('13771.0', 'Aventures de Monsieur Pickwick, Vol. I'),
   ('14789.0', 'Aventures de Monsieur Pickwick, Vol. II'),
   ('15499.0', 'Mugbyn risteys'),
   ('15618.0', 'The Loving Ballad of Lord Bateman'),
   ('16020.0', 'Le grillon du foyer'),
   ('16021.0', 'Cantique de Noël'),
   ('16022.0', 'Les conteurs à la ronde'),
   ('16023.0', 'Oliver Twist'),
   ('17565.0', 'Les grandes espérances'),
   ('17675.0', "Le magasin d'antiquités, Tome I"),
   ('17676.0', "Le magasin d'antiquités, Tome II"),
   ('17868.0', 'David Copperfield - Tome I'),
   ('17869.0', 'David Copperfield - Tome II'),
   ('17879.0', 'Barnabé Rudge, Tome I'),
   ('17880.0', 'Barnabé Rudge, Tome II'),
   ('18059.0', "L'abîme"),
   ('18186.0',
    'David Copperfield I: David Copperfield nuoremman elämäkertomus ja kokemukset'),
   ('18201.0',
    'David Copperfield II: David Copperfield nuoremman elämäkerta ja kokemukset'),
   ('19337.0', 'A Christmas Carol'),
   ('20795.0', 'The Cricket on the Hearth'),
   ('22465.0', 'Der Weihnachtsabend: Eine Geistergeschichte'),
   ('23344.0',
    'The Magic Fishbone: A Holiday Romance from the Pen of Miss Alice Rainbird, Aged 7'),
   ('23452.0',
    'The Trial of William Tinkling: Written by Himself at the Age of 8 Years'),
   ('23765.0',
    'Captain Boldheart & the Latin-Grammar Master: A Holiday Romance from the Pen of Lieut-Col. Robin Redforth, aged 9'),
   ('24022.0', 'A Christmas Carol'),
   ('24026.0', 'Joulun-aatto'),
   ('24501.0', "La Batalo de l' Vivo"),
   ('25852.0', 'The Letters of Charles Dickens: Vol. 1, 1833-1856'),
   ('25853.0', 'The Letters of Charles Dickens: Vol. 2, 1857-1870'),
   ('25854.0', 'The Letters of Charles Dickens: Vol. 3, 1836-1870'),
   ('27924.0', 'Mugby Junction'),
   ('28560.0', 'Een Kerstlied in Proza'),
   ('30127.0', 'Tales from Dickens'),
   ('30368.0', 'A Christmas Carol: The original manuscript'),
   ('31638.0', 'Sanoma merellä'),
   ('32241.0', "Dickens' Stories About Children Every Child Can Read"),
   ('35536.0', 'The Poems and Verses of Charles Dickens'),
   ('37093.0', 'De avonturen van Oliver Twist'),
   ('37121.0', "Charles Dickens' Children Stories"),
   ('37581.0', 'The Cricket on the Hearth: A Fairy Tale of Home'),
   ('40723.0', 'The Battle of Life. A Love Story'),
   ('41739.0',
    "A Christmas Carol; Or, The Miser's Warning!: (Adapted from Charles Dickens' Celebrated Work.)"),
   ('42232.0', "A Child's Dream of a Star"),
   ('43111.0', 'The Personal History of David Copperfield'),
   ('43207.0',
    'Scenes and Characters from the Works of Charles Dickens: Being Eight Hundred and Sixty-six Pictures Printed from the Original Wood Blocks'),
   ('44899.0', 'Kotisirkka'),
   ('46675.0', "Oliver Twist; or, The Parish Boy's Progress. Illustrated"),
   ('47529.0', 'Oliver Twist, Vol. 1 (of 3)'),
   ('47530.0', 'Oliver Twist, Vol. 2 (of 3)'),
   ('47531.0', 'Oliver Twist, Vol. 3 (of 3)'),
   ('47534.0', 'The Posthumous Papers of the Pickwick Club, v. 1(of 2)'),
   ('47535.0', 'The Posthumous Papers of the Pickwick Club, v. 2(of 2)'),
   ('47716.0', 'Schetsen uit Amerika en Tafereelen uit Italië'),
   ('47933.0', 'Het leven en de lotgevallen van David Copperfield'),
   ('48023.0', 'Kaksi kaupunkia'),
   ('49927.0',
    "Pearl-Fishing; Choice Stories from Dickens' Household Words; First Series"),
   ('50164.0', 'Elämän taistelu'),
   ('50334.0',
    "Pearl-Fishing; Choice Stories from Dickens' Household Words; Second Series"),
   ('50771.0', 'Slechte Tijden')]
#+end_example

Again, this is too many, so let's just choose a few good ones:

#+begin_src python
  dickensIDs = [str(float(bookID)) for bookID in [98, 564, 580, 730, 766, 1423]]
#+end_src

#+begin_src python
  dickensIDs
#+end_src

#+begin_example
  ['98.0', '564.0', '580.0', '730.0', '766.0', '1423.0']
#+end_example

Now create a function that, given a book ID, gets the full text of that novel from the API:

#+begin_src python
  def getFullText(bookID): 
      response = requests.get('http://corpus-db.org/api/id/' + bookID + '/fulltext')
      if response.ok: 
          return json.loads(response.text)[0]['text']
#+end_src

#+begin_src python
  dickensNovels = [getFullText(dickensID) for dickensID in dickensIDs]
#+end_src

And peek at the results so that we know we got the full texts:

#+begin_src python
  [book[:200] for book in dickensNovels]
#+end_src

#+begin_example
  ['\n\n\n\n\n\n\n\nA TALE OF TWO CITIES\n\nA STORY OF THE FRENCH REVOLUTION\n\nBy Charles Dickens\n\n\nCONTENTS\n\n\n     Book the First--Recalled to Life\n\n     Chapter I      The Period\n     Chapter II     The Mail\n     ',
   '\n\nTranscribed from the Chapman and Hall, 1914 edition by David Price, email\nccx074@pglaf.org\n\n\n\n\n\n                        THE MYSTERY OF EDWIN DROOD\n\n\n                       [Picture: Rochester castle',
   "\n\n\n\n\n\n\n\nTHE PICKWICK PAPERS\n\n\nBy Charles Dickens\n\n\n\n\nCONTENTS\n\n\n1. The Pickwickians\n\n2. The first Day's Journey, and the first Evening's Adventures; with\ntheir Consequences\n\n3. A new Acquaintance--The",
   "\n\n\n\n\n\n\n\n\nOLIVER TWIST\n\nOR\n\nTHE PARISH BOY'S PROGRESS\n\n\nBY\n\nCHARLES DICKENS\n\n\n\n\nCONTENTS\n\n       I  TREATS OF THE PLACE WHERE OLIVER TWIST WAS BORN AND OF THE\n          CIRCUMSTANCES ATTENDING HIS BIRT",
   '\n\n\n\n\nDAVID COPPERFIELD\n\n\nBy Charles Dickens\n\n\n\n               AFFECTIONATELY INSCRIBED TO\n               THE HON.  Mr. AND Mrs. RICHARD WATSON,\n               OF ROCKINGHAM, NORTHAMPTONSHIRE.\n\n\nCONTEN',
   '\n\n\n\n\nTranscribed from the 1894 Chapman and Hall "Christmas Stories" edition by\nDavid Price, email ccx074@coventry.ac.uk\n\n\n\n\n\nNO THOROUGHFARE\n\n\nTHE OVERTURE.\n\n\nDay of the month and year, November the t']
#+end_example

Manually add some labels:

#+begin_src python
  dickensLabels = ['Tale', 'Drood', 'Pickwick', 'Oliver', 'Copperfield', 'Thoroughfare']
#+end_src

#+begin_src python
  collinsLabels = ['Moonstone',
   'Haunted Hotel',
   'Woman in White',
   'No Name',
   'Man and Wife',
   'Black Robe']
#+end_src

Compute word frequencies for all words of all these novels, and make the resulting matrix dense, rather than sparse (since PCA can't handle sparse matrices).

#+begin_src python
  tfTable = tfidf.fit_transform(collinsNovels + dickensNovels).todense()
#+end_src

Reduce the number of dimensions to 2 again, using the PCA object that we instantiated earlier:

#+begin_src python
  pcaOut = pca.fit_transform(tfTable)
#+end_src

#+begin_src python
  allLabels = collinsLabels + dickensLabels
#+end_src

And plot the results.

#+begin_src python
  xs, ys = pcaOut[:,0], pcaOut[:,1]
  for i in range(len(xs)): 
      plt.scatter(xs[i], ys[i])
      plt.annotate(allLabels[i], (xs[i], ys[i]))
#+end_src

#+caption: png
[[file:11-Stylometry_files/11-Stylometry_74_0.png]]
