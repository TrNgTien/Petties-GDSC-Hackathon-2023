const express = require("express");
const router = express.Router();
const postHandler = require("../controllers/PostHandler");

router.get("/", postHandler.getAllPosts);
router.get("/:postID", postHandler.getPostById);
router.post("/addPost", postHandler.addPost);
router.put("/editPost/:postID", postHandler.editPost);
router.delete("/deletePost/:postID", postHandler.deletePost);

module.exports = router;
