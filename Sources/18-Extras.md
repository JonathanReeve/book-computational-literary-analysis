* Extras
  :PROPERTIES:
  :CUSTOM_ID: extras
  :END:
Here are some things that probably won't be useful to your final projects, but which are pretty cool in their own right, and deserve some mention. You can also think of this as "next steps": what more is possible with computational literary analysis, beyond what we covered in this class?

- TEI XML
- APIs

** TEI XML
   :PROPERTIES:
   :CUSTOM_ID: tei-xml
   :END:
TEI XML stands for:

Text Encoding Initiative eXtensible Markup Language

and in short, it's a way to encode /semantic/ information, i.e. information about /meaning/, into the text, so that it's easy to extract. We've done super light markup, for instance, by putting markers (=%%%%%=) into our texts, to delimit narratives. But what if we wanted to extract those parts, and sub-chapters, too, in a more predictable and structured way? Well, we can write it in XML, the eXtensible Markup Language.

*** On XML
    :PROPERTIES:
    :CUSTOM_ID: on-xml
    :END:
Imagine we have a list of two movies. And imagine each of those movies has certain properies. How could we make that data easily machine-readable?

In XML, we could write it like this:

#+begin_example

  <movies>
      <movie n="1">
        <title>Titanic</title>
        <director>James Cameron</director>
        <year>1997</year>
      </movie>
      <movie n="2">
        <title>Rain Man</title>
        <director>Barry Levinson</director>
        <year>1988</year>
      </movie>
  </movies>
#+end_example

This is a hierarchical tree representing two movies and their associated properties. Now, we can load this into a string, and parse it using a library like =xml=, like this:

#+begin_src python
  xml = """<movies>
      <movie n="1">
        <title>Titanic</title>
        <director>James Cameron</director>
        <year>1997</year>
      </movie>
      <movie n="2">
        <title>Rain Man</title>
        <director>Barry Levinson</director>
        <year>1988</year>
      </movie>
  </movies>
  """
#+end_src

#+begin_src python
  from xml.etree import ElementTree
#+end_src

#+begin_src python
  tree = ElementTree.fromstring(xml)
#+end_src

#+begin_src python
  tree.tag
#+end_src

#+begin_example
  'movies'
#+end_example

We can get "children" of a given tag like this:

#+begin_src python
  tree.getchildren()
#+end_src

#+begin_example
  [<Element 'movie' at 0x7f53f09d1bd8>, <Element 'movie' at 0x7f53f05cc458>]
#+end_example

Or children of children:

#+begin_src python
  title = tree.getchildren()[0].getchildren()[0]
#+end_src

#+begin_src python
  title.text
#+end_src

#+begin_example
  'Titanic'
#+end_example

** TEI
   :PROPERTIES:
   :CUSTOM_ID: tei
   :END:
TEI XML is a certain brand of XML that can encode information about a text. =<said who="">= tags might encode who says a given line of dialogue, for instance. =<foreign lang="">= might tell us whether a given expression belongs to another language. All of this markup is useful to computational literary analysis.

For an introduction, see [[http://teibyexample.org/][TEI By Example]].

TEI XML files for literary texts may be found at [[https://www.folgerdigitaltexts.org/download/][The Folger Shakespeare Library]], [[http://ota.ox.ac.uk/catalogue/index.html][The Oxford Text Archive]], and, if it's a Joyce novel, at my project [[https://github.com/open-editions][Open Editions]]. The last one is a collaborative project, so feel free to jump in and contribute!

** APIs
   :PROPERTIES:
   :CUSTOM_ID: apis
   :END:
You can use APIs to get machine-readable data from the Internet. This can sometimes be more useful than downloading it yourself, and if the data is machine-readable, it might not be very human-readable, but it'll be easy to analyze using Python.

For this, I'd refer you to some notebooks I made for a recent summer course in APIs I took:

- [[https://github.com/szweibel/DHSI-API-workshop/blob/master/sections/data-formats.ipynb][This notebook explains the data formats JSON and XML, and what it takes to parse them]]
- [[https://github.com/szweibel/DHSI-API-workshop/blob/master/sections/visualization.ipynb][This one uses the Open Library API to find publication data about certain books, and plot when most of their editions were published.]]
- [[https://github.com/szweibel/DHSI-API-workshop/blob/master/sections/visualization2.ipynb][This one looks at the genres of Shakespeare adaptations, using the iTunes API]]
