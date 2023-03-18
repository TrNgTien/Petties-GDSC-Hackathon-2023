const express = require("express");
const router = express.Router();
const userHandler = require("../controllers/UserHandler");

router.get("/", userHandler.getAllUser);
router.get("/:userID", userHandler.getUserInformation);
router.put("/editUser/:userID", userHandler.updateInformation);
router.delete("/deleteUser/:userID", userHandler.deleteUser);

module.exports = router;
