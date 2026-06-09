
# SQL Customer Analytics: Brazilian E-Commerce

## 1. Summary

An exploratory SQL analysis of 99,000+ real Brazilian e-commerce orders [from the Olist public dataset on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). My goal was to answer practical business questions a data analyst might actually be asked, covering customer geography, operations, logistics, revenue, and retention.

All queries are written in PostgreSQL.

---

## Dataset

The dataset covers orders placed on the Olist platform between 2016 and 2018. It includes customer location, order status, delivery timestamps, product categories, freight costs, and payment details across five tables: `orders`, `customers`, `order_items`, `payments`, and `products`.

---

## 2. Business Context & Research Questions

**Company:** Olist (São Paulo-based e-commerce marketplace, 2016–2018 data)

**Questions investigated:**
1. **Market concentration:** Where are our customers actually based, and are we too dependent on one region?
2. **Operational health:** What percentage of orders fail, and what's going wrong?
3. **Logistics performance:** Does it take longer to deliver to certain states, and what does that cost?
4. **Revenue drivers:** Which product categories actually make money?
5. **Customer loyalty:** Do customers come back, or are we essentially a one-time purchase business?
6. **Payment Behaviour:** How are customers choosing to pay, and does the method tell us anything about order value?
7. **Logistics Cost vs Delivery Reliability:** Does paying more for shipping actually get your order there faster, or is it just a geography problem?

---
## 3. Methodology
PostgreSQL database with 5 normalized tables, designed in pgAdmin 4, 
queried with SQL (JOINs, CTEs, window functions). [Schema](schema.sql) | [Diagram](schema_diagram.png)

---

## 4. Key Findings
> Full analysis, implications, and limitations in `analysis.pdf`

### Q1: MARKET CONCENTRATION
Which states drive the most orders and revenue?

São Paulo accounts for ~42% of all orders.
The top 3 states (SP, RJ, MG) cover ~66% of orders this shows a significant concentration risk.
Over-reliance on a single state is a factor that should be monitiored.

Techniques: GROUP BY, COUNT,ROUND, OVER(), ORDER BY

[Full query](/queries/query1.sql)

---

### Q2: OPERATIONAL HEALTH — ORDER FAILURE RATE
What share of orders are canceled or unavailable?

97% of orders reach "delivered" status.
Cancellations (~0.6%) and unavailability (~0.6%) are low but worth monitoring.

Techniques: GROUP BY, COUNT,ORDER BY, OVER()

[Full query](/queries/query2.sql)

---

### Q3: DELIVERY PERFORMANCE

SP averages **8 days** transit at **R$15** freight
Northern states (RR, AP, AM) average **26+ days** at **R$35–43** freight
The same northern states from Finding 1 had the lowest orders, long delivery times and high freight costs which are likely lowering demand. 

Techniques: DATE subtraction (::date),::numeric cast, AVG/MIN/MAX, GROUP BY, NULL filtering

[Full query](/queries/query3.sql)

---

### Q4: ON-TIME DELIVERY & PROMISE ACCURACY

**20+ states show **100% on-time rates**, with deliveries arriving **20–46 days earlier** than the promised date. It seems Olist deliberately delays estimates to protect satisfaction scores rather than reflect realistic timelines.

[Full query](/queries/query4.sql)

---

### Q5: REVENUE BY PRODUCT CATEGORY 

Beauty/health (`beleza_saude`) leads revenue at **R$1.25M** although its not the not  the highest volume category. Watches/gifts (`relogios_presentes`) has the highest avg price at **R$200** but lower order volume. Most ordered category bed/bath (`cama_mesa_banho`) only ranks 3rd in revenue, this shows that volume and revenue rankings do not align.

[Full query](/queries/query5.sql)

---

### Q6: CUSTOMER RETENTION

**97%** of customers purchase only once, repeat buyers are very rare.
I think that this indicates a big retention problem; almost all revenue depends on acquiring new customers instead of returning ones.

[Full query](/queries/query6.sql)

--- 

### Q7: PAYMENT BEHAVIOUR

Credit card accounts for **75%** of orders at an avg order value of **R$163**.
Boleto (Brazil's cash-based bank slip) represents **19%**, it shows that there is a large unbanked customer group. Voucher users spend less than half the avg credit card order (**R$65 vs R$163**), I notice a pattern of discount driven behaviour instead of demand.

[Full query](/queries/query7.sql)

---

### Q8: FREIGHT COST VS DELIVERY PERFORMANCE

Higher freight does not buy faster delivery, this means a possible geographic disadvantage.
I found that orders in the **Very High tier (R$50+)** average **16.5 days** transit and a **10.7% late rate**,versus **5.8 days** and **6% late** for low cost orders. Expensive shipping is a tax on remote customers not a premium service.

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
