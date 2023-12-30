const express = require("express");
const expenseRouter = express.Router();

const { createExpense, getExpenseData, updateExpense, deleteExpense, getBalance } = require("../controllers/expense");


expenseRouter.get("/:id", getExpenseData);
expenseRouter.post("/create", createExpense);
expenseRouter.put("/update", updateExpense);
expenseRouter.delete("/:id", deleteExpense);
expenseRouter.get("/balance/:id", getBalance);


module.exports = expenseRouter;