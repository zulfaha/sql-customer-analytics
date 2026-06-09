
# SQL Customer Analytics: Brazilian E-Commerce

## 1. Summary

Exploratory analysis of 99,000+ real Brazilian e-commerce orders [from the Olist public dataset on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). I wrote this to answer the kind of questions a data analyst might actually get asked - where customers are, whats breaking, how logisitcs perform, where money comes from, and whether customers come back. 

All queries are written in PostgreSQL.

---

## Dataset

Orders placed on the Olist platform between 2016 and 2018. It includes customer location, order status, delivery timestamps, product categories, freight costs, and payment details across five tables: `orders`, `customers`, `order_items`, `payments`, and `products`.

---

## 2. Business Context & Research Questions

**Company:** Olist (São Paulo-based e-commerce marketplace, 2016–2018 data)

**Questions investigated:**
1. **Market concentration:** Are we too dependent on one region?
2. **Operational health:** How many orders fail, and why?
3. **Logistics performance:** Which states get slow, expensive delivery?
4. **On time accuracy:** Are delivery estimates honest or padded?
5. **Revenue drivers:** Which product categories actually make money?
6. **Customer loyalty:** Do customers come back?
7. **Payment Behaviour:** How are customers choosing to pay, and does the method tell us anything about order value?
8. **Logistics Cost vs Delivery Reliability:** Does expensive shipping actually arrive faster?

---
## 3. Methodology
PostgreSQL in pgAdmin 4, 5 normalized tables, queried with SQL (JOINs, CTEs, window functions).
[Schema](schema.sql) | [Diagram](schema_diagram.png)

---

## 4. Key Findings
> Full analysis, implications, and limitations in `analysis.pdf`

### Q1: MARKET CONCENTRATION

São Paulo accounts for ~42% of all orders. The top 3 states (SP, RJ, MG) cover ~66% of orders thats a heavy concentration risk.
If São Paulo sneezes, Olist catches a cold.

Techniques: GROUP BY,COUNT,ROUND,OVER(),ORDER BY

[Full query](/queries/query1.sql)

---

### Q2: ORDER FAILURE RATE

97% delivered. Cancellations and unavailability are at (~0.6%) each. Low, but in a 99k order dataset thats 600 orders each. Its worth tracking whether those cluster by seller,category, or payment method.

Techniques: GROUP BY,COUNT,ORDER BY,OVER()

[Full query](/queries/query2.sql)

---

### Q3: DELIVERY PERFORMANCE

SP averages **8 days** transit at **R$15** freight. Northern states (RR, AP, AM) average **26+ days** at **R$35–43** freight
Same northern states from query 1 had the lowest orders, long delivery times and high freight costs are likely lowering demand. 

Techniques: DATE subtraction(::date),::numeric cast,AVG/MIN/MAX,GROUP BY,NULL filtering

[Full query](/queries/query3.sql)

---

### Q4: ON-TIME DELIVERY & PROMISE ACCURACY

**20+ states show **100% on-time rates**, with deliveries arriving **20–46 days earlier** than the promised date. It seems Olist deliberately delays estimates to protect satisfaction scores rather than reflect realistic timelines.

Techniques: CASE WHEN,::date subtraction,::numeric cast,percentage calculation,NULL filtering

[Full query](/queries/query4.sql)

---

### Q5: REVENUE BY PRODUCT CATEGORY 

Beauty/health (`beleza_saude`) leads revenue at **R$1.25M** although its not the highest volume category. Watches/gifts (`relogios_presentes`) has the highest avg price at **R$200** but lower order volume. Most ordered category bed/bath (`cama_mesa_banho`) only ranks 3rd in revenue, this shows that volume and revenue rankings do not align.

Techniques: COALESCE,COUNT DISTINCT,SUM,AVG, GROUP BY,LIMIT

[Full query](/queries/query5.sql)

---

### Q6: CUSTOMER RETENTION

**97%** of customers purchase only once, repeat buyers are rare. For a marketplace this is rough, it meanss almost all revenue depens on new customer acquistion rather than retained spend. Either retention is broken, or olist is functioning more as an initial lead for sellers and then doing business outside of Olist.

Techniques: CTE,CASE WHEN,COUNT DISTINCT,window function OVER()

[Full query](/queries/query6.sql)

--- 

### Q7: PAYMENT BEHAVIOUR

Credit card accounts for **75%** of orders at an average order value of **R$163**. Boleto (cash-based bank slip) represents **19%**, it shows that there is a large unbanked customer group. Voucher users spend less than half the average credit card order (**R$65 vs R$163**), There is a pattern of discount driven behaviour instead of demand.

Techniques: COUNT DISTINCT,window function OVER(),AVG,SUM,GROUP BY

[Full query](/queries/query7.sql)

---

### Q8: FREIGHT VS SPEED

Higher freight does not buy faster delivery, orders in the **Very High tier (R$50+)** average **16.5 days** transit and a **10.7% late rate**,versus **5.8 days** and **6% late** for low cost orders. Expensive shipping is a geography tax on remote customers not a premium service.

Techniques: CASE WHEN,::date subtraction,::numeric cast,conditional COUNT(late_pct),GROUP BY

[Full query](/queries/query8.sql)

---
### Files 

[`analysis.pdf` — Full write-up with implications and limitations per query](/analysis/analysis.pdf)

---

### Database Schema
- [ER Diagram (PNG)](schema_diagram.png)
- [Schema SQL (DDL)](schema.sql)

---

## Status
- [x] Schema design
- [x] Data loading 
- [x] Query writing 
- [x] Analysis and insights (in progress)
