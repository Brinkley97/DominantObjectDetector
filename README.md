# DominantObjectDetector
+ Book : ML for iOS Developers 1st ed
+ Author : Abhishek Mishra
+ CH 5 : Object Detection Using Pre-trained Models
+ [Resnet50 Image Classification Model](https://developer.apple.com/machine-learning/models/)

See DominantObjectDetector/ViewController.swift

---
## TO DO : 
- [x] Read CH & take notes
- [x] Set up user interface
  - [x] Create img view
  - [x] Create 2 buttons
    - [x] Select an Image
    - [x] Capture an Image
  - [x] Create 3 outlets for the 2 labels
    - [x] imageView : display cropped img
    - [x] resultLabel : prediction of img
    - [x] percentLabel : percentage of being the correct prediction (confidence)
- [x] Write func(s) to both upload & take img 
  - [x] Conditions to test 
    - [x] Device has camera?
    - [x] User grant app access to camera?
  - [x] Pass : display picture selected/taken by user in image view object of user interface
  - [x] Fail : state why
- [x] Write func(s) to select photo from library
- [x] Convert img from UIImage instance --> CIImage instance
- [x] Get results
- [x] Upload video here (see below)
- [ ] Update user interface

---
https://user-images.githubusercontent.com/29153046/152018459-ce31c4b5-1980-48df-857a-e7f285ed91e8.mp4
