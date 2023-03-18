const userRoute = require("./UserRoute");
const authRoute = require("./AuthRoute");
const postRoute = require("./PostRoute");
const chatRoute = require("./ChatRoute");

function routes(app) {
  app.use('/user', userRoute);
  app.use('/auth', authRoute);
  app.use('/post', postRoute);
  app.use('/chat', chatRoute);
}

module.exports = routes;
