# MultiGaussian-HMM
Hidden Markov Model with multivariate gaussian distribution as observation model.

% application

This framework is designed to anlysis the dynamic funcitonal connectivity of neuroimaging data such as fmri data.The functional connectivity between each brain regions are described by covariance of gaussian distribution of each state.

% test 

If you want to test this code, run "HMM_run.m" directly because data file is already included.

simulated data is generated by simTB toolbox(Erhardt et al., 2012).real fmri data comes from HCP project dataset（Glasser et al.2013).

%input

format of input data is T*K. (T is the time points, K is the dimension of input data(eg.number of brain regions)
All timeseries from different subjects are concatenated.

Reference: 
《李航统计学习方法》

Erhardt, E.B., Allen, E.A., Wei, Y., Eichele, T., Calhoun, V.D., 2012. Simtb, a simulation toolbox for fmri 
data under a model of spatiotemporal separability. Neuroimage 59, 4160–4167.

Glasser, M.F., Sotiropoulos, S.N., Wilson, J.A., Coalson, T.S., Fischl, B., Andersson, J.L., Xu, J., Jbabdi,
S., Webster, M., Polimeni, J.R., et al., 2013. The minimal preprocessing pipelines
for the human connectome project. Neuroimage 80, 105–124.

