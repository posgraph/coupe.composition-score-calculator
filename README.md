# Composition Score Calculator #

## Introduction ##
This repository contains source code for calculating image composition score.

## Files ##
* [getCompScore_demo.m](https://github.com/posgraph/coupe.composition-score-calculator/blob/master/Composition%20Score%20Calculator/getCompScore_demo.m) : Main function
   * Extract prominent line and salient object information of an input image then using these information, calculate total composition score  
   * Total composition score is weighted sum of four composition guideline score (Rule of Third, Visual Balance, Diagonal Dominance, Object Size)  
![Composition Score](https://latex.codecogs.com/gif.latex?E%20%3D%20W_%7BRT%7DE_%7BRT%7D%20&plus;%20W_%7BVB%7DE_%7BVB%7D%20&plus;%20W_%7BDA%7DE_%7BDA%7D%20&plus;%20W_%7BSZ%7DE_%7BSZ%7D)

* [getLine.m](https://github.com/posgraph/coupe.composition-score-calculator/blob/master/Composition%20Score%20Calculator/getLine.m) : Extract prominent line from an input image

* [getLineValue.m](https://github.com/posgraph/coupe.composition-score-calculator/blob/master/Composition%20Score%20Calculator/getLinValue.m) : Measure the composition score that is related to line information

* [CompositionDemo.m](https://github.com/posgraph/coupe.composition-score-calculator/blob/master/Composition%20Score%20Calculator/CompositionDemo.m) : Demo function (GUI Environment)  
   * If you run this function, you can get the result in a GUI environment  
   ![Compsition Demo GUI](https://github.com/spacejake/test/docs/images/CompsitionDemoGui.jpg)
   
## Requirements ##
* Matlab

## Coupe Project Links ##
* [Coupe Website](http://rice.postech.ac.kr/)
* [POSTECH CG Lab.](http://cg.postech.ac.kr/)

