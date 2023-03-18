const userRoute = require("./UserRoute");
const authRoute = require("./AuthRoute");
const socialFeedRoute = require("./SocialFeedRoute.js");
// const friendRoute = require("./FriendRoute");

function routes(app) {
  app.use('/user', userRoute);
  app.use('/auth', authRoute);
  app.use('/post', socialFeedRoute);
  // app.use(route.FRIEND, friendRoute);
}
module.exports = routes;
