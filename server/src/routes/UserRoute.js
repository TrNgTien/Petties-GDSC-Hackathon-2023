/**
 * @swagger
 * tags:
 *   name: User
 *   description: User Hanlder
 */

const express = require("express");
const router = express.Router();
const userHandler = require("../controllers/UserHandler");
const { Authentication } = require("../middleware/Authentication");
const multer = require('multer');

/**
 * @swagger
 * /user:
 *   get:
 *     summary: Get all users
 *     tags: [User]
 *     responses:
 *       200:
 *         description: Success
 */
router.get("/", userHandler.getAllUser);

/**
 * @swagger
 * /user/getPetowners:
 *   get:
 *     summary: Get all pet owners
 *     tags: [User]
 *     responses:
 *       200:
 *         description: Success
 */
router.get("/getPetowners", Authentication, userHandler.getPetowners);

/**
 * @swagger
 * /user/getPetowner/{userID}}:
 *   get:
 *     summary: Get pet owner with ID
 *     tags: [User]
 *     responses:
 *       200:
 *         description: Success
 */
router.get("/getPetowner/:userID", Authentication, userHandler.getPetowner);

/**
 * @swagger
 * /user/getPetsitters:
 *   get:
 *     summary: Get all petsitter
 *     tags: [User]
 *     responses:
 *       200:
 *         description: Success
 */
router.get("/getPetsitters", Authentication, userHandler.getPetsitters);

/**
 * @swagger
 * /user/getPetsitter/{userID}}:
 *   get:
 *     summary: Get petsitter with ID
 *     tags: [User]
 *     responses:
 *       200:
 *         description: Success
 */
router.get("/getPetsitter/:userID", Authentication, userHandler.getPetsitter);

/**
 * @swagger
 * /user/getReviews:
 *   get:
 *     summary: Get all review of petsitter
 *     tags: [User]
 *     responses:
 *       200:
 *         description: Success
 */
router.get("/getReviews", Authentication, userHandler.getReviews);

/**
 * @swagger
 * /user/filter?q={filter}:
 *   get:
 *     summary: Get filter users with pet
 *     tags: [User]
 *     responses:
 *       200:
 *         description: Success
 */
router.get("/filter", Authentication, userHandler.filterUser);

const upload = multer({
    storage: multer.memoryStorage()
})

/**
 * @swagger
 * /user/uploadAvatar/{userID}:
 *   post:
 *     summary: Upload avatar of user
 *     tags: [User]
 *     responses:
 *       200:
 *         description: Success
 */
router.post('/uploadAvatar/:userID', upload.single('filename'), userHandler.uploadAvatar);

/**
*  @swagger
*  /user/{userID}:
*    get:
*      summary: Get a user by ID
*      tags: [User]
*      parameters:
*        - in: path
*          name: userID
*          required: true
*          description: ID of the user to retrieve
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
router.get("/:userID", Authentication, userHandler.getUserInformation);

/**
*  @swagger
*  /user/editUser/{userID}:
*    put:
*      summary: Edit a user by ID
*      tags: [User]
*      parameters:
*        - in: path
*          name: userID
*          required: true
*          description: Edit a user by ID
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
router.put("/editUser/:userID", Authentication, userHandler.updateInformation);

/**
*  @swagger
*  /user/deleteUser/{userID}:
*    delete:
*      summary: Delete a user by ID
*      tags: [User]
*      parameters:
*        - in: path
*          name: userID
*          required: true
*          description: Delete a user by ID
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
router.delete("/deleteUser/:userID", Authentication, userHandler.deleteUser);

module.exports = router;
