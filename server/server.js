const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");
const connectDb = require("./src/database/mongodb_connection");
const routes = require("./src/routes/index.js");
const path = require('path')
const app = express();
const server = require("http").Server(app);
const io = require("socket.io")(server);
dotenv.config();
const admin = require('firebase-admin');

//Detect mode
const mode = process.env.NODE_ENV || "development";
const config = require("config").get(mode);

const PORT = process.env.PORT || config.port;
connectDb();

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')))

app.use(
  cors({
    origin: [`http://localhost:3333`, `http://localhost:3000`],
  })
);

routes(app);
app.get("/", (req, res) => {
  res.send("<h1>RESTful called successfully!</h1>");
});

//----------------------------------------------------------------//

// const serviceAccount = require('./serviceAccountKey.json');
// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
// });

var fcm = require('fcm-notification');
var FCM = new fcm('./serviceAccountKey.json');

// var FCM = require('fcm-node');
// var serverKey = 'AAAA3UlsK3Q:APA91bEQW7OTGIngsgqpJVqOGl-takQfQv40CBdfxeNhsqH6xc1W7KbPYTcL6uohS8F4m_gfv5DSh7QC8ix7JNRbTh9w2sSrJifXKn8HAOj-cstyRFQD7eAEkeKVFw8cslVG-qnKzNql'; //put your server key here
// var fcm = new FCM(serverKey);

const { getAllUsers, formatMessage, userJoin, getCurrentUser, userLeave } = require('./user')

io.on("connection", (socket) => {
  socket.on("joinRoom", ({ userName, room }) => {
    const user = userJoin(socket.id, userName, room)
    console.log(user)
    socket.join(user.room)
    socket.emit("getMessage", formatMessage('Admin', 'Welcome to ChatCord!'))
    socket.broadcast
      .to(user.room)
      .emit("getMessage", formatMessage('Admin', `${user.userName} has joined the chat`))
  })

  socket.on("sendMessage", (data) => {
    const room = socket.rooms.keys().next().value; // Get the current chat room ID
    const sender = socket.id; // Get the ID of the message sender
    console.log(sender)
    const user = getCurrentUser(socket.id)
    io.to(user.room).emit("getMessage", formatMessage(user.userName, data.message))

    const listClient = getAllUsers()
    const clients = socket.adapter.rooms.get(room);
    if (clients) {
      clients.forEach((client) => { // Send an FCM notification to each client in the room
        console.log('client',  client)
        if (client === sender) { // Exclude the sender from the notification recipients
          // const payload = {
          //   notification: {
          //     title: 'New Message',
          //     body: `${sender}: ${data.message}`,
          //   },
          //   data: {
          //     message: data.message,
          //     sender: sender,
          //   },
          // };
          // admin.messaging().sendToDevice(client, payload)
          //   .then((response) => {
          //     console.log(`FCM notification sent to ${client}:`, response);
          //   })
          //   .catch((error) => {
          //     console.error(`Error sending FCM notification to ${client}:`, error);
          //   });
          try {
            let message = {
              notification: {
                title: 'Title of your push notification',
                body: 'Body of your push notification',
              },
              data: {  
                message: data.message,
                sender: sender,
              },
              token: "BKCOoxr2vAeRq2PSQv94Ral3-W7u6B9PSx-zYsaxZpzf5zwE4zB9NzypOuLozjDFd6isAREJgfj-UVr_4Jxmt0o"
            }
        
            FCM.send(message, function (err, response) {
              if (err) {
                console.log("Something has gone wrong!");
              } else {
                console.log("Successfully sent with response: ", response);
              }
            });
          } catch (error) {
            console.log(error)
          }
        }
      });
    }

    // try {
    //   let message = {
    //     to: '/topics/' + room, // required fill with device token or topics
    //     notification: {
    //       title: 'Title of your push notification',
    //       body: 'Body of your push notification',
    //       sound: 'default',
    //       "click_action": "FCM_PLUGIN_ACTIVITY",
    //       "icon": "fcm_push_icon"
    //     },
    //     data: {  
    //       message: data.message,
    //       sender: sender,
    //     },
    //   }
  
    //   fcm.send(message, function (err, response) {
    //     if (err) {
    //       console.log("Something has gone wrong!");
    //     } else {
    //       console.log("Successfully sent with response: ", response);
    //     }
    //   });
    // } catch (error) {
    //   console.log(error)
    // }
  })

  socket.on("disconnect", () => {
    // removeUser(socket.id);
    // io.emit("getUser", roomMembers);
    const user = userLeave(socket.id);
    if (user) {
      io.to(user.room).emit("getMessage", formatMessage('Admin', `${user.userName} has left the chat`))
    }
  });

  // socket.on("addUser", (userID) => {
  //   addUser(userID, socket.id);
  //   io.emit("getUser", roomMembers);
  // });

  // socket.on("sendMessage", ({ senderID, receiverID, text }) => {
  //   // const user = getUser(receiverID);
  //   if (user) {
  //     io.to(user.socketID).emit("getMessage", {
  //       senderID,
  //       text,
  //     });
  //   }
  // });


  // socket.on("sendNotification", ({ senderID, receiverID, text }) => {
  //   const user = getUser(receiverID);
  //   if (user) {
  //     io.to(user.socketID).emit("getNotification", {
  //       senderID,
  //       text,
  //     });
  //   }
  // });


});

server.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
