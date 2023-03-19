const express = require("express");
const dotenv = require("dotenv");
dotenv.config();
const cors = require("cors");
const routes = require("./src/routes/index.js");
const path = require('path')
const app = express();
const server = require("http").Server(app);
const io = require("socket.io")(server);
const swaggerUi = require('swagger-ui-express');
const bodyParser = require("body-parser");
const swaggerJsdoc = require("swagger-jsdoc");

//Detect mode
const mode = process.env.NODE_ENV || "development";
const config = require("config").get(mode);
const PORT = process.env.PORT || config.port;

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')))

app.use(cors({
  origin: [`http://localhost:3333`, `http://localhost:3000`],
}));

routes(app);
app.get("/", (req, res) => {
  res.send("<h1>RESTful called successfully!</h1>");
});


const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "Petties-GDSC-Hackathon-2023",
      version: "0.1.0",
      description:
        "This is a Petties-GDSC-Hackathon-2023 API documentation.",
      contact: {
        name: "Tien Tran",
        url: "linkedin.com/in/trngtien",
      }
    },
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        }
      }
    },
    security: [{
      bearerAuth: []
    }],
    servers: [
      {
        url: "http://localhost:8080",
      },
    ],
  },
  apis: ["./src/routes/*.js"],
};
const specs = swaggerJsdoc(options);
app.use(
  "/api-docs",
  swaggerUi.serve,
  swaggerUi.setup(specs)
);

app.post("/test", (req, res) => {
  const token = req.body.token;
  console.log('Received token:', token);

  try {
    let message = {
      notification: {
        title: 'Title of your push notification',
        body: 'Body of your push notification',
      },
      data: {
        message: 'This is a Firebase Cloud Messaging Topic Message!',
      },
      token: token,
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

  if (socket) {
    console.log('Assigning Socket.IO connection to token:', token);
    // Assign the Socket.IO connection to the token
    socket.token = token;
  } else {
    console.error(`Socket.IO connection not found for token: ${token}`);
  }
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

const { getAllUsers, formatMessage, userJoin, getCurrentUser, userLeave } = require('./user');

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
        console.log('client', client)
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
              token: "",
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
});

server.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
