function [y,snr_dB] = funzione1(B,A,x,e)
    
    %ASSEGNAMENTO VARIABILI
    R=length(A);
    L=length(x);
    %INIZIALIZZAZIONE VARIABILI
    y = zeros(L,1);
    e_y = zeros(L,1);
    %matrici per il calcolo dei vettori retroazione del segnale e del
    %segnale e del rumore in uscita
    v = zeros(L,R);
    e_v = zeros(L,R);
    
    %ciclo esterno per scrivere i campioni dell'uscita: il ciclo inizia
    %dall'indice R in quanto si ha un ritardo massimo di R-1 campioni
    for k=R+1:L
        for m = R-1:-1:1
            v(k,m)=B(m+1)*x(k)-A(m+1)*y(k)+v(k-1,m+1);
            e_v(k,m)=-A(m+1)*e_y(k)+e_v(k-1,m+1);
        end  
        e_y(k)=e(k)+e_v(k-1,1);
        y(k)=B(1)*x(k)+v(k-1,1)+e_y(k);
    end  
%     P_sig = sum(y.^2)/length(y);
%     P_noise = sum(e_y.^2)/length(e_y);
%     P_ey_dB=10*log10(P_noise);
%     snr=P_sig/P_noise;
%     snr_dB=10*log10(snr);
    snr_dB=snr(y,e_y);
end


