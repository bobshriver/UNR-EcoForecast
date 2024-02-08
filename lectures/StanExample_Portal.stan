//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a response vector 'y' and covariate 'x' both of length 'N'.
data {
  int<lower=0> N;
  vector[N] y; //Response NDVI
  vector[N] rain; //Covariate
}

// The parameters accepted by the model. Our model
// accepts three parameters 'mu' and 'b0', 'b1'.
parameters {
  real b0;
  real b1; //NDVI at t-1 effect
  real b2;
  real<lower=0> sigma;
}


model {
  
  //This is equivalent to likelihood
  y[2:N] ~ normal(b0+b1*y[1:(N-1)]+b2*rain[1:(N-1)], sigma);
    
  //Priors
  b0~normal(0,10);
  b1~uniform(0,1);
  b2~normal(0,10);
  sigma~normal(0,10)T[0,];
    
  }
  
  


