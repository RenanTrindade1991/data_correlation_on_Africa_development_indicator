# data_correlation_on_Africa_development_indicator
A code with loops that calculates the correlations between data, and plot variables that have a correlation grather than 0.8

Files:
1 - África_dev_indicator_cor.R is the crude code, but the loop that takes data from World Bank takes to muchu time to run, so I stored the data in a CSV file to not have to whait for the loop again

2 - Africa.R is the file that use the stored data

Explanation:

This code take all the World Bank data, filter for the Africa Development Indicators, make the correlations between all data, filter for those correlations grater than 0.8, and make a scatter plot of those indicators. Some of then are obvious but other are preary interesting.

Next steps: 

drop the obvious correlations
