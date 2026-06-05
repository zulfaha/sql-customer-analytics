
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

### Finding 1: Extreme Geographic Concentration
São Paulo (SP) and Rio de Janeiro (RJ) account for **53% of customers**. 
The North region (Amapá, Roraima, Acre) represents **0.3%**.

*Implication:* National marketing spend may be inefficient. Customer acquisition cost in low density regions is likely excessively high.

*Limitation:* Describes concentration, not causation. Low counts may reflect logistics gaps, income demographics, or marketing absence.

[Full query](/queries/query1.sql)

---

### Finding 2: Order Pipeline is Healthy overall
**96.5% delivered, 0.6% cancelled, 1.1% shipped, 1.8% processing.**

*Implication:* The overall order pipeline looks strong.

*Limitation:* Overall health masks trouble spots in individual categories. Cancellation 
rate by product category gives a clearer view of where things go wrong, or if certain categories are struggling.

[Full query](/queries/query2.sql)

---

### Finding 3: Delivery Timestamps Cannot Measure True Logistics

Attempted to calculate delivery days by state. Result: **0.26 days (6.2 hours)** 
for "delivered" orders whci is not possible for e-commerce.

*Root cause:* Timestamps measure system status transitions, not physical delivery. 
`order_delivered_customer_date` marks system closure, not package arrival.

*Decision:* Abandoned delivery time as primary metric. Retained seller handoff 
speed as secondary operational indicator with limited relevance.

*Recommendation:* For true delivery analysis, Olist requires carrier tracking 
APIs (GPS, delivery confirmation, customer signatures).

[Investigation query](/queries/query3_delivery_investigation.sql)

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
