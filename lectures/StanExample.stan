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

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;
  vector[N] y;
  vector[N] x;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real b0;
  real b1;
  real<lower=0> sigma;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  
  //This is equivalent to our likelihood
  y ~ normal(b0+b1*x, sigma);
  
  //alternative
  //for (i in 1:N){y[1] ~ normal(b0+b1*x[1], sigma)}
    
  //Priors
  b0~normal(0,10);
  b1~normal(0,10);
  sigma~normal(0,10)T[0,];
    
  }
  
  


