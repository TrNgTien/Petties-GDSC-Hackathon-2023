const { v4: uuidv4 } = require("uuid");
const { db } = require("../database/firestore-connection");

module.exports = {
  getAllPosts: async (req, res) => {
    try {
      const postSnapshot = await db.collection("posts").get();
      let posts = [];
      postSnapshot.forEach((x) =>
        posts.push({
          ...x.data(),
        })
      );
      return res.status(200).json({
        data: posts,
      });
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  getPostById: async (req, res) => {
    try {
      let postID = req.params.postID;
      const postRef = await db.collection("posts").doc(postID);
      const result = await postRef.get();
      if (!result.exists) {
        return res.status(400).json({
          message: "Post not found",
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
  addPost: async (req, res) => {
    try {
      if (req.user.role == "petsitter") {
        const userID = req.user.userID;
        const { description, postAttachments } = req.body;
        const postID = uuidv4();
        let objPost = {
          postID: postID,
          description: description,
          postAttachments: postAttachments,
          userID: userID,
        };
        await db.collection("posts").doc(postID).set(objPost);
        return res.status(200).json({
          message: "Post Successfully!",
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  editPost: async (req, res) => {
    try {
      if (req.user.role == "petsitter") {
        const { description } = req.body;
        const postID = req.params.postID;
        const postRef = await db.collection("posts").doc(postID);
        const data = await postRef.get();
        if (!data.exists) {
          return res.status(400).json({
            message: "Post not found",
          });
        }
        await postRef.update({
          description: description,
        });
        return res.status(200).json({
          message: "Update successfully",
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  deletePost: async (req, res) => {
    try {
      if (req.user.role == "petsitter") {
        let postID = req.params.postID;
        const postRef = await db.collection("posts").doc(postID);
        const data = await postRef.get();
        if (!data.exists) {
          return res.status(400).json({
            message: "Post not found",
          });
        }
        await postRef.delete();
        return res.status(200).json({
          message: "Delete post successfully",
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
};
