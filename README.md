
# SQL Customer Analytics: Brazilian E-Commerce

## 1. Executive Summary
Analysis of 99,441 customers, 112,650 order items, and 103,886 payments from 
the Brazilian Olist platform. Identified geographic concentration risks, delivery 
performance gaps, and revenue drivers. Full technical documentation available in 
[Appendix](#appendix) and [SQL files](/queries/).

## Dataset
Source: [Kaggle - Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

---

## 2. Business Context & Research Questions

**Company:** Olist (São Paulo-based e-commerce marketplace, 2016–2018 data)

**Questions investigated:**
1. **Market concentration:** Where are our customers? Are we over-dependent on one region?
2. **Operational health:** What percentage of orders fail, and why?
3. **Logistics performance:** Does delivery time vary by geography, and what does it cost us?
4. **Revenue drivers:** Which product categories actually make money?
5. **Customer loyalty:** Do customers come back, and what predicts retention?

---
## 3. Methodology
PostgreSQL 18 database with 5 normalized tables, designed in pgAdmin 4, 
queried with SQL (JOINs, CTEs, window functions). [Schema](schema.sql) | [Diagram](schema_diagram.png)

---

## 4. Key Findings

---

## 5. Recommendations

---

## 6. Limitations of This Analysis

---

## Appendix: Technical Documentation

---

### Database Schema
- [ER Diagram (PNG)](schema_diagram.png)
- [Schema SQL (DDL)](schema.sql)

---

## Status
- [x] Schema design
- [x] Data loading (in progress)
- [ ] Query writing
- [ ] Analysis and insights
