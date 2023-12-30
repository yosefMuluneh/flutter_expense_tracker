const { json } = require("express");
const connection = require("../config/dbconnection");

const getExpenseData = async (req, response) => {
  try {
    const id = req.params.id;
    const query = `SELECT * FROM expense WHERE user_id = ${id}`;
    connection.query(query, (err, result) => {
      if (err) {
        return response.status(500).json({ error: "Internal server error" });
      }
      return response.status(200).json(result);
    });
  } catch (error) {
    return response.status(500).json({ error: error.message });
  }
};

const getBalance = async (req, response) => {
  try {
    const id = req.params.id;
    const query = `SELECT * FROM balance WHERE user_id = ${id}`;
    connection.query(query, (err, result) => {
      if (err) {
        return response.status(500).json({ error: "Internal server error" });
      }

      return response.status(200).json(result[0]);
    });
  } catch (error) {
    return response.status(500).json({ error: error.message });
  }
};

const createExpense = async (req, res) => {
  try {
    const { user_id, type, category, amount, date } = req.body;
    if (!user_id || !type || !category || !amount || !date) {
      return res.status(400).json({ error: "Please fill all the fields" });
    }
    const query =
      "INSERT INTO expense (user_id, type, category, amount, date) VALUES (?,?,?,?,?)";
    connection.query(
      query,
      [user_id, type, category, amount, date],
      (err, result) => {
        if (err) {
          return response.status(500).json({ error: "Internal server error" });
        }
        const query3 = `UPDATE  balance SET ${type} = ${type} + ${amount} where user_id = ${user_id}`;
        connection.query(query3, (err, result) => {
          if (err) {
            return response
              .status(500)
              .json({ error: "Internal server error" });
          }
        });

        return res
          .status(200)
          .json({ message: "Expense created successfully" });
      }
    );
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
};

const updateExpense = async (req, res) => {
  try {
    const { id, user_id, type, category, amount, date } = req.body;
    if (!id || !user_id || !type || !category || !amount || !date) {
      return res.status(400).json({ error: "Please fill all the fields" });
    }
    const query =
      "UPDATE expense set type = ?, category = ?, amount = ?, date = ? where id = ?";
    connection.query(
      query,
      [type, category, amount, date, id],
      (err, result) => {
        if (err) {
          return response.status(500).json({ error: "Internal server error" });
        }
        return res
          .status(200)
          .json({ message: "Expense updated successfully" });
      }
    );
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
};

const deleteExpense = async (req, res) => {
  const id = req.params.id;
  try {
    const query = `DELETE FROM expense WHERE id = ?`;
    connection.query(query, [Number(id)], async (err, result) => {
      if (err) {
        throw err;
      }
      return res.status(204).json(true);
    });
  } catch (e) {
    return res.status(404).json({ error: "data not found" });
  }
};

module.exports = {
  createExpense,
  getExpenseData,
  updateExpense,
  deleteExpense,
  getBalance,
};
