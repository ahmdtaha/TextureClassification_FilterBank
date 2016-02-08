
Statistical Approach to Texture Classification from Single Images
-----------------------------------------------------------------

This repos provides an implementation for the "[Statistical Approach to Texture Classification from Single Images](http://www.robots.ox.ac.uk/~vgg/publications/2005/Varma05/)" paper by Varma et. al.

The filters (RFS, LM, S) used in this repos are from [this link](http://www.robots.ox.ac.uk/~vgg/research/texclass/filters.html)

It is not documented yet. Since I know that it will take me some time to write the documentation, I decided to provide this initial version of the code. There is a lot of work that can help make this code better. So any contributions will be welcomed.

Setup
-----

 1. Download the code.
 2. Download the [Classification toolbox for MATLAB, by Milano Chemometrics and QSAR Research Group](http://michem.disat.unimib.it/chm/download/softwares/help_classification/web.htm). 
 3. Update the knn_calc_dist.m file with the file inside this repos, to support chi-square distance
 4. Update the "rootpath" variable in demo_curet.m to point to Columbia-Utrecht dataset folder on your machine.
 5. Run demo_curet.m to test the performance over Columbia-Utrecht dataset.

I will try to update the documentation incrementally to provide more instructions to make using this code easier.

Contributor list
----------------
1. [Ahmed Taha](http://ahmed-taha.com/)
2. [Aleksandrs Ecins](http://www.umiacs.umd.edu/~aecins/)