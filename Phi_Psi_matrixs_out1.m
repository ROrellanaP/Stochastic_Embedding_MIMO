
u1_aux=u1.';
u2_aux=u2.';

for r=1:M
    for t=1:N
        Phi_1(t,:,r)=build_regressors(u1_aux(r,:),t,n0_1);
        Phi_2(t,:,r)=build_regressors(u2_aux(r,:),t,n0_1);
        Psi_1(t,:,r)=build_regressors(u1_aux(r,:),t,ndelta_1);
        Psi_2(t,:,r)=build_regressors(u2_aux(r,:),t,ndelta_2);
    end
end
Phi=[Phi_1 Phi_2];

PS1=Psi_1(:,1,:)-Psi_1(:,2,:); % Esto solo para el ejemplo particular FIR_delta =eta0-eta0*z^(-1)
 PS2=Psi_2(:,1,:)-Psi_2(:,2,:); % Esto solo para el ejemplo particular FIR_delta =eta0-eta0*z^(-1)

 Psi=[PS1 PS2]; % Solo para el ejemplo particular, en caso cntrario Phi=[Phi_1 Phi_2]
  Y=y1;