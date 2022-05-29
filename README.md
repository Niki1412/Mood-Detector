# Mood Detector 
[Video Link](https://youtu.be/8kFPut8kw-o)

Mood Detector is a mobile application, which can help the user to track their mood daily. Tracking the mood is necessary for people dealing with mood disorders like anxiety, depresssion, etc.

## Features of the Application 
1. Graphical representation of the mood tracked during the day 
2. Mood being tracked through mood detection using the Camera of the phone 
3. Quotes shown to user according to their mood
4. Email Verification of the user 

## Working of the application 
Once the user logs in into the application, they will see a bar graph, which shows the user's mood on daily basis. The user can then detect their mood by using their mobile camera. The application uses a ML model to detect the mood of the user from their face. The user is also shown a quote on the homepage according to their mood. To make them feel better.
If the user does not have a account in the application, then the user is asked to sign in. Once the user gives those details, their email verification is also done.

## Compatible Platforms
Android Phone with Andriod version 10 or above 

## Built With  
1. Front-end - Flutter v 2.10.0 
2. Back-end - Firebase, Cloud Firestore
3. Tools - TensorflowLite, Teachable Machine

## Getting Started 
To install and run the project on your local system, following are the requirements
#### Prerequisites
1.  Flutter v 2.10.0 must be installed on the system 
    To download flutter go to [Click here](https://docs.flutter.dev/get-started/install) and follow the given steps
### Installation 
The following apk can be used to download the application directly on the mobile [Click here](https://drive.google.com/drive/folders/1wPBc7Lt8Vn8MpwAG8KuWxh3E7kP7aemt?usp=sharing)

## Navigating Through The App
### Sign Up 
The user needs to enter  their email and create a password. 

The user receives an email on their resgistered email for verification. After verification, the user would be logged in automatically and would be redirected to the Homepage.

![signup](https://user-images.githubusercontent.com/92136763/170855776-6dcf4310-6f41-4d2f-9da2-537cddd8701f.png)

### Login 
The user needs to provide their email and password for logging in. 

Forgot passowrd option is also available for a better user experience. If the user forgets the password, they need to enter their registered email id and an email would be sent. A link would be provided to change their password and then the user can login with the new password.

![login](https://user-images.githubusercontent.com/92136763/170855795-9e59bb48-84fa-4bae-ac51-a2f3ea79efad.jpg)

### Homepage 
After login, the user sees the homepage of the application. The homepage has the mood tracker as well as a motivational quote. 

![homepage](https://user-images.githubusercontent.com/92136763/170855830-41cdc78a-d513-45c6-b2dc-5cf9dfddcb3b.png)

### Menu Drawer
The user can browse through the menu drawer and navigate to the mood detector or the logout page.

![menu_drawer](https://user-images.githubusercontent.com/92136763/170855856-fb027b85-6563-4b01-9c53-bcbe55bb8089.png)

### Mood Detector
Here, the camera will open up and that will detect the mood of the user and display the score and the mood detected.

![mood_detector](https://user-images.githubusercontent.com/92136763/170855840-830c8f83-a259-4a04-ae55-b4c21ff4bbd0.png)

### Logout
The user can select, if they want to logout or not

![logout](https://user-images.githubusercontent.com/92136763/170855811-74602698-17cb-414d-b0d0-6e2d992f93eb.png)

## Resources
1. [Kaggle Dataset](https://www.kaggle.com/code/koustabh98das/emotion-detection) 
2. [Emotion detector](https://www.youtube.com/watch?v=R_gTJCBfDu0)
3. [Firebase Authentication](https://firebase.google.com/docs/auth)
4. [Cloud Firestore](https://firebase.google.com/docs/firestore)
