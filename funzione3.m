function [y,snr_dB] = funzione3(B,A,x,e)
    %ASSEGNAMENTO VARIABILI
    R=length(A);
    L=length(x);
    P_err=sum(e.^2)/L;
    e_a=0+sqrt(P_err/2)*rand(L,1);
    e_b=0+sqrt(P_err/2)*rand(L,1);
    
    %INIZIALIZZAZIONE VARIABILI
    %matrici per il calcolo dei vettori retroazione, rispettivamente per il
    %lato dei poli e per quello degli zeri
    v = zeros(L,R);
    t = zeros(L,R);
    %matrici per il caloro dei contributi di rumore provenienti dalla 
    %retroazione lato poli e zeri
    e_r = zeros(L,R);
    e_t = zeros(L,R);
    %segnale e rumore in uscita dalla parte a soli poli
    s = zeros(L,1);
    e_s = zeros(L,1);
    %segnale e rumore complesivi in uscita dalla df1t
    y = zeros(L,1);
    e_y = zeros(L,1);
    
    %ciclo esterno per scrivere i campioni dell'uscita: il ciclo inizia
    %dall'indice R in quanto si ha un ritardo massimo di R-1 campioni
    for k=R:L
        for m=R-1:-1:1
            v(k,m)=-A(m+1)*s(k)+v(k-1,m+1);
            %contributo di rumore dalla retroazione lato poli
            e_r(k,m)=-A(m+1)*e_s(k)+e_r(k-1,m+1);
        end
        %rumore totale in uscita dal lato poli
        e_s(k)=e_r(k-1,1)+e_a(k);
        %segnale totale in uscita dal lato poli
        s(k)=x(k)+v(k-1,1)+e_s(k);      

        for m=R-1:-1:1    
            t(k,m)=B(m+1)*s(k)+t(k-1,m+1);
            %contributo di rumore dalla retroazione lato zeri
            e_t(k,m)=B(m+1)*e_s(k)+e_t(k-1,m+1);
        end
        %rumore totale in uscita dalla df1t
        e_y(k)=e_t(k-1,1)+e_b(k)+B(1)*e_s(k);
        %segnale totale in uscita dalla df1t
        y(k)=B(1)*s(k)+t(k-1,1)+e_y(k);
    end
    snr_dB=snr(y,e_y);
end
