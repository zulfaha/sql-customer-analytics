
# SQL Customer Analytics: Brazilian E-Commerce

A SQL database project analyzing customer behavior, order patterns, and payment 
trends using the Brazilian E-Commerce Public Dataset from Olist.

## Dataset
Source: [Kaggle - Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Database Schema
- **customers**: Customer demographics and location
- **orders**: Order details, dates, and status
- **order_items**: Individual items within each order
- **products**: Product categories and attributes
- **payments**: Payment methods and values

## Business Questions
1. What is the distribution of customers by state?
2. Which product categories generate the most revenue?
3. What is the average order value and how does it vary by payment type?
4. How long does delivery typically take, and which states have the longest delays?
5. What percentage of orders are cancelled, and do cancellation rates vary by product category?

## Tools Used
- PostgreSQL (database)
- pgAdmin 4 (GUI)
- SQL (queries, CTEs, window functions)

## Status
- [x] Schema design
- [ ] Data loading (in progress)
- [ ] Query writing
- [ ] Analysis and insights
