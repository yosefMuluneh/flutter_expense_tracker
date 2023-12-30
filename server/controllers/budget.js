const { json } = require("express");
const connection = require("../config/dbconnection");

const getBudgetData = async (req, response) => {
  try {
    const id = req.params.id;
    const query = `SELECT * FROM budget WHERE user_id = ${id}`;
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

const createBudget = async (req, res) => {
  try {
    const { user_id, type, amount, date } = req.body;
    console.log(req.body);
    if (!user_id || !type || !amount || !date) {
      return res.status(400).json({ error: "Please fill all the fields" });
    }
    // const query1 = `DELETE FROM budget WHERE id = ?`;

    const query =
      "INSERT INTO budget (user_id, type, amount, date) VALUES (?,?,?,?)";
    connection.query(query, [user_id, type, amount, date], (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Internal server error" });
      }
      return res.status(200).json({ message: "Budget created successfully" });
    });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
};

const updateBudget = async (req, res) => {
  try {
    const { id, user_id, type, amount, date } = req.body;
    if (!id || !user_id || !type || !amount || !date) {
      return res.status(400).json({ error: "Please fill all the fields" });
    }
    const query =
      "UPDATE budget set type = ?,  amount = ?, date = ? where id = ?";
    connection.query(query, [type, amount, date, id], (err, result) => {
      if (err) {
        return response.status(500).json({ error: "Internal server error" });
      }
      return res.status(200).json({ message: "Budget updated successfully" });
    });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
};

const deleteBudget = async (req, res) => {
  const id = req.params.id;
  try {
    const query = `DELETE FROM budget WHERE id = ?`;
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

module.exports = { createBudget, updateBudget, getBudgetData, deleteBudget };
