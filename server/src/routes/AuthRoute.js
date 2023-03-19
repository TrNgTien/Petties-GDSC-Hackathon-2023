/**
 * @swagger
 * tags:
 *   name: Authentication
 *   description: Authentic Hanlder
 */

const express = require("express");
const router = express.Router();
const authHandler = require("../controllers/AuthHandler");

/**
* @swagger
* /register:
*   post:
*     summary: User registration
*     tags: [Authentication]
*     requestBody:
*       required: true
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
* /login:
*   post:
*     summary: User login
*     tags: [Authentication]
*     requestBody:
*       required: true
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
