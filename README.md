# Mood Detector 

Mood Detector is a mobile application, which can help the user to track their mood daily. Tracking the mood is necessessary for people dealing with mood disorders like anxiety, depresssion, etc.

## Features of the Application 
1. Graphical representation of the mood tracked during the day 
2. Mood being tracked through mood detection using the Camera of the phone 
3. Quotes shown to user according to their mood
4. Email Verification of the user 

## Working of the application 
Once the user logs in into the application, they see a bar graph, which shows the user's mood on daily basis. The user can then detect their mood by using their mobile camera. The application uses a ML model to detect the emotion of the user from their face. The user is also shown a quote on the homepage according to their mood. To make them feel better.
If the user does not have a account in the application, then the user is asked to sign in. Once teh user gives those details, their email verification is also done.

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


## Navigating Through The App
Sign Up 
The user needs to enter  their email and create a password. 

The user receives an email on their resgistered email for verification. After verification, the user would be logged in automatically and would be redirected to the Home Page.

Login 
The user needs to provide their email and password for logging in. 

Forgot passowrd option is also available for a better user experience. If the user forgets the password, they need to enter their registered email id and an email would be sent to that id. A link would be provided to change their password and then the user can login with the new password.

Mood Detector 
After login, the user sees the homepage of the application. The homepage has the mood tracker as well as a motivational quote. There is a side menu drawer, where the user can click and detect their today's mood. 

Logout
The user has the option to log out in the side menu drawer. 

The user can select, if they want to logout or not

## Resources
1. [Kaggle Dataset](https://www.kaggle.com/code/koustabh98das/emotion-detection) 
2. [Emotion detector](https://www.youtube.com/watch?v=R_gTJCBfDu0)
3. [Firebase Authentication](https://firebase.google.com/docs/auth)
4. [Cloud Firestore](https://firebase.google.com/docs/firestore)
