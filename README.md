# Package Conflict Detection
By using vagrant and machine learning methods, this project aims to get all of dependencies of specific package from several version of Ubuntu

## Version
This project use Ubuntu from version :
  * Ubuntu 12 (Precise64)
  * Ubuntu 14 (Trusty64)
  * Ubuntu 16 (Xenial64)
  
The reason why these versions are chosen because they're developed for Long Term Support (LTS) and had several update in the progress and with help of ShellScript we pull out the commonality and difference relation from packages.

## Machine Learning
Methods used for creating model:
  * Classification (in classification tree)
  * Regression (in regression tree)
  * Random Forest
  
