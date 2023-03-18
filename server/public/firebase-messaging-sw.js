importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

firebase.initializeApp({
  apiKey: "AIzaSyDNXoc7BSs4IyPaTfo2MhUtpo_0yKtKvjw",
  authDomain: "gdsc-hackathon-a10b5.firebaseapp.com",
  projectId: "gdsc-hackathon-a10b5",
  storageBucket: "gdsc-hackathon-a10b5.appspot.com",
  messagingSenderId: "950419598196",
  appId: "1:950419598196:web:fb70c111fbf47554149a21",
  measurementId: "G-RB96LQV5SQ"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('Received background message:', payload);
});
