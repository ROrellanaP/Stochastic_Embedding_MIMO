function Phi_t=build_regressors(U,t,n0)

id4283717050=[];

for id1990922180=0:n0
    id3126988067=t-id1990922180;
    if id3126988067<1
        id794629398=zeros(1,1);
    else
        id794629398=U(:,id3126988067);
    end
    id3586023283=id794629398;%kron(u_tk.',I_N);
    id4283717050=[id4283717050,id3586023283];
end
Phi_t=id4283717050;
end