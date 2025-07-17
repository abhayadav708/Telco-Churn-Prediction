# 📊 Telco Customer Churn Prediction

An end-to-end project to analyze and predict customer churn using real-world telecom data. Built using SQL for data preparation, Python for modeling, and Power BI for interactive dashboards.

---

## 🚀 Project Overview

Customer churn is a critical metric for subscription-based businesses. This project leverages:
- 🛠 **SQL Server** for data modeling and feature engineering
- 🧠 **Python (Pandas + Scikit-learn)** for machine learning
- 📊 **Power BI** for executive-level dashboarding

---

## 📁 Dataset

- **Source**: IBM Sample Telco Churn Dataset  
- **Rows**: ~7,000 customer records  
- **Features**: demographics, contract type, service usage, support history

---

## 🧱 Tools & Tech Stack

| Layer             | Tools Used                            |
|------------------|----------------------------------------|
| Data Preparation | SQL Server (joins, views, exports)     |
| ML Modeling      | Python (Pandas, Scikit-learn, Matplotlib) |
| Dashboard        | Power BI (KPI cards, bar/column charts, slicers) |

---

## 🧠 Machine Learning Pipeline

1. **Data Cleaning**: Removed nulls, converted categories, binned charges
2. **Feature Engineering**: Aggregated churn drivers (tickets, plans, spend)
3. **Model Training**: Random Forest Classifier  
4. **Evaluation**: Confusion Matrix, Accuracy, Precision/Recall
5. **Top Features**:
   - Contract Type
   - Monthly Charges
   - Support Tickets

---

## 📊 Power BI Dashboard

Key visuals:
- ✅ Churn Rate by Contract Type
- ✅ Internet Service vs Churn
- ✅ Monthly Charges vs Churn
- ✅ Support Tickets vs Churn
- ✅ KPIs: Total Customers, Churned Customers, Churn Rate %


