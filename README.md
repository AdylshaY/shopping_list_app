# Shopping List App

A new Flutter project for managing a shopping list.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Screenshots](#images)
- [Installation](#installation)
- [Usage](#usage)
- [Environment Variables](#environment-variables)

## Introduction

The Shopping List App is a Flutter-based application designed to help users manage their shopping list efficiently. This app supports multiple platforms including Android, iOS, macOS, Windows, Linux, and Web.

## Features

- Create and manage a shopping list
- Add, edit, and delete items in the shopping list

## Screenshots

<div style="display:flex; gap:24px;">
  <span>
    <img src="screenshots/MainScreen.png" alt="MainScreen" width="200"/>
    <img src="screenshots/MainScreenWithItem.png" alt="MainScreenWithItem" width="200"/>
    <img src="screenshots/NewItemScreen.png" alt="NewItemScreen" width="200"/>
  </span>
</div>

## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter
- Android Studio or Xcode for mobile development
- Visual Studio Code or any other IDE for Flutter development

### Steps

1. Clone the repository:

   ```sh
   git clone https://github.com/yourusername/shopping_list_app.git
   cd shopping_list_app
   ```

2. Install dependencies:

   ```sh
   flutter pub get
   ```

3. Run the app:
   ```sh
   flutter run
   ```

## Usage

1. Open the app on your device.
2. Add items to your shopping list by tapping the "Add Item" button.
3. Edit or delete items by long-pressing on the item.

## Environment Variables

This project uses environment variables stored in a .env file. Create a .env file in the root directory of the project with the following content:

```sh
FIREBASE_DB_URL=your_firebase_database_url
```

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch:
   ```sh
   git checkout -b feature-branch
   ```
3. Make your changes and commit them:
   ```sh
   git commit -m "Add new feature"
   ```
4. Push to the branch:
   ```sh
   git push origin feature-branch
   ```
5. Create a pull request.
