# Tic Tac Toe Game App

A simple, fun, and interactive Tic Tac Toe game built with Flutter. This app supports two players and includes features such as entering player names, displaying turn-by-turn gameplay, and announcing the winner or a draw.

---

## **Features**

- **Player Name Input**: Users can input names for Player 1 and Player 2 on the home screen.
- **Game Board**: A clean and interactive 3x3 grid for playing the game.
- **Winner Announcement**: Displays the winner or announces a draw with a dialog box.
- **Play Again**: Option to reset the game board and start a new round.
- **Animated Splash Screen**: Engaging splash screen with logo and title animation.

---

## **Project Structure**

```
lib/
|-- main.dart                # Entry point of the application
|-- Pages/
|   |-- splash_screen.dart   # Splash screen implementation
|   |-- home_screen.dart     # Screen for player name input
|   |-- game_screen.dart     # Screen for the Tic Tac Toe gameplay
assets/
|-- logo.png                 # Logo for the splash screen
pubspec.yaml                 # Project dependencies and assets configuration
```

---

## **Getting Started**

### **Prerequisites**

- Flutter SDK installed (version 3.0.0 or above).
- Code editor (e.g., VS Code or Android Studio).
- A connected device or emulator to run the app.

### **Setup Instructions**

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/tic-tac-toe.git
   ```
2. Navigate to the project directory:
   ```bash
   cd tic-tac-toe
   ```
3. Fetch the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---

## **Screens**

### **1. Splash Screen**
- Displays a modern logo and the app title with smooth animations.

### **2. Home Screen**
- Allows players to enter their names.
- A "Start Game" button to navigate to the gameplay screen.

### **3. Game Screen**
- Interactive 3x3 grid for gameplay.
- Displays the current player's turn.
- Announces the winner or draw using a dialog box.

---

## **Dependencies**

The project uses the following dependencies:

- [awesome_dialog](https://pub.dev/packages/awesome_dialog): For displaying animated dialog boxes.

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  awesome_dialog: ^2.1.1
```

---

## **Customizations**

### **Change the Logo**
- Replace `assets/logo.png` with your custom logo.
- Update the `pubspec.yaml` to include the new logo:
  ```yaml
  flutter:
    assets:
      - assets/your-logo.png
  ```

### **Modify Colors**
- Update the `Color` values in `home_screen.dart` and `game_screen.dart` to fit your theme.

---

## **Future Improvements**

- Add support for AI (single-player mode).
- Include a score tracker to keep track of wins and draws.
- Add sound effects for a more interactive experience.
- Enhance UI with animations for player moves.

---

## **License**

This project is licensed under the MIT License. Feel free to use and modify it.

---

### **Contributions**

Contributions are welcome! Feel free to submit a pull request or open an issue for any suggestions or bugs.

---

### **Contact**

If you have any questions or feedback, please contact:

- **Email**: mdkhaledaminshawon@gmail.com
- **GitHub**: [your-username](https://github.com/Khaled-Amin-Shawon)

---

Enjoy playing Tic Tac Toe with your friends! 🎮

