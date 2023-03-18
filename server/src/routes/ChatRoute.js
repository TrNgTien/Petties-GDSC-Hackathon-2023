const express = require("express");
const router = express.Router();
const chatHandler = require("../controllers/ChatHandler");

router.post("/createRoom", chatHandler.createRoom);

module.exports = router;