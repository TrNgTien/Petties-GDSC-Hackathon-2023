const bcrypt = require("bcrypt");
const jwt = require('jsonwebtoken');
const saltRounds = 10;
const { v4: uuidv4 } = require("uuid");
const { db } = require("../database/firestore-connection");

module.exports = {
  register: async (req, res) => {
    try {
      let { email, password } = req.body;

      if (!email || typeof email !== "string") {
        return res.status(400).json({
          message: "Invalid Email",
        });
      }
      if (!password || typeof password !== "string") {
        return res.status(400).json({
          message: "Invalid Password",
        });
      }
      if (password.length < 6) {
        return res.status(400).json({
          message: "Password length must be more than 6 characters long",
        });
      }
      let hashedPassword = await bcrypt.hashSync(password, saltRounds);

      const checkEmail = await db.collection("users").where("email", "==", email);
      const check = await checkEmail.get();
      if (!check.empty) {
        return res.status(400).json({
          message: "Email already existed",
        });
      }

      const userID = uuidv4();
      let objUser = {
        userID: userID,
        email: email,
        password: hashedPassword,
        description: "",
        userAvatar: "https://cdn-icons-png.flaticon.com/512/6386/6386976.png",
        review: 0,
        role: "petowner",
        pets: [],
      };
      await db.collection("users").doc(userID).set(objUser);
      return res.status(200).json({
        message: "Register Successfully",
      });
    } catch (error) {
      console.log(error);
      if (error.code === 11000) {
        return res.status(400).json({
          message: "Email already existed",
        });
      }
      return res.status(500).json("Internal server error");
    }
  },

  login: async (req, res) => {
    try {
      let { email, passwordInput } = req.body;
      console.log(email, passwordInput);
      const checkEmai = await db.collection("users").where("email", "==", email).get();
      if (checkEmai.empty) {
        return res.status(400).json({
          message: "Incorrect UserName or Password",
        });
      }
      let user = {};
      checkEmai.forEach((x) => (user = x.data()));
      const checkPassword = await bcrypt.compareSync(passwordInput, user.password);
      if (!checkPassword) {
        return res.status(400).json({
          message: "Incorrect UserName or Password",
        });
      }
      const { password, ...info } = user;
      const accessToken = jwt.sign({ userID: user.userID, role: user.role },
        process.env.ACCESS_TOKEN_SECRET, { expiresIn: '5d' });
      return res.status(200).json({ ...info, accessToken });
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
};
