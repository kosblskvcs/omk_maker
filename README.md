# Old Hungarian Corpus combiner

The data are from the [Old Hungarian Corpus](http://omagyarkorpusz.nytud.hu/) (Ómagyar Korpusz; references below). 
This repository contains scripts which combine all the data from the corpus into 
a single dataframe with a subcorpus variable and a source text variable (id) added. 
**Running the script 3_omk_maker.R creates this dataframe.**

## Variables

- subcorpus: the kind of text (values: codex, bible, missive, minor [linguistic records])
- id: a single source text (abbreviation of a codex, a printed bible translation, a minor linguistic record, or the number of the missive from the collection *Középkori leveleink*)
- kez: scribal hand within the codex
- oldal: page number
- sor: row number within page (only for some codices, and for minor records)
- könyv_fejezet: for texts containing biblical passages, the biblical book and chapter
- vers: for texts containing biblical passages, the verse within book and chapter
- *betuhu*: the actual datapoint: a single word with original orthography
- *norm*: the actual datapoint with a standardised ("normalised") orthography (only a subset of the codices is normalised, see 1_omk_texts_list.R)
- ertelm: interpretation of normalised word if not used in Modern Hungarian, or used with a substantially different meaning
- igekoto: 
- megj: marking strike (STRIKE), error (FAIL), dubious interpretation (NOIDEA), language other than Hungarian (e.g., LANG{latin}), esp. in the codices
- lemma: for the 6 codices which have been morphologically analysed, the lemma
- tags: for the 6 codices which have been morphologically analysed, the morphological tags
- versszak, verssor, rész, lap, dokumentum: units structuring some of the minor records
- keletkezés: year of authoring a missive
- cím: title of a missive

## Modifications to the original files

- Original recto-verso style page numbering (1r, 1v, 2r, etc.) in the Székelyudvarhely Codex (id = SzekK) 
was converted to a continuous one (1, 2, 3, etc.) in order to facilitate assigning scribal hands to the different pages (see 2_omk_hands.R for more detail). 
- Although missives were subsumed under the category of minor texts in the original corpus, they alone constitute a wide range of independent letters. 
Therefore missive was introduced as a new value of variable *subcorpus* and the variable *id* was filled with the respective value in variable *sorszám*. 

## References
- Simon, Eszter; Sass, Bálint (2012). Nyelvtechnológia és kulturális örökség, avagy korpuszépítés ómagyar kódexekből. In: *Általános Nyelvészeti Tanulmányok*. 2012(XXIV): 243-264. 
- Simon, Eszter (2014). Corpus building from Old Hungarian codices. In: É. Kiss, Katalin (ed.): [*The Evolution of Functional Left Peripheries in Hungarian Syntax*](https://global.oup.com/academic/product/the-evolution-of-functional-left-peripheries-in-hungarian-syntax-9780198709855?cc=hu&lang=en&#). Oxford: Oxford University Press.