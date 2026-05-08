function D = generateSampleOptionData()
%GENERATESAMPLEOPTIONDATA Generate sample option price data for the example
% "Estimating Option-Implied Probability Distributions for Asset Pricing".
% 
% Creates simulated call and put option price data using the Black-Scholes 
% model.
%
% See also blsprice

% Copyright 2015-2026 The MathWorks, Inc. 

% Define the risk-free interest rate (specified as a decimal number between
% 0 and 1).
rf = 0.005;

% Define the underlying asset price (specified in currency units).
S = 100;

% Define the option expiry times (specified in years).
T0 = (0.25:0.50:4).';

% Replicate the option expiry times.
N = 6;
T = repelem(T0, N);

% Create a vector of option strike prices (specified in currency units).
K0 = linspace(98, 102, N).';

% Define the option strike prices (specified in currency units).
K = repmat(K0, numel(T)/N, 1);

% Define the asset volatility (specified as a decimal number between 0 and
% 1).
sigma = NaN(size(K));
for k = 1:numel(T)/N
    sigma0 = (1e-4)*( (K0-mean(K0)).^2 + K0 + k );
    sigma( ((k-1)*N+1):k*N ) = sigma0;    
end % for
    
% Compute the call and put prices from the Black-Scholes pricing model.
[C, P] = blsprice(S, K, rf, T, sigma);

% Add some (reproducible) noise to both the call and put options to 
% simulate real-life market data.
noiseVol = 0.001;
rng("default")
C = C + noiseVol*abs(randn(size(C)));
P = P + noiseVol*abs(randn(size(P)));

% Assemble the data in a table.
D = table(K, C, P, T);

% Include the risk-free interest rate and the underlying asset price in the
% table data.
U = ones(height(D), 1);
D.rf = rf * U;
D.S = S * U;

end % generateSampleOptionData