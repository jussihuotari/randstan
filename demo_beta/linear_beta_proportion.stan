data {
  int<lower=0> N;
  vector[N] y;     // target
  vector[N] x;     // predictor
}

parameters {
  real a;
  real b;
  real<lower=0> kappa;
}

transformed parameters {
  vector[N] mu = a + b * x;
  vector[N] theta = inv_logit(mu);
}

model {
  a ~ normal(.3, .5);
  b ~ normal(0, .5);
  kappa ~ normal(10, 5);
  y ~ beta_proportion(theta, kappa);
}

generated quantities {
  vector[N] yrep;
  for (n in 1:N) {
    yrep[n] = beta_proportion_rng(theta[n], kappa);
  }
}
