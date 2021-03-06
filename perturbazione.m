
format long
%dati iniziali esatti

rho =  1.0e+03 *[  0.504129720000000   0.465341710184454   0.406940199998636;
  -0.514027600000000  -0.249446841939143   0.015785584115931;
   1.284749170000000   1.552664856957740   1.816111540852702];


%posizioni dell'osservatore
R = 1.0e+03 *[ 6.378137000000000   6.378094862166766   6.377969375321201; 0   0.023184476937970   0.046241088156316; 0 0  0];

r = 1.0e+03 *[ 6.882266720000000   6.843436546783947   6.784908546954059;
  -0.514027600000000  -0.226255332460717   0.062168296452558;
   1.284749170000000   1.552664856957740   1.816111540852702];

rho_hat =[ 0.342308255303443   0.283748384912019   0.218642566679389;
  -0.349028997802026  -0.152103576731988   0.008481345975778;
   0.872355327286093   0.946758340869071   0.975768156278062];


%moduli dei rho:

rho_moduli = 1.0e+03 *[1.472736085646280   1.639980119459502   1.861212142626194];


r_vero=r(:,2); %punto intermendio
deltat =50; 
maxit=100;
%ho le dieci perturbazioni
sigma(1)=2.4240684055477e-06;
sigma(2)=4.8481368110954e-06;
sigma(3)=7.272205216643e-06;
sigma(4)=9.6962736221907e-06; 
sigma(5)=1.2120342027738e-05;
sigma(6)=1.4544410433286e-05;
sigma(7)=1.6968478838834e-05;
sigma(8)=1.9392547244381e-05;
sigma(9)=2.1816615649929e-05;
sigma(10)=2.4240684055477e-05;

[rho_est, r_est, err_jn(1), psi]=Jn(rho_moduli, R, rho_hat, r(:,2), maxit, deltat);
[rho_est2,r_est2,err_dc(1)]=dc(rho_hat, R, r(:,2), deltat, maxit);

%porto in coordinate sferiche i tre versori 

rho_hat2=cartesiantopolar(rho_hat);
for i=1:10
  %matrice di perturbazione 
  
  pert=sigma(i)*randn(2,3);
  pert(3,:)=0; % non perturbo i moduli

  rho_hat3=rho_hat2+pert;
  %torno in coordinate cartesiane
  rho_hat4=polartocartesian(rho_hat3);
  [rho_est, r_est, err_jn(i+1), psi]=Jn(rho_moduli, R, rho_hat4, r(:,2), maxit, deltat);
  [rho_est2,r_est2,err_dc(i+1)]=dc(rho_hat4, R, r(:,2), deltat, maxit);
   
end

