# DigitalSignalProcessing

1. Realizzare una funzione Matlab per il calcolo dell’uscita del circuito in figura
(forma diretta I di un filtro IIR del secondo ordine), e del rapporto
segnale/rumore in uscita.

![immagine](https://user-images.githubusercontent.com/56198732/172603974-b2ac3e4a-ca5a-4fd0-89e3-8e04b7124da1.png)

La funzione deve prendere in ingresso i coefficienti del filtro ed i segnali 𝑥[𝑛]
ed 𝑒[𝑛] (rumore di quantizzazione).

2. Realizzare una funzione che esegua lo stesso calcolo della funzione al punto 1
ma nel caso di una cascata di N sezioni del secondo ordine.

3. Realizzare le stesse funzioni ai punti 1 e 2 nel caso di sezioni del secondo ordine
implementate tramite forma diretta II (si porga attenzione ai punti in cui si
inserisce il rumore 𝑒[𝑛]).

4. Valutare il funzionamento delle funzioni implementate ai passi precedenti
usando come segnale d’ingresso un segnale audio a 44.1kHz ed un filtro IIR
passa-basso progettato secondo le seguenti specifiche: banda di transizione
inferiore a 200Hz, attenuazione in banda oscura superiore a 70dB, frequenza
di cutoff pari a 8kHz.
Il rumore di quantizzazione è supposto essere, in tutti i casi, uniforme a media
nulla e potenza pari ad 1/1000 di quella del segnale di ingresso.

5. Riportare l’andamento del rapporto segnale/rumore in funzione della
posizione della sezione del secondo ordine nella cascata che implementa il
filtro.
