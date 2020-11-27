data {
  int<lower=0> N;
  vector[N] y;     // target
}

parameters {
  real<lower=0, upper=1> mu;
  real<lower=0> kappa;
}

model {
  mu ~ uniform(0, 1);
  kappa ~ normal(10, 5);
  y ~ beta_proportion(mu, kappa);
}

generated quantities {
  vector[N] yrep;
  for (n in 1:N) {
    yrep[n] = beta_proportion_rng(mu, kappa);
  }
}
