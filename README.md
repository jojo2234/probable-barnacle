# Progetto Codifica di Testi

Progetto realizzato per l'esame di codifica di testi

```
Testo_Originale: Articolo su Byte Magazine, Dicembre 1983
Lingua: Inglese
Titolo: Keep Power-Line Pollution Out of Your Computer
Codifica: TEI P5
Trasformazione_XSLT: xlsltproc con supporto SOLO per la versione 1.0
```

## Struttura delle directory:

```
Output_Generato.html: File da aprire con il browser, per visionare il progetto.
Testo_Codificato.xml: File xml codificato con lo standard TEI P5
Foglio_XSLT.xsl: Foglio di stile xslt per la trasformazione HTML (referenziato nel file di codifica xml)
doc_originale: Documento PDF dell'articolo originale
css: Cartella con il foglio di stile al suo interno
img: Cartella delle immagini usate
js: Cartella con il javascript del documento
```
Perchè tutto funzioni correttamente è necessario mantenere intatta questa struttura di file e cartelle.

## Facsimile

Il facsimile graficamente (html) è posizionato nell'ultima pagina, il suo funzionamento richiede javascript, richiesto 
anche per migliorare diverse sezioni graficamente. L'implementazione del facsimile è stata fatta inserendo l'immagine
originale è rendendo cliccabili i punti di interesse. Non sono stati usati software di terze parti, per realizzare il facsimile.

## Compatibilità
Il progetto è compatibile con Google Chrome, sia il file xml trasformato con Google Chrome che il file html generato con
xsltproc sono visualizzati allo stesso modo con Google Chrome Versione 73.0.3683.86 (Build ufficiale) (a 64 bit).

Risoluzione schermo supportata: 1366*768

La trasformazione del file xml con Firefox è differente rispetto a quella generata con Chrome o xsltproc, per via del fatto che non tutti
gli interpreti xslt si comportano allo stesso modo, anche se dovrebbero rispettare tutti lo stesso standard.

### NOTE: 
    -Il css e il javascript sono stati riadattati per l'output ottenuto con xsltproc che supporta solo XSLT 1.0!
    -I commenti sono in linuga inglese
