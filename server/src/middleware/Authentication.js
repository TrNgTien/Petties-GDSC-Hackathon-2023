const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
dotenv.config();

const Authentication = (req, res, next) => {
	try {
		let token = req.get("Authorization");
		if (!token) {
			return res.status(401).json("UnAuthorized");
		} else {
			const authtoken = token.slice(7);
			const validatedUser = jwt.verify(authtoken, process.env.ACCESS_TOKEN_SECRET);
			req.user = validatedUser;
			next();
		}
	} catch (error) {
		console.log(error);
		return res.status(401).json({ error: "Unauthorized" });
	}
};

module.exports = { Authentication };
