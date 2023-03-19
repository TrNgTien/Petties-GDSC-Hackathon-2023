const express = require("express");
const router = express.Router();
const postHandler = require("../controllers/PostHandler");
const { Authentication } = require("../middleware/Authentication");

router.get("/", postHandler.getAllPosts);
router.get("/:postID", postHandler.getPostById);
router.post("/addPost", Authentication, postHandler.addPost);
router.put("/editPost/:postID", Authentication, postHandler.editPost);
router.delete("/deletePost/:postID", Authentication, postHandler.deletePost);

module.exports = router;
