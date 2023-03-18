const userRoute = require("./UserRoute");
const authRoute = require("./AuthRoute");
const postRoute = require("./PostRoute.js");

function routes(app) {
  app.use('/user', userRoute);
  app.use('/auth', authRoute);
  app.use('/post', postRoute);
}

module.exports = routes;
