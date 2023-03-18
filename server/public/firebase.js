// Initialize the Firebase JavaScript SDK
const firebaseConfig = {
  apiKey: "AIzaSyDNXoc7BSs4IyPaTfo2MhUtpo_0yKtKvjw",
  authDomain: "gdsc-hackathon-a10b5.firebaseapp.com",
  projectId: "gdsc-hackathon-a10b5",
  storageBucket: "gdsc-hackathon-a10b5.appspot.com",
  messagingSenderId: "950419598196",
  appId: "1:950419598196:web:fb70c111fbf47554149a21",
  measurementId: "G-RB96LQV5SQ"
};

firebase.initializeApp(firebaseConfig);

// Request permission to receive notifications
Notification.requestPermission().then((permission) => {
  if (permission === 'granted') {
    console.log('Notification permission granted.');
    
    // Obtain the FCM registration token
    const messaging = firebase.messaging();
    messaging.getToken().then((token) => {
      console.log(`FCM registration token: ${token}`);
      // Send the token to your server to associate it with the user
      const url = '/test';
      const data = { token: token };
      fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
      })
      .then(response => {
        console.log('Response received:', response);
      })
      .catch(error => {
        console.error(`Failed to send token to server: ${error}`);
      });
    }).catch((error) => {
      console.error(`Failed to obtain FCM registration token: ${error}`);
    });

    // Handle token refreshes
    messaging.onTokenRefresh(() => {
      messaging.getToken().then((token) => {
        console.log(`FCM registration token (refreshed): ${token}`);
        // Send the refreshed token to your server to update the user's token
      }).catch((error) => {
        console.error(`Failed to obtain refreshed FCM registration token: ${error}`);
      });
    });
  } else {
    console.log('Notification permission denied.');
  }
});

// function requestFCMPermission() {
//   Notification.requestPermission().then((permission) => {
//     if (permission === 'granted') {
//       console.log('Notification permission granted.');
      
//       // Obtain the FCM registration token
//       const messaging = firebase.messaging();
//       messaging.getToken().then((token) => {
//         console.log(`FCM registration token: ${token}`);
//         // Send the token to your server to associate it with the user
//       }).catch((error) => {
//         console.error(`Failed to obtain FCM registration token: ${error}`);
//       });

//       // Handle token refreshes
//       messaging.onTokenRefresh(() => {
//         messaging.getToken().then((token) => {
//           console.log(`FCM registration token (refreshed): ${token}`);
//           // Send the refreshed token to your server to update the user's token
//         }).catch((error) => {
//           console.error(`Failed to obtain refreshed FCM registration token: ${error}`);
//         });
//       });
//     } else {
//       console.log('Notification permission denied.');
//     }
//   });
// }



