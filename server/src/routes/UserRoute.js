const express = require("express");
const router = express.Router();
const userHandler = require("../controllers/UserHandler");
const { Authentication } = require("../middleware/Authentication");
const multer = require('multer');

router.get("/", userHandler.getAllUser);

router.get("/getPetowners", Authentication, userHandler.getPetowners);
router.get("/getPetowner/:userID", Authentication, userHandler.getPetowner);

router.get("/getReviews", Authentication, userHandler.getReviews);

router.get("/filter", Authentication, userHandler.filterUser);

const upload = multer({
    storage: multer.memoryStorage()
})

router.post('/uploadAvatar/:userID', upload.single('filename'), userHandler.uploadAvatar);

router.get("/:userID", Authentication, userHandler.getUserInformation);
router.put("/editUser/:userID", Authentication, userHandler.updateInformation);
router.delete("/deleteUser/:userID", Authentication, userHandler.deleteUser);

module.exports = router;
