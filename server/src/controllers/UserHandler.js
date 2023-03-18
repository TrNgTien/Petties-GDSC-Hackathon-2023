const { v4: uuidv4 } = require("uuid");
const db = require("../database/firebase-connection")

module.exports = {
  getAllUser: async (req, res) => {
    try {
      const userSnapshot = await db.collection("users").get();
      let users = [];
      userSnapshot.forEach((x) =>
        users.push({
          ...x.data(),
        })
      );
      return res.status(200).json({
        data: users,
      });
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  getUserInformation: async (req, res) => {
    try {
      let userID = req.params.userID;
      const userRef = await db.collection("users").doc(userID);
      const result = await userRef.get();
      if (!result.exists) {
        return res.status(400).json({
          message: "User not found",
        });
      } else {
        return res.status(200).json({
          data: result.data(),
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  updateInformation: async (req, res) => {
    try {
      let userID = req.params.userID;
      let infoUpdate = req.body;

      const checkEmail = await db.collection("users").where("email", "==", infoUpdate.email).get();
      if (!checkEmail.empty) {
        return res.status(400).json({
          message: "Email already existed",
        });
      }

      const userRef = await db.collection("users").doc(userID);
      const data = await userRef.get();
      if (!data.exists) {
        return res.status(400).json({
          message: "User not found",
        });
      }
      await userRef.update(infoUpdate);
      return res.status(200).json({
        message: "Update successfully!",
      });
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  deleteUser: async (req, res) => {
    try {
      let userID = req.params.userID;
      const userRef = await db.collection("users").doc(userID);
      const data = await userRef.get();
      if (!data.exists) {
        return res.status(400).json({
          message: "User not found",
        });
      }
      const result = await userRef.delete();
      return res.status(200).json({
        message: "Delete successfully!",
      });
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },

  // updateAvatar: async (req, res) => {
  //   try {
  //     let base64 = req.body.userAvatar;
  //     let suffixes = uuidv4();
  //     let key = `avatar/${req.user.id}-${suffixes}`;
  //     let { id } = req.params;
  //     if (req.user.id === id) {
  //       let uploadResponse = await uploadS3(key, base64);
  //       await User.findByIdAndUpdate(
  //         id,
  //         {
  //           userAvatar: {
  //             url: uploadResponse.locationS3,
  //             publicID: uploadResponse.keyS3,
  //           },
  //         },
  //         {
  //           new: true,
  //         }
  //       );
  //       return res.status(200).json({
  //         message: "Update successfully!",
  //       });
  //     } else {
  //       return res.status(401).json({
  //         message: "Only edit personal profiles",
  //       });
  //     }
  //   } catch (error) {
  //     console.log(error);
  //     return res.status(500).json("Internal server error");
  //   }
  // },
  // updateCover: async (req, res) => {
  //   try {
  //     let base64 = req.body.userCover;
  //     let suffixes = uuidv4();
  //     let key = `cover/${req.user.id}-${suffixes}`;
  //     let { id } = req.params;
  //     if (req.user.id === id) {
  //       let uploadResponse = await uploadS3(key, base64);
  //       await User.findByIdAndUpdate(
  //         id,
  //         {
  //           userCover: {
  //             url: uploadResponse.locationS3,
  //             publicID: uploadResponse.keyS3,
  //           },
  //         },
  //         {
  //           new: true,
  //         }
  //       );
  //       return res.status(200).json({
  //         message: "Update successfully!",
  //       });
  //     } else {
  //       return res.status(401).json({
  //         message: "Only edit personal profiles",
  //       });
  //     }
  //   } catch (error) {
  //     console.log(error);
  //     return res.status(500).json("Internal server error");
  //   }
  // },
  // addFriend: async (req, res) => {
  //   try {
  //     let { friendID } = req.params;
  //     let userID = req.user.id;
  //     let user = await User.findOne({ _id: userID });
  //     await user.updateOne({ $push: { friends: friendID } });
  //     return res.status(200).json({
  //       message: "Add friend successfully!",
  //     })
  //   }
  //   catch (error) {
  //     console.log(error);
  //     return res.status(500).json("Internal server error");
  //   }
  // },
  // getFriends: async (req, res, next) => {
  //   try {
  //     let id = req.user.id;
  //     let user = await User.findOne({ _id: id });
  //     let friendList = user.friends;
  //     let listFriend = [];
  //     for (let i = 0; i < friendList.length; i++) {
  //       let friend = await User.findOne({ _id: friendList[i] });
  //       listFriend.push({
  //         userID: friend._id,
  //         fullName: friend.firstName + " " + friend.lastName,
  //         avatar: friend.userAvatar.url,
  //       });
  //     }
  //     return res.status(200).json({
  //       friends: listFriend,
  //     })
  //   }
  //   catch (error) {
  //     console.log(error);
  //     return res.status(500).json("Internal server error");
  //   }
  // },
  // getFriendsOfUser: async (req, res) => {
  //   let { ownId } = req.params;
  //   let user = await User.findOne({ _id: ownId });
  //   let friendList = user.friends;
  //   let listFriend = [];
  //   for (let i = 0; i < friendList.length; i++) {
  //     let friend = await User.findOne({ _id: friendList[i] });
  //     listFriend.push({
  //       userID: friend._id,
  //       fullName: friend.firstName + " " + friend.lastName,
  //       avatar: friend.userAvatar.url,
  //     });
  //   }
  //   return res.status(200).json({
  //     friends: listFriend,
  //   });
  // },
  // deleteFriends: async (req, res) => {
  //   try {
  //     let { friendID } = req.params;
  //     let userID = req.user.id;
  //     let user = await User.findOne({ _id: userID });
  //     await user.updateOne({ $pull: { friends: friendID } });
  //     return res.status(200).json({
  //       message: "Delete friend successfully!",
  //     });
  //   }
  //   catch (error) {
  //     console.log(error);
  //     return res.status(500).json("Internal server error");
  //   }
  // }
};
