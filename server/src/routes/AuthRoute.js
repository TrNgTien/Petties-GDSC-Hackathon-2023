/**
 * @swagger
 * tags:
 *   name: Authentication
 *   description: Authentic Hanlder
 */
/**
 * @swagger
 * components:
 *   schemas:
 *     Auth:
 *       type: object
 *       required:
 *         - email
 *         - password
 *       properties:
 *         email:
 *           type: string
 *           description: The email of user
 *         password:
 *           type: string
 *           description: The password of user
 */
const express = require("express");
const router = express.Router();
const authHandler = require("../controllers/AuthHandler");

/**
* @swagger
* /auth/register:
*   post:
*     summary: User registration
*     tags: [Authentication]
*     requestBody:
*      content:
*       application/json:
*         schema:
*          type: object
*          properties:
*            email:
*             type: string
*            password:
*             type: string
*          example:
*           email: "user@root.com"
*           password: "root"
*     description: User registration
*     content:
*       application/json:
*       schema:
*         type: object
*       properties:
*         email:
*           type: string
*           description: User's email 
*         password:
*           type: string
*           description: User's pass
*     responses:
*       201:
*         description: User created
*/
router.post("/register", authHandler.register);

/**
* @swagger
* /auth/login:
*   post:
*     summary: User login
*     tags: [Authentication]
*     requestBody:
*      content:
*       application/json:
*         schema:
*          type: object
*          properties:
*            email:
*             type: string
*            passwordInput:
*             type: string
*          example:
*           email: "user@root.com"
*           password: "root"
*     description: User login
*     content:
*       application/json:
*       schema:
*         type: object
*       properties:
*         email:
*           type: string
*           description: User's email 
*         password:
*           type: string
*           description: User's pass
*     responses:
*       201:
*         description: User created
*/
router.post("/login", authHandler.login);

module.exports = router;
