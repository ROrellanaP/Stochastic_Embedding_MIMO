function [Estep_param]=E_step(IN,Idelta,Phi,Psi,Y,theta_m,mu_m,sigma_m,alpha_m,sigmaw_m,K,M)

for id3221531541=1:K
    for id584697202=1:M
        id2695702221(:,id3221531541,id584697202)=Psi(:,:,id584697202)*mu_m(:,id3221531541)+Phi(:,:,id584697202)*theta_m;
        id5104735(:,:,id3221531541,id584697202)=sigmaw_m*IN+Psi(:,:,id584697202)*sigma_m(:,:,id3221531541)*(Psi(:,:,id584697202)).';

        id1599296290=inv(id5104735(:,:,id3221531541,id584697202));
        id2776306423=sigma_m(:,:,id3221531541)*(Psi(:,:,id584697202).')*(id1599296290);

        id3962883680(:,id3221531541,id584697202)=mu_m(:,id3221531541)+id2776306423*(Y(:,id584697202)-id2695702221(:,id3221531541,id584697202));
        id3695644544(:,:,id3221531541,id584697202)=(Idelta-id2776306423*Psi(:,:,id584697202))*sigma_m(:,:,id3221531541);

        id500890598(id3221531541,id584697202)=alpha_m(id3221531541)/(sqrt(cond(id5104735(:,:,id3221531541,id584697202))));
        id2678946477(id3221531541,id584697202)=((Y(:,id584697202)-id2695702221(:,id3221531541,id584697202)).')*(id1599296290)*(Y(:,id584697202)-id2695702221(:,id3221531541,id584697202));
    end
end
%-----------------------------------------------------------
% Compute zita_hat
%----------------------------------------------------------
for id3221531541=1:K
    for id584697202=1:M
        for id2501002248=1:K
            id2216840222(id2501002248)=id500890598(id2501002248,id584697202)*exp(0.5*(id2678946477(id3221531541,id584697202)-id2678946477(id2501002248,id584697202)));
        end
     id1146694312(id3221531541,id584697202)=id500890598(id3221531541,id584697202)/sum(id2216840222);   
    end
end
Estep_param.mu_tilde=id3962883680;
Estep_param.sigma_tilde=id3695644544;
Estep_param.zita_hat=id1146694312;

end