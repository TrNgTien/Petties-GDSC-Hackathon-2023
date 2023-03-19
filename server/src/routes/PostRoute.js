/**
 * @swagger
 * tags:
 *   name: Post
 *   description: Post Hanlder
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     Post:
 *       type: object
 *       required:
 *         - postID
 *         - description
 *         - postAttachments
 *         - userID
 *       properties:
 *         postID:
 *           type: string
 *           description: The auto-generated id with UUID
 *         description:
 *           type: boolean
 *           description: The description of post
 *         postAttachments:
 *           type: object
 *           description: The review of user
 *         userID:
 *           type: string
 *           description: The auto-generated id with UUID
 */
const express = require("express");
const router = express.Router();
const postHandler = require("../controllers/PostHandler");

/**
 * @swagger
 * /post:
 *   get:
 *     summary: Get all posts
 *     tags: [Post]
 *     responses:
 *       200:
 *         description: Success
 */
router.get("/", postHandler.getAllPosts);

/**
 * @swagger
 * /post/{postID}:
 *   get:
 *     summary: Get post by ID
 *     tags: [Post]
 *     responses:
 *       200:
 *         description: Success
 */
router.get("/:postID", postHandler.getPostById);

/**
*  @swagger
*  /post/{postID}:
*    post:
*      summary: Add a new post by ID
*      tags: [Post]
*      parameters:
*        - in: path
*          name: userID
*          required: true
*          description: Add a new post by ID
*          schema:
*            type: string
*      responses:
*        200:
*          description: Success
*        404:
*         description: User not found
*        500:
*         description: Internal server error   
*/
router.post("/addPost", postHandler.addPost);

/**
*  @swagger
*  /post/editPost/{postID}:
*    put:
*      summary: Edit a post by ID
*      tags: [Post]
*      parameters:
*        - in: path
*          name: userID
*          required: true
*          description: Edit a post by ID
*          schema:
*            type: string
*      responses:
*        200:
*          description: Success
*        404:
*         description: User not found
*        500:
*         description: Internal server error   
*/
router.put("/editPost/:postID", postHandler.editPost);

/**
*  @swagger
*  /post/deletePost/{postID}:
*    delete:
*      summary: Delete a post by ID
*      tags: [Post]
*      parameters:
*        - in: path
*          name: userID
*          required: true
*          description: Delete a post by ID
*          schema:
*            type: string
*      responses:
*        200:
*          description: Success
*        404:
*         description: User not found
*        500:
*         description: Internal server error   
*/
router.delete("/deletePost/:postID", postHandler.deletePost);

module.exports = router;
