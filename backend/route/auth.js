const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcrypt");
const router = express.Router();
const jwt = require("jsonwebtoken");
const saltRound = 10;

// sign up api endpoint
router.post("/api/signup", async (req, res) => {
  try {
    //extract from the req body
    const { fullName, email, password } = req.body;
    //check if the user exists in the database
    const userExists = await User.findOne({ email });
    if (userExists) {
      return res
        .status(400)
        .json({ message: "user with same name already exists" });
    } else {
      const hashPassword = await bcrypt.hash(password, saltRound);
      let user = new User({ fullName, email, password: hashPassword });
      user = await user.save();
      res.json({ user });
      console.log('sign up status code: ' + res.statusCode);
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//signin api endpoint
router.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const foundUser = await User.findOne({ email }); // if the email exists in the User, the User data will store in the foudUser, if not foundUser will be null
    if (!foundUser) {
      res.status(400).json({ message: "user with that email does not exist" });
    } else {
      const isMatch = await bcrypt.compare(password, foundUser.password);
      if (!isMatch) {
        res.status(400).json({ message: "Incorrect Password" });
      } else {
        const token = jwt.sign({ id: foundUser._id }, "passwordKey");
        const { password, ...userWithoutPassword } = foundUser._doc;
        res.json({ token, ...userWithoutPassword });
        console.log('login status code: ' + res.statusCode);
      }
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = router;
