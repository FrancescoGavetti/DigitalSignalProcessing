function [y,snr_dB,vect_snr] = funzione2(SOSiir,Giir,x,e)

%numero di sezioni da realizzare in cascata = numero di righe di SOS
N=length(SOSiir(:,1));
%vettore per il salvataggio del snr in uscita da ogni sezione
vect_snr=zeros(N,1);

for k=1:N
    SOS_row=SOSiir(k,:);
    B = SOS_row(1:3);
    A = SOS_row(4:6);
     
    [y,snr_dB] = funzione1(B,A,x,e);
    vect_snr(k) = snr_dB;
    x=zeros(size(x));
    x=y;   
end
end

