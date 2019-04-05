# MCMC

In Bayesian statistics, the recent development of Markov chain Monte Carlo methods has been a key step in making it possible to compute large **hierarchical models** that require integrations over hundreds or even thousands of unknown parameters.[4]

In rare event sampling, they are also used for generating samples that gradually populate the rare failure region.

Beautiful visualization [here](http://chi-feng.github.io/mcmc-demo/)


#### Syllabus:

1. Introduction: Bayesian statistics, Markov chains. 
2. Gibbs Sampler: data augmentation, burn-in, convergence. 
3. Metropolis-Hastings algorithm: independent sampler, random walk Metropolis, scaling, multi-modality. 
4. MCMC Issues: Monte Carlo Error, reparameterisation, hybrid algorithms, convergence diagnostics. 
5. Reversible jump MCMC: known number of parameters. 
6. Hamiltonian Monte Carlo. 
7. Approximate Bayesian Computation: simulation based inference. 


#### MCMC code:

- [JAGS](http://mcmc-jags.sourceforge.net)  can use stand-alone binary or interface with R
- [STAN](http://mc-stan.org/documentation/) interfaces with R, Python, Julia, MATLAB
- pymc3
- [Implementation in R, Python, Java and C](https://darrenjw.wordpress.com/2010/04/28/mcmc-programming-in-r-python-java-and-c/)



## Shortreads:



- [ ] [Markov Chain Monte Carlo Without all the Bullshit](https://jeremykun.com/2015/04/06/markov-chain-monte-carlo-without-all-the-bullshit/)

- [ ] [Bayesian Inference: Gibbs Sampling](http://www.mit.edu/~ilkery/papers/GibbsSampling.pdf)

- [ ] [ Markov Chain Monte Carlo (MCMC)](http://www.cs.cmu.edu/~epxing/Class/10708-16/note/10708_scribe_lecture16.pdf)




### Slides:

- [x] [MCMC for hierarchical models](http://www.math.chalmers.se/~bodavid/GMRF2015/Lectures/F6slides.pdf)

- [ ] [Bayesian Computation: Posterior Sampling & MCMC](http://astrostatistics.psu.edu/su14/lectures/CosPop14-2-2-BayesComp-2.pdf)


### Examples:

- [ ] [Some Examples of
(Markov Chain) Monte Carlo Methods](http://www.bytemining.com/wp-content/uploads/2010/04/notes_dis1.pdf):
bootstrap

- [ ] [MCMC sampling for dummies](https://twiecki.github.io/blog/2015/11/10/mcmc-sampling/): in python

- [ ] [Markov Chain Monte Carlo in Python](https://towardsdatascience.com/markov-chain-monte-carlo-in-python-44f7e609be98)

## Longreads:

- [ ] [A simple introduction to Markov Chain Monte–Carlo sampling](https://link.springer.com/article/10.3758/s13423-016-1015-8)


- [ ] [An Introduction to MCMC for Machine Learning](https://link.springer.com/content/pdf/10.1023%2FA%3A1020281327116.pdf)

- [ ] [NUTS](https://arxiv.org/pdf/1111.4246.pdf): HMC MCMC for Hierarchical Bayesian models


- [ ] [Advanced Hierarchical Modeling with the MCMC Procedure](https://support.sas.com/resources/papers/proceedings17/SAS0478-2017.pdf) 
with SAS/STAT software

- [ ] [AN INTRODUCTION TO MCMC SAMPLING METHODS](https://www.statistics.com/papers/LESSON1_Notes_MCMC.pdf)

- [ ] [Bootstrap Markov chain Monte Carlo](https://arxiv.org/pdf/1008.1596.pdf)


- [ ] [Markov Chain Monte Carlo
Methods for Bayesian Data
Analysis in Astronomy](https://arxiv.org/pdf/1706.01629.pdf)

