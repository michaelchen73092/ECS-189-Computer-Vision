# ECS-189-Computer-Vision
Four problem sets

Problem 0
Write functions to do each of the following to an input color image, and then write a script that loads an image, applies each transformation to the original image, and displays the results in a figure using the Matlab subplot function in a 3x2 grid (3 rows and 2 columns). Label each subplot with an appropriate title. Name the script PS0_Q2.m.

Problem 1
content-aware image resizing
For this exercise, you will implement a version of the content-aware image resizing technique described in Shai Avidan and Ariel Shamir’s SIGGRAPH 2007 paper, “Seam Carving for Content-Aware Image Resizing”. The paper is available off the course website. The goal is to implement the method, and then examine and explain its performance on different kinds of input images.

First read through the paper, with emphasis on sections 3, 4.1, and 4.3. Note: choosing the next pixel to add one at a time in a greedy manner will give sub-optimal seams; the dynamic programming solution ensures the best seam (constrained by 8-connectedness) is computed. Use the dynamic programming solution as given in the paper and explained in class.

Problem 2
1. Colorquantizationwithk-means
2. Circle detection with the Hough Transform

Problem 3 (Final)
Video search with bag of visual words
