const connection = require("../config/dbconnection");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const signUp = async (req, response) => {
  try {
    const { username, password } = req.body;
    // Hash password
    const hashedPassword = await bcryptjs.hash(password, 8);
    const query1 = `INSERT INTO account (username, password) VALUES ("${username}","${hashedPassword}")`;

    // Insert the user into account table
    connection.query(query1, (err, result) => {
      if (err) {
        return response.status(500).json({ error: "Internal server error" });
      }
    });

    // Get the user id from account table by phone number
    const query2 = `SELECT id FROM account WHERE username = '${username}'`;
    connection.query(query2, (err, result) => {
      if (err) {
        return response.status(500).json({ error: "Internal server error" });
      }

      const id = result[0].id;
      const payload = { id: id };
      const token = jwt.sign(payload, "secret-token-key");

      const query3 = `INSERT INTO balance (user_id) VALUES ("${id}")`;
      connection.query(query3, (err, result) => {
        if (err) {
          return response.status(500).json({ error: "Internal server error" });
        }
      });

      return response
        .status(200)
        .json({ id: result[0].id, username: username, token: token });
    });
  } catch (error) {
    return response.status(500).json({ error: error.message });
  }
};

const signIn = async (req, res) => {
  console.log(req.body);
  try {
    const { username, password } = req.body;
    const query = "SELECT * FROM account WHERE username = ?";
    connection.query(query, [username], async (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Internal server error" });
      }

      if (!result[0]) {
        return res.status(400).json({ error: "Username doesn't exists" });
      }

      const isMatch = await bcryptjs.compare(password, result[0].password);

      if (!isMatch) {
        return res.status(400).json({ error: "Incorrect password" });
      }

      const payload = { id: result[0].id, role: result[0].role };
      const token = jwt.sign(payload, "secret-token-key");
      const response = { id: result[0].id, username: username, token: token };
      return res.status(200).json(response);
    });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
};

const changePassword = async (req, res) => {
  try {
    const profileId = req.params.id;
    const { oldPassword, newPassword } = req.body;
    if (!oldPassword || !newPassword || !profileId) {
      return res
        .status(400)
        .json({ error: "Missing required fields to change password" });
    }

    const query1 = "SELECT password FROM account WHERE id = ?";
    connection.query(query1, [profileId], async (error, result, fields) => {
      if (error) {
        console.error(error);
        return res.status(500).json({ error: "Error changing password" });
      }
      //   const oldGivenHash = await bcryptjs.hash(oldPassword, 8);

      const isMatch = await bcryptjs.compare(oldPassword, result[0].password);

      if (!isMatch) {
        res.status(400).json({ error: "Incorrect password" });

        return;
      }

      const query = ` UPDATE account SET password = ? WHERE id = ?`;

      const newPassHash = await bcryptjs.hash(newPassword, 8);
      connection.query(
        query,
        [newPassHash, profileId],
        (error, results, fields) => {
          if (error) {
            console.error(error);
            res.status(500).json({ error: "Error Changing password" });
            return;
          } else {
            res.status(200).json({ msg: "password updated successfully" });
            return;
          }
        }
      );
    });
  } catch (error) {
    res.status(500).json({ error: "Error Changing password" });
  }
};

const deleteAccount = (req, res) => {
  try {
    const profileId = req.params.id;
    if (!profileId) {
      return res.status(400).json({ error: "Missing required fields" });
    }

    const query = "Delete from account WHERE id = ?";
    connection.query(query, [profileId], (error, results, fields) => {
      if (error) {
        return res.status(500).json("Error deleting account");
      }

      res.status(204).json({ msg: "Account Deleted successfully" });
    });
  } catch (error) {
    res.status(500).json({ error: "Error canceling appointment" });
  }
};

module.exports = {
  signIn,
  signUp,
  changePassword,
  deleteAccount,
};
