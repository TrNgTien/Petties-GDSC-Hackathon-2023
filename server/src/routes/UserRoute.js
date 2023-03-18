const express = require("express");
const router = express.Router();
const userHandler = require("../controllers/UserHandler");

router.get("/", userHandler.getAllUser);

router.get("/getPetowners", userHandler.getPetowners);
router.get("/getPetowner/:userID", userHandler.getPetowner);

router.get("/getPetsitters", userHandler.getPetsitters);
router.get("/getPetsitter/:userID", userHandler.getPetsitter);

router.get("/getReviews", userHandler.getReviews);

router.get("/filter", userHandler.filterUser);

router.get("/:userID", userHandler.getUserInformation);
router.put("/editUser/:userID", userHandler.updateInformation);
router.delete("/deleteUser/:userID", userHandler.deleteUser);

module.exports = router;
