# mobile

You can run the mobile app on your phone or on an emulator. The app is built using Flutter, so you will need to install the Flutter SDK. You can find instructions for doing so [here](https://flutter.dev/docs/get-started/install).

CLI commands for running the app on an emulator:

```bash
cd mobile
flutter pub get
flutter run
```
# server
You can use the server to run the app on your phone. The server is built using Node.js, so you will need to install the Node.js SDK. You can find instructions for doing so [here](https://nodejs.org/en/download/).



CLI commands for running the Ndode.js server:

```bash
cd server
npm install
npm start
```
If you familiar with Docker, you can use the Dockerfile:
    
    ```bash
        docker run -p 8080:8080 -d nguyenle23/node
    ```
