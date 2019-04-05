# Empirical Bayes

Empirical Bayes uses the data to set the hyperparameters of the prior. Performing Bayesian inference with this prior then gets you a sort of shrinkage and can be viewed as an approximation to a hierarchical Bayesian model.


EB ignores the uncertainty in the hyper-parameters, whereas HBM attempts to include it in the analysis. HMB is a good idea where there is little data and hence significant uncertainty in the hyper-parameters, which must be accounted for. On the other hand for large datasets EB becomes more attractive as it is generally less computationally expensive and the the volume of data often means the results are much less sensitive to the hyper-parameter settings.





## Shortreads:


- [ ] [Hierarchical Bayes and Empirical Bayes](https://www2.isye.gatech.edu/~brani/isyebayes/bank/handout8.pdf)

### Slides:

- [ ] [Empirical and Hierarchical Bayes](https://www.cs.ubc.ca/~schmidtm/Courses/540-W16/L19.pdf)

- [ ] [Empirical and Fully Bayesian Hierarchical
Models : Two Applications in the Stellar
Evolution](https://hea-www.harvard.edu/AstroStat/Stat310_1415/ssj_20150210.pdf)

### Example:

- [ ] [Understanding empirical Bayes estimation](http://varianceexplained.org/r/empirical_bayes_baseball/)

- [ ] [REBayes](https://cran.r-project.org/web/packages/REBayes/REBayes.pdf): [AN R PACKAGE FOR EMPIRICAL BAYES MIXTURE METHODS](https://cran.r-project.org/web/packages/REBayes/vignettes/rebayes.pdf)


- [ ] [‘openEBGM’](https://cran.r-project.org/web/packages/openEBGM/openEBGM.pdf): [Empirical Bayes Metrics with openEBGM](https://cran.r-project.org/web/packages/openEBGM/vignettes/x4_posteriorCalculationVignette.html)

- [ ] [Introducing the ebbr package for empirical Bayes estimation](http://varianceexplained.org/r/ebbr-package/): [one more](https://www.r-bloggers.com/introducing-the-ebbr-package-for-empirical-bayes-estimation-using-baseball-statistics/) 

- [ ] [ebayes()](http://web.mit.edu/~r/current/arch/i386_linux26/lib/R/library/limma/html/ebayes.html)

## Longreads:

- [ ] [ Hierarchical and Empirical Bayes Analyses](https://www.stat.unipd.it/sites/default/files/bayesian-mod4.pdf)

- [ ] [ Empirical Bayes vs. fully Bayes variable selection](http://www-stat.wharton.upenn.edu/~edgeorge/Research_papers/CG%20JSPI%202008.pdf)

- [ ] [An Introduction to Empirical Bayes Data Analysis](http://www.biostat.jhsph.edu/~fdominic/teaching/bio656/labs/labs09/Casella.EmpBayes.pdf)

- [ ] [Empirical Bayes](http://statweb.stanford.edu/~ckirby/brad/other/CASI_Chap6_Nov2014.pdf)


- [ ] [Empirical Bayes modeling, computation, and accuracy](http://statweb.stanford.edu/~ckirby/brad/papers/2013EBModeling.pdf)

- [ ] [Calibration and EB variable slection](http://www-stat.wharton.upenn.edu/~edgeorge/Research_papers/EBVS.pdf)



## Offtop:

- [ ] [EMPIRICAL BAYESBALL REMIXED:
EMPIRICAL BAYES METHODS FOR LONGITUDINAL DATA](http://www.econ.uiuc.edu/~roger/research/ebayes/Bball.pdf)

- [ ] [Bayes, Oracle Bayes, and
Empirical Bayes](http://statweb.stanford.edu/~ckirby/brad/papers/2017BayesOBayesEBayes.pdf)