# Playfulingo


Our app Playfulingo is an app to get people interested in American Sign Language. We have components to learn and games to practice your learning! 

## Backend

For our database we're using Firebase Cloud database Firestore, also using Firebase Authentication for Singing up and Logging in. That instance of the authentication of a particular user assigns an ID to each user. That id is used to fetch relevant information in Firestore and also perform read and write operations.

## Prerequisites

- Ensure you have the Flutter SDK installed on your machine. If not, [Get Flutter here](https://flutter.dev/docs/get-started/install).
- Set up an emulator (Android/iOS) or have a physical device connected to your machine.
- Install cocoapods if needed
- Make sure Git is installed on your machine. If not, [Download Git here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

## Setting Up and Running the Project

### 1. Clone the Repository
To clone this repository to your local machine, open your terminal and enter:
```
git clone https://github.com/your_username/playfulingo.git
```
### 2. Create a New Flutter Project (Optional)
If you're starting fresh and need to create a new Flutter project, use:
```
flutter create playfulingo
```
### 3. Navigate to the Project Directory
Switch to your project directory:
```
cd playfulingo
```
### 4. Check installation(This command won't run if flutter is not configured properly, might need to export path then)
```
flutter doctor
```

### 5. Fetch Dependencies
Inside the project directory, fetch all necessary dependencies:
```
flutter pub get
```

### 6. Run the Flutter App
Finally, build and launch the app on your emulator or connected device:
```
flutter run
```

## Project Structure:

all code files are in lib folder and then the folder names correspond to the functionality. 
 

## Responsibilites:

### Sulav: 
General styling of the app, implementing startup animated widget, games and learn homepage with google fonts and glassmorph libraries. Building and training a gesture recognition model with tensor flow lite and teachable. Also responsible for organizing the code files. 

Relevant files: 
- lib/Games/games.dart 
- lib/Learn_ASL/learn.dart
- lib/Games/gesture.dart(This file is commented out because there was a version issue running tensorlite on my end - Kasaf)
-lib/HomePage/glass_morph.dart
-lib/HomePage/learning_morph.dart

### Jin: 
Making the flashcards module in learning items. Also implemented most of the games in the games module. 

Relevant files:
- lib/Games/fill_in_the_blank.dart
- lib/Games/yes_no.dart
- lib/Games/multiple_choice.dart
- lib/Games/memory_matching.dart
- lib/Learn_ASL/flashcard.dart
- lib/StartUp/animated_splash.dart
- lib/StartUp/login_prompt.dart

### Kasaf: 
Setting up the backend and adding backend functionality, implementing the progress page and videos modules with youtube package in flutter. Also using hugging face model for image recognition to detect ASL signs. alphabet matching learning module along with it's corresponding practice game that unlocks after a user completes the lesson. 

Relevant files: 
- lib/Games/alphabet_prac.dart
- lib/Games/alphabet_match.dart
- lib/Learn_ASL/abcvideo.dart
- lib/Learn_ASL/abtutorial.dart
- lib/Learn_ASL/simpleaslvideo.dart
- lib/HomePage/progress.dart
- lib/Firebase/signup_page.dart













