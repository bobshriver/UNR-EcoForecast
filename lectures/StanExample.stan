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
  vector[N] y; //Response
  vector[N] x; //Covariate
}

// The parameters accepted by the model. Our model
// accepts three parameters 'sigma' and 'b0', 'b1'.
parameters {
  real b0;
  real b1;
  real<lower=0> sigma;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'b0+b1*x'
// and standard deviation 'sigma'.
model {
  
  //This is equivalent to likelihood
  y ~ normal(b0+b1*x, sigma);
  
  //alternative
  //for (i in 1:N){y[i] ~ normal(b0+b1*x[i], sigma)}
    
  //Priors
  b0~normal(0,10);
  b1~normal(0,10);
  sigma~normal(0,10)T[0,];
    
  }
  
  


