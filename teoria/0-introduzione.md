```table-of-contents
style: nestedList # TOC style (nestedList|inlineFirstLevel)
maxLevel: 0 # Include headings up to the speficied level
includeLinks: true # Make headings clickable
debugInConsole: false # Print debug info in Obsidian console
```
---

# Intelligenza Artificiale
L'AI e' un ambizioso progetto di ingegneria. L'obiettivo di questo progetto era di sviluppare macchinari intelligenti che potessero interagire con il mondo reale (robot). 
Oggi l'AI si occupa:
- di realizzare macchine allo scopo d'interagire con mondi virtuali, come il web; 
- di fare scelte razionali, come scegliere se comprare o vendere nel mercato; 
- di risolvere problemi complessi, dei mondi complessi.

Come molti ambiti dell'informatica, il concetto di AI viene proposto per la prima volta nel '55 dal Prof. John McCarthy (1927-2011): l'obbiettivo di realizzare macchine intelligenti, che interagiscano con il mondo senza necessariamente parlare d'implementare algoritmi, nasce da lui.

L'intelligenza artificiale è la scienza e l'ingegneria per la realizzazione di macchine intelligenti, in particolare, programmi per computer che siano intelligenti. È legato al compito simile di utilizzare i computer per comprendere l’intelligenza umana, ma l’intelligenza artificiale non deve limitarsi a metodi biologicamente osservabili.

L’intelligenza è la parte computazionale della capacità di raggiungere obiettivi nel mondo. Nelle persone si riscontrano diversi tipi e gradi di intelligenza [...].

Non ci dobbiamo aspettare solo problemi dove lo sforzo cognitivo è grande: a volte ci sono anche problemi a basso livello, rapportati in modo ridotto verso l'AI ma piuttosto già risolti da algoritmi.
Esempio: camminare senza colpire ostacoli lo sappiamo fare, ma non è affatto semplice per i robot.

AI può essere forte:
- Una macchina che esegua programmi, può presentarsi con risposte indistinguibili da quelle provenienti da intelligenza umana (artificial general intelligence).  
AI può essere debole:  
- Simulare l'intera coscienza umana non è possibile, ma soltanto ambiti precisi possono essere seguiti.

# Quattro punti di vista
![[four_viewpoints.png]]

## Acting Humanly
Il test di Turing fornisce una definizione empirica del termine *intelligent behavior*. 

![[turing_test.png]]

- A è una intelligenza campione con un solo obbiettivo, giocare a scacchi. Vogliamo determinare se A è capace di giocare in modo intelligente, facendo scelte mirate per poter vincere.
- Un giocatore di scacchi B viene messo dallo stesso lato dell'intelligenza artificiale, per opporsi contro un altro giocatore. Questo giocatore, dopo un po di tempo, lascerà rispondere l'intelligenza al suo posto.
- Il giocatore C, che da dal lato opposto della parete, non sa se sta giocando contro A o B, verrà messo in questione e dovrà cercare di capire se sta giocando o meno contro un'intelligenza.

Se il giocatore C non si accorge di stare giocando contro un'intelligenza, piuttosto che contro una persona reale, allora questa è una buona simulazione di cervello umano. Il tempo e il numero di mosse che passano, sono indicatore di quanto è buona la simulazione.

Se il giocatore C si accorge alla svelta del cambio di avversario, perché magari A fa mosse infallibili, allora magari l'intelligenza non è molto abile a imitare l'uomo, che sia nel bene o nel male.

> Approfondimento: [Eliza](https://it.wikipedia.org/wiki/ELIZA_(chat_bot)).

## Thinking Humanly
Un possibile approccio per imitare il comportamento umano si basa sulla possibilità di simulare l'organo che dà origine ai pensieri, il cervello.
Utilizzando questo approccio, l'obiettivo da costruire cervelli elettronici per simulare il cervello umano.

![[neural_networks.png]]

Ogni unità simula un neurone: passando da dei livelli d'input e da livelli nascosti, questi generano output proprio come i muscoli nel nostro corpo. Avere un cervello vuole significare avere abbastanza neuroni, che possiamo idealmente creare:
- mettendo in campo una quantità spropositata di neuroni, che anche con computer moderni avremmo difficoltà a realizzare;
- abbandonando la struttura ad archi che vanno solo avanti, modificandola permettendo input/output ricorsivi (è così che funzionano i neuroni).

Una AI debole necessita del numero giusto di neuroni, per raggiungere l'obbiettivo, che solitamente è basso. Tipicamente, le reti neurali non si programmano, ma si addestrano, componendo copie input/output indefinitamente finché il risultato non è corretto.

> Perche' si addestrano? Un cervello umano ha $10^{12}$ input: con l'hardware di oggi e' insostenibile implementare una soluzione del genere.

L'addestramento funziona fornendo input con i relativi output alle reti neurali, in modo tale che possono trovare i pesi ideali tra i vari livelli nascosti.

> Rete neuronale: cervello umano.
> Rete neurale: simulazione software.
 
## Thinking Rationally
Gli esseri umani non sono sempre razionali: Sono influenzati da abitudini, speranze, obiettivi irraggiungibili, problemi irrisolvibili, …
La razionalità è descritta da linguaggi logici o formalismi equivalenti
- Supponiamo che $A \to B$ sia considerato vero, allora
- $B$ deve essere considerato vero non appena $A$ è noto per essere vero.

I formalismi logici vengono utilizzati per le deduzioni.

Un programma per computer scritto nell'ambito di una base di conoscenza, che è un insieme (possibilmente dinamico) di fatti e regole di inferenza:
- Fatti: `mother_of(ann,bob), sister_of(claire,ann)`
- Regole d'inferenza: $\text{mother of(X,Y)} \wedge \text{sister of(Z,X)} \to \text{aunt of(Z,Y)}$
La base di conoscenze di un sistema esperto può essere utilizzata per dedurre nuovi fatti da fatti noti.

> Approfondimento: [MYCIN](https://en-m-wikipedia-org.translate.goog/wiki/Mycin?_x_tr_sl=en&_x_tr_tl=it&_x_tr_hl=it&_x_tr_pto=sc).

## Acting Rationally
Le macchine che agiscono razionalmente sono conosciute come agenti intelligenti.
Sono spesso utilizzati per progettare e sviluppare applicazioni AI.
L'azione di un agente è caratterizzata dal suo comportamento e il meccanismo interno utilizzato per ottenere il comportamento non è rilevante
- Spesso si basano su linguaggi logici.
- Talvolta si basano su reti neurali.
- Agiscono razionalmente nel loro ambiente.
- Non sono particolarmente bravi a imitare i comportamenti umani.

> Approfondimento: [SHRDLU](https://it.wikipedia.org/wiki/SHRDLU).

Agire razionalmente è anche agire in modo economico; pensare in modo razionale vuole dire passare per la teoria dei giochi: giocare nel mercato, necessita di occhio critico per fare scelte mirate ed evitare perdite.