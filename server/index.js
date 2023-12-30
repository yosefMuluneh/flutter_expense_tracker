const express = require("express");
const cors = require("cors");

const app = express();

//! DB connections
const connection = require("./config/dbconnection");

// require("dotenv").config();

//! custom Route imports
const authRouter = require("./routes/auth");
const expenseRouter = require("./routes/expense");
const budgetRouter = require("./routes/budget");


//! Global Middle-wares
app.use(
  cors({
    origin: "*",
  })
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//! Routes
app.use("/auth", authRouter);
app.use("/expense", expenseRouter);
app.use("/budget", budgetRouter);


//! Start Express server
const PORT = process.env.PORT || 3000;
try {
  app.listen(PORT, "0.0.0.0", () => {
    console.log("--------------------------");
    console.log(`| listening on port ${PORT} |`);
    console.log("--------------------------");
  });
} catch (error) {
  console.log("there is a error is starting the server");
}
