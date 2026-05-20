## zepto Product Inventory - SQL Analysis

# Project Overview

This project performs end_to_end SQL analysis on Zepto's Product Inventory data.
It covers data exploration,cleaning, and business insights generation to understand pricing,discounts,stock,availablity, and category-wise revenue.

# Tools & Technologies

Tool                        Purpose
MYSQL                       Database & querying
MySql Workbench              Query execution & results

# Dataset
file : dataset/zepto_v2.csv
Rows : 1000+ products
Source : Zepto product inventory


# Column                        Description
sku_id                          Unique Product ID
category                        Product category
name                            Product name
mrp                             Maximum retail price(₹)
discountpercent                 Discount % offered
availableQuantity               Units in stock
discountedSellingPrice          Final price after discount(₹)
WeightInGms                     Product weight in grams
outOfStock                      Stock availablity(True/False)
quantity                        Quantity per unit

# Data Cleaning

- ❌ Removed products where MRP = 0 (invalid entries)
- ✅ Handled NULL values across all columns
- 💰 Converted prices from paise to rupees (÷ 100)
- 🔍 Identified duplicate SKUs for same product names

# Key Insights

-  Fruits & Vegetables has the highest total inventory weight
-  Several high-MRP products are out of stock — revenue opportunity
-  Some categories offer very low discounts despite premium pricing
-  Bulk weight products offer best price-per-gram value
-  Multiple SKUs exist for same product names


# How to Run
1. Open  MYSQL Workbench
2. Create DATABASe

CREATE DATABASE zepto_sql_project;
USE zepto_sql_project;

3. Import zepto_v2.csv into zepto table
4. Open sql_analysis.sql and run section by section

# Author
Shelly Baisla
Aspiring Data Analyst | SQL

GitHub: shellybaisla
