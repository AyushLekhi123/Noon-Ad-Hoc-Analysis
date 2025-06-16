# 🍽️ Noon Ad-Hoc SQL Analysis

An ad-hoc data analysis project to evaluate the performance of Noon’s first food restaurant vertical in Dubai using SQL.

---

## 📝 Problem Statement

Noon launched their **first Food Restaurant in Dubai on 1st January 2025**.

This project addresses key business questions, provides actionable insights, and highlights KPIs to help the growth team and line managers understand customer behavior and operational performance.

---

## 🗂️ Dataset

A custom `orders` table was created with additional synthetic rows to allow for better and more realistic analysis scenarios.

---

## 🛠️ SQL Tools Used

- 🧩 Subqueries  
- 📊 Aggregation Functions  
- 🪟 Window Functions  
- 🔁 Common Table Expressions (CTEs)

---

## 📈 Business Questions Answered

1. 🔝 Find **Top 3 item cuisine types** (without using `LIMIT` or `TOP`)
2. 📅 Daily count of **new customers** acquired from launch date
3. 1️⃣ Count of **customers acquired in Jan 2025** who placed **only one order**
4. ⏳ List of customers with **no orders in the last 7 days**, acquired a month ago, and made their **first order using promo**
5. 🧠 Help the Growth team create a **trigger**: Identify customers after their **3rd order in March 2025** for personalized communication
6. 🎯 List customers with **more than 1 order**, all of which were **promo-based**
7. 📉 What percentage of customers were **organically acquired** in Jan 2025 (i.e., placed first order without a promo code)?

---

## 📊 Insights

- 🥇 **Lebanese cuisine** had the **maximum number of orders** placed.
- 📆 The **highest number of customer acquisitions** occurred on **31st January 2025**.
- 🎫 Only **2 customers** (`DEF9876543210XYZ`, `UVW7890123456JKL`) placed **more than 1 promo-based order**.
- 📉 **43.9%** of customers were **organically acquired** in January 2025 (placed their first order **without a promo code**).

---

## 🙌 Acknowledgement

Special thanks to [Ankit Bansal](https://www.linkedin.com/in/ankitbansal6/) for the project inspiration.
