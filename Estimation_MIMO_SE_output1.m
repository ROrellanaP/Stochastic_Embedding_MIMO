%*****************************************
% Example code for a particular case with
% additive error-model
%*****************************************
clc;
close all;
clearvars;

%-----------------------
% FIR orders
%-------------------------
ndelta_1=1; ndelta_2=1; %FIR error-model delta 11 and 12
n0_1=1; n0_2=1; %FIR nominal model 11 y 12 

%--------------------------------------------
% Building regressors Phi, Psi and output Y
%--------------------------------------------
load data_FIR_example_MV.mat
[~,M]=size(y1);
N=500; %data length
Phi_Psi_matrixs_out1; % Building Phi, Psi, Y
%---------------------------------------------

M=100; % Number of experiments
realizations=50; % Number of MC realizations

%*********************************************
% Monte Carlo simulations
%**********************************************
for k=1:realizations
  k
Psi_=Psi(1:N,:,k*M-M+1:k*M);
Phi_=Phi(1:N,:,k*M-M+1:k*M);
Y_=Y(1:N,k*M-M+1:k*M);

 %-----------------------------------------------
 % Initial values GMM
 %----------------------------------------------
 K=2; % Number of GMM components
 
 % Initial Weights 
 alpha1_m=1/K;
 alpha2_m=alpha1_m;
 alpha_m=[alpha1_m;alpha2_m];
 
 [~,n_delta,~]=size(Psi);
 Idelta=eye(n_delta);

 % mean values GMM (particular values)
 mu1_m=[-2.85;-2.85];
 mu2_m=[2.85;2.85];
 mu_m=[mu1_m mu2_m];

  % covariance matrix values inicial
 sigma1_m=eye(n_delta)*0.5*0.95;
 sigma2_m=eye(n_delta)*0.5*0.95;
 sigma_m(:,:,1)=sigma1_m;
 sigma_m(:,:,2)=sigma2_m;

 %--------------------------------
 % Initial noise variance
 %--------------------------------
 sigmaw_m=0.19;
 IN=eye(N);

 %---------------------------------
 % Initial theta nominal model (particular example)
 %---------------------------------
theta_m=[1;0.5;0.8;-1.2].*0.95;


 for i=1:500 % EM iterations
    
     %********
     % E-step
     %********
    [Estep_param]=E_step(IN,Idelta,Phi_,Psi_,Y_,theta_m,mu_m,sigma_m,alpha_m,sigmaw_m,K,M);
    %********
     % M-step
     %********
    est_param=M_step(N,M,K,Estep_param,mu_m,n_delta,theta_m,Phi_,Psi_,Y_);
    mu_m1=est_param.mu_m1;
    sigma_m1=est_param.sigma_m1;
    sigmaw_m1=est_param.sigmaw_m1;
    theta_m1=est_param.theta_m1;
    alpha_m1=est_param.alpha_m1;

    %*******************
    % Stopping criterion
    %*******************
    toler=vecnorm([alpha_m;sigma_m(:);mu_m(:);sigmaw_m;theta_m]-[alpha_m1;sigma_m1(:);mu_m1(:);sigmaw_m1;theta_m1])...
        /vecnorm([alpha_m;sigma_m(:);mu_m(:);sigmaw_m;theta_m]);

    if toler <=1e-5
        toler
        mu_est=mu_m1;
        sigma_est=sigma_m1;
        sigmaw_est=sigmaw_m1;
        theta_est=theta_m1;
        alpha_est=alpha_m1;
        break;
    end
        mu_m=mu_m1;
        sigma_m=sigma_m1;
        sigmaw_m=sigmaw_m1;
        theta_m=theta_m1;
        alpha_m=alpha_m1;
 end
        mu_est_(:,:,k)=mu_est;
        sigma_est_(:,:,:,k)=sigma_est;
        sigmaw_est_(k)=sigmaw_est;
        theta_est_(:,k)=theta_est;
        alpha_est_(:,k)=alpha_est;
end
