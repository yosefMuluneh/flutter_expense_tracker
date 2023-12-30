const express = require("express");
const budgetRouter = express.Router();

const { createBudget, updateBudget, getBudgetData, deleteBudget } = require("../controllers/budget");


budgetRouter.get("/:id", getBudgetData);
budgetRouter.post("/post", createBudget);
budgetRouter.put("/update", updateBudget);
budgetRouter.delete("/:id", deleteBudget);



module.exports = budgetRouter;
