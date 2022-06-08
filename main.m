
close all; clear all;

%% PUNTO 1

%funzione per il calcolo di un circuito rappresentante un filtro IIR del
%secondo ordine in forma diretta 2 trasposta.
%la funzione prende in ingresso i coefficienti del filtro ed i segnali x[n]
%(segnale utile) ed e[n] (rumore di quantizzazione) e restituisce il
%segnale y[n] in uscita dal circuito ed il rapporto segnale/rumore in
%uscita.

%% PUNTO 2

%funzione per il calcolo di una cascata di N sezioni del secondo ordine di
%un filtro IIR
%la funzione prende in ingresso la SOS del filtro ed i segnali x[n]
%(segnale utile) ed e[n] (rumore di quantizzazione) e restituisce il
%segnale y[n] in uscita dal circuito ed il rapporto segnale/rumore in
%uscita.

%% PUNTO 3

%FUNZIONE 3
%funzione per il calcolo di un circuito rappresentante la struttura di un
%filtro IIR del secondo ordine in forma diretta 1 trasposta.
%la funzione prende in ingresso i coefficienti del filtro ed i segnali x[n]
%(segnale utile) ed e[n] (rumore di quantizzazione) e restituisce il
%segnale y[n] in uscita dal circuito ed il rapporto segnale/rumore in
%uscita.

%FUNZIONE 4
%funzione per il calcolo di una cascata di N sezioni del secondo ordine in
%forma diretta 2 trasposta di un filtro IIR
%la funzione prende in ingresso la SOS del filtro ed i segnali x[n]
%(segnale utile) ed e[n] (rumore di quantizzazione) e restituisce il
%segnale y[n] in uscita dal circuito ed il rapporto segnale/rumore in
%uscita.

%% PUNTO 4

%Utilizzando la toolbox filterDesigner si è realizzato un filtro IIR passa
%basso tramite un filtro analogico di tipo elliptic, impostandole seguenti 
%specifiche: minimum order, fs=44.1kHz, Fpass=8000Hz, Fstop=8200Hz (banda 
%di transizione massima di 200Hz), Apass=0.01dB, Astop=70dB 
%Così facendo si è ottenuto un filtro di ordine 14 con 7 sezioni del 
%secondo ordine

%caricamento filtro
load filterIIRLP

%lettura file audio a 32kHz
[data,fs]=audioread('SampleAudio.wav');
%ricampionamento del file audio per portarlo a 44.1kHz
x=resample(data,441,320);
fs=441*fs/320;
%riscrivo la traccia audio con la nuova frequenza di campionamento
audiowrite('AudioSample.wav',x/max(abs(x)),fs);

%calcolo della potenza del segnale utile in valore assoluto ed in dB
P_input=sum(x.^2)/length(x);
P_input_dB=10*log10(P_input);

%generazione del rumore di quantizzazione uniforme a media nulla e potenza
%pari ad 1/1000 di quella del segnale di ingresso
me = 0; %media del rumore
P_e = P_input/1000; %potenza del rumore
%essendo il rumore a media nulla la potenza è uguale alla varianza per cui
%la deviazione standard risulterà pari alla radice quadrata della potenza
e=me+sqrt(P_e)*rand(length(x),1);

%rapporto segnale rumore in ingresso
snr_input_dB=10*log10(P_input/P_e);

%poli e zeri della funzione di trasferimento del filtro IIR 
[B,A]=sos2tf(SOSiir,Giir);

%SCALING PER DF2T E DF1T
h=impz(B,A);
s=sqrt(1/sum(abs(h.^2)));
%nel caso della DF2T lo scaling viene fatto sugli zeri in quanto il rumore
%di quantizzazione viene modellato solo dai poli nel caso della DF1T lo 
%scaling viene fatto direttamente sul segnale in ingresso in quanto il 
%rumore di quantizzazione viene modellato sia dagli zeri che dai poli

% FUNZIONE 1: DF2T
[y1,snr_out1_dB]=funzione1(s*B,A,x,e);
%potenza del segnale in uscita dalla funzione 1
P_y1 = sum(y1.^2)/length(y1);
P_y1_dB1 = 10*log10(P_y1);

% FUNZIONE 2: DF2TSOS
[y2,snr_out2_dB,vect_snr2] = funzione2(SOSiir,Giir,x,e);
%potenza del segnale in uscita dalla funzione 2
P_y2 = sum(y2.^2)/length(y2);
P_y2_dB = 10*log10(P_y2);

% FUNZIONE 3: DF1T
[y3,snr_out3_dB] = funzione3(B,A,s*x,e);
%potenza del segnale in uscita dalla funzione 3
P_y3 = sum(y3.^2)/length(y3);
P_y3_dB = 10*log10(P_y3);

% FUNZIONE 4: DF1TSOS
[y4,snr_out4_dB,vect_snr4] = funzione4(SOSiir,Giir,x,e);
%potenza del segnale in uscita dalla funzione 4
P_y4 = sum(y4.^2)/length(y4);
P_y4_dB = 10*log10(P_y4);

% %SPETTROGRAMMA DEL SEGNALE IN INGRESSO 
figure('Name','Analisi spettrale del segnale in ingresso');
spectrogram(x,2028,1024,2048,fs);

%SPETTROGRAMMA DEL SEGNALE IN USCITA DALLA FUNZIONE 1
figure('Name','Analisi spettrale del segnale in uscita dal df2t');
spectrogram(y1,2048,1024,2048,fs);

%SPETTROGRAMMA DEL SEGNALE IN USCITA DALLA FUNZIONE 2
figure('Name','Analisi spettrale del segnale in uscita dalla cascata df2tsos');
spectrogram(y2,2048,1024,2048,fs);

% %SPETTROGRAMMA DEL SEGNALE IN USCITA DALLA FUNZIONE 3
figure('Name','Analisi spettrale del segnale in uscita dal df1t');
spectrogram(y3,2048,1024,2048,fs);

% %SPETTROGRAMMA DEL SEGNALE IN USCITA DALLA FUNZIONE 4
figure('Name','Analisi spettrale del segnale in uscita dalla cascata df1tsos');
spectrogram(y4,2048,1024,2048,fs);

%caricamento su file audio dei segnali processati dalle funzioni
audiowrite('AudioSample_proc1.wav',y1/max(abs(y1)),44100);
audiowrite('AudioSample_proc2.wav',y2/max(abs(y2)),44100);
audiowrite('AudioSample_proc3.wav',y2/max(abs(y2)),44100);
audiowrite('AudioSample_proc4.wav',y2/max(abs(y2)),44100);

%% PUNTO 5

%andamento del rapporto segnale rumore in uscita da ogni sezione che
%compone le due cascate
%CASO CASCATA DF2Tsos
tempo=1:1:length(SOSiir(:,1));
figure('Name', 'Andamento rapporto segnale/rumore in funzione della posizione della cascata nel caso di DF2Tsos');
plot(tempo,vect_snr2);
xlabel('Numero della sezione'); ylabel('snr (dB)'); grid on;

%CASO CASCATA DF1Tsos
tempo=1:1:length(SOSiir(:,1));
figure('Name', 'Andamento rapporto segnale/rumore in funzione della posizione della cascata nel caso di DF1Tsos');
plot(tempo,vect_snr4);
xlabel('Numero della sezione'); ylabel('snr (dB)'); grid on;

%% CONSIDERAZIONI FINALI

%COMPARAZIONE DF1T E DF2T
%in uscita dal filtro IIR implementato con una struttura in forma diretta 1
%trasposta si ha un rapporto segnale rumore in uscita maggiore rispetto a
%quello che si ha nell'implementazione con forma diretta 2 trasposta.
%Questo è dovuto al fatto che nel caso di df1t il rumore di quantizzazione
%complessivo in uscita dal filtro deriva da un doppio filtraggio, infatti
%una porzione di rumore viene prima modellata dai poli ed una viene poi
%modellata dagli zeri e infine questi contributi si sommano per formare il
%rumore totale in uscita dal circuito.
%Dunque, anche se le potenze dei segnali in uscita dai due circuiti
%praticamente si equivalgono, la potenza di rumore in uscita dalla df1t
%risulta inferiore a quella che si ha nel caso di df2t dove il rumore di
%quantizzazione viene modellato dalla parte a soli poli.

%COMPARAZIONE DF1Tsos E DF2Tsos
%Le due cascate realizzate con sezioni del secondo ordine con strutture
%df2t e df1t rispettivamente dalle funzioni 2 e 4 risultano pressoché
%equivalenti dal punto di vista della sensibilità al rumore di
%quantizzazione.
%Inoltre confrontando il rapporto segnale/rumore in uscita da queste due
%realizzazioni con quello in uscita dalla df2t e dalla df1t si può
%concludere che si tratta di implementazioni migliori in quanto più
%insensibili al rumore.