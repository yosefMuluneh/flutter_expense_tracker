const express = require("express");
const authRouter = express.Router();
const {
  signIn,
  signUp,
  deleteAccount,
  changePassword,
} = require("../controllers/auth");

// user signup
authRouter.post("/signup", signUp);

// user signin
authRouter.post("/signin", signIn);
authRouter.delete("/deleteaccount/:id", deleteAccount);
authRouter.put("/changepassword/:id", changePassword);

module.exports = authRouter;
