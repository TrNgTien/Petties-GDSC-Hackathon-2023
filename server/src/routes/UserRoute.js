const express = require("express");
const router = express.Router();
const userHandler = require("../controllers/UserHandler");
const { Authentication } = require("../middleware/Authentication");

router.get("/", userHandler.getAllUser);

router.get("/getPetowners", Authentication, userHandler.getPetowners);
router.get("/getPetowner/:userID", Authentication, userHandler.getPetowner);

router.get("/getReviews", Authentication, userHandler.getReviews);

router.get("/filter", userHandler.filterUser);

router.get("/:userID", userHandler.getUserInformation);
router.put("/editUser/:userID", userHandler.updateInformation);
router.delete("/deleteUser/:userID", userHandler.deleteUser);

module.exports = router;
