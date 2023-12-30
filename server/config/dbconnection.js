const mysql = require("mysql");
// require("dotenv").config();

// const dbConfig = {
//   host: process.env.HOST,
//   user: process.env.USER,
//   password: process.env.PASSWORD,
//   database: process.env.DB_NAME,
//   connectionLimit: 10,
// };

const dbConfig = {
  host: "localhost",
  user: "root",
  password: "",
  database: "expense",
  connectionLimit: 10,
};

//  * -------------- connect to mysql DATABASE ----------------
const connection = mysql.createConnection(dbConfig);

connection.connect((err) => {
  if (err) {
    console.log("----***********---------- error in database connection");
    console.log(err);
  } else {
    console.log("-----------------------");
    console.log("|  Connected to mysql |");
    console.log("-----------------------");
  }
});

// Expose the connection
module.exports = connection;
