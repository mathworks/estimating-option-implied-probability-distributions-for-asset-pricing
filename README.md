# Estimating Option-Implied Probability Distributions for Asset Pricing

[![View Estimating Option-Implied Probability Distributions for Asset Pricing on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://uk.mathworks.com/matlabcentral/fileexchange/53473-estimating-option-implied-probability-distributions-for-asset-pricing)

Forecasting the performance of an asset and quantifying the uncertainty associated with such a forecast is a difficult task: one that is frequently made more difficult by a shortage of observed market data.

Recently, there has been interest from central banks in using observed option price data for creating forecasts, particularly during periods of financial uncertainty. Call and put options on an asset are influenced by how the market believes that asset will perform in the future. 

This code, along with the corresponding [technical article](https://uk.mathworks.com/company/newsletters/articles/estimating-option-implied-probability-distributions-for-asset-pricing.html), describes a workflow in which MATLAB® is used to create a forecast for the performance of an asset, starting with relatively scarce option price data observed from the market.

The main steps in this workflow are:

* Computing implied volatility from market data
* Creating additional data points using SABR interpolation
* Estimating implied probability densities
* Simulating future asset prices
* Presenting the forecast uncertainty in a fan chart

![](FanChart.png)

## Installation and Getting Started
The examples are provided in a MATLAB project.
1. Double-click on the project archive (`Options.mlproj`) to extract it using MATLAB.
2. With MATLAB open, navigate to the newly-created project folder and double-click on the project file (`Commodities.prj`) to open the project.
3. The main example file is the live script `DistributionsForAssetPricing.mlx` within the project.
4. The examples rely on simulated option price data created by the function `generateSampleOptionData.mlx`.

### [MathWorks&reg;](https://www.mathworks.com) Product Requirements

This example was updated using MATLAB release R2022b.
- [MATLAB&reg;](https://www.mathworks.com/products/matlab.html)
- [Statistics and Machine Learning Toolbox&trade;](https://www.mathworks.com/products/statistics.html)
- [Optimization Toolbox&trade;](https://mathworks.com/products/optimization.html)
- [Financial Toolbox&trade;](https://mathworks.com/products/finance.html)
- [Financial Instruments Toolbox&trade;](https://mathworks.com/products/financial-instruments.html)
- [Curve Fitting Toolbox&trade;](https://mathworks.com/products/curvefitting.html)

## License
The license for this entry is available in the [license.txt](license.txt) file in this GitHub repository.

Copyright 2015-2023 The MathWorks, Inc.

## Community Support
[MATLAB Central](https://www.mathworks.com/matlabcentral)