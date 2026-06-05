# 📊 Customer Journey Intelligence & Attribution Engine

## 🚀 Project Overview

This project builds an end-to-end customer journey analytics system to understand:

**“How do users move through the purchase funnel, which channels drive conversions, and what influences customer behavior?”**

Using SQL-based analytics, the project transforms raw website event data into actionable business insights for marketing, product, and growth teams.

---

## 🧩 Business Problem

Companies often struggle with:

- High user drop-offs before purchase
- Poor visibility into marketing channel effectiveness
- Limited understanding of customer behavior
- Difficulty identifying conversion bottlenecks

This project solves these challenges using a **data-driven attribution and funnel analytics system**.

---

## 📊 Dataset

### Google Merchandise Store Dataset

The project uses customer behavioral event data inspired by real-world e-commerce analytics.

Includes:

- Website user interactions
- Product views
- Add-to-cart behavior
- Purchase activity
- Traffic acquisition channels
- Customer segmentation data

---

## 🏗️ Architecture

Raw Events Data → SQL Analytics Engine → Funnel Analysis → Attribution Modeling → Customer Segmentation → Business Insights → Power BI Dashboard

---

## 🧠 Key Features

### 1. Funnel Analysis

Tracks customer movement across the purchase journey:

```text
view_item → add_to_cart → purchase
```

Metrics:

- Funnel drop-off analysis
- Add-to-cart conversion rate
- Purchase conversion rate

---

### 2. Channel Performance Analysis

Measures effectiveness of traffic sources:

- Organic Search
- Paid Ads
- Social Media
- Email Campaigns

Key metrics:

- Total users
- Purchases
- Conversion rate by channel

---

### 3. Customer Segmentation

Compares user behavior between:

- New Users
- Returning Users

Insights generated:

- Conversion differences
- Purchase behavior patterns
- Customer retention opportunities

---

### 4. Product Performance Analysis

Identifies:

- Top purchased products
- High-converting categories
- Product demand trends

---

### 5. Attribution Modeling ⭐

Implements marketing attribution logic using SQL window functions.

#### First Touch Attribution

Identifies the channel responsible for customer acquisition.

Example:

```text
Google → Email → Purchase
```

First touch = **Google**

---

#### Last Touch Attribution

Identifies the final channel responsible for conversion.

Example:

```text
Google → Email → Purchase
```

Last touch = **Email**

---

### 6. Business Recommendation Layer

Automatically classifies channel performance:

- High Performing Channel
- Moderate Channel
- Needs Optimization

This helps marketing teams prioritize spending and optimization efforts.

---

## 🗂️ Data Model

### Raw Tables

- `events`
- `users`
- `items`

### Analytics Tables

- `funnel_metrics`
- `channel_performance`
- `customer_segments`
- `top_products`
- `first_touch_attribution`
- `last_touch_attribution`

---

## 🛠️ SQL Concepts Used

- CTEs
- Window Functions (`ROW_NUMBER()`)
- Aggregations
- CASE Statements
- Joins
- Funnel Analytics
- Attribution Logic
- Conversion Rate Calculations

---

## 📈 Sample Business Questions Answered

- Which traffic source drives the highest conversion?
- Where are users dropping in the funnel?
- Are returning users more valuable than new users?
- Which products contribute most to purchases?
- What channel acquires vs converts customers?

---

## 💡 Key Business Insights

- Funnel drop-offs reveal conversion bottlenecks
- Returning users show stronger purchase intent
- Some channels generate traffic but weak conversions
- Attribution helps optimize marketing spend
- Product-level behavior supports merchandising decisions

---

## 🎯 Why This Project Stands Out

- Solves a **real-world marketing analytics problem**
- Implements **attribution modeling**
- Includes **customer behavior analytics**
- Uses **window functions and advanced SQL**
- Designed for **business decision making**
- Dashboard-ready and recruiter-friendly

---

## 🔮 Future Improvements

- Add real-time event streaming
- Integrate A/B testing experiments
- Add ML-based churn prediction
- Build interactive Power BI dashboard
- Automate reporting pipeline

---

## 🧑‍💻 Author

**Bhavin Rathod**