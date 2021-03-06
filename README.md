# Breast Cancer Prediction (Kaggle.com)

# Introduction
Please see the official website https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29 for more information. The data (courtesy: University of Wisconsin Hospitals) has been downloaded from the UCI Machine Learning Repository.

# Getting Started
Download the data from the data/breast-cancer-wisconsin.csv and run the BreastCancer.R script in a R interpreter to see how the classification model works.

# About the Data
Features are computed from a digitized image of a fine needle aspirate (FNA) of a breast mass. They describe characteristics of the cell nuclei present in the image.
Separating plane described above was obtained using Multisurface Method-Tree (MSM-T) [K. P. Bennett, "Decision Tree Construction Via Linear Programming." Proceedings of the 4th Midwest Artificial Intelligence and Cognitive Science Society, pp. 97-101, 1992], a classification method which uses linear programming to construct a decision tree. Relevant features were selected using an exhaustive search in the space of 1-4 features and 1-3 separating planes. 

# Attribute Information
1) ID number 
2) Diagnosis (M = malignant, B = benign) 

3) Ten real-valued features are computed for each cell nucleus: 

  i) Radius (mean of distances from center to points on the perimeter) 
  ii) Texture (standard deviation of gray-scale values) 
  iii) Perimeter 
  iv) Area 
  v) Smoothness (local variation in radius lengths) 
  vi) Compactness (perimeter^2 / area - 1.0) 
  vii) Concavity (severity of concave portions of the contour) 
  viii) Concave Points (number of concave portions of the contour) 
  ix) Symmetry 
  x) Fractal Dimension ("coastline approximation" - 1)

