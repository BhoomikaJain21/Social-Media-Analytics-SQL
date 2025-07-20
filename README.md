# 📊 Social Media Analytics (SQL Project)

This project builds a backend SQL system that simulates a social media platform. It manages users, posts, likes, and comments, and provides powerful analytical insights through SQL queries, views, functions, and triggers.

## 🚀 Features
- 1000 users, 2000+ posts, 3000 likes, 1500 comments
- Triggers for real-time like/comment count updates
- Advanced SQL queries for:
  - Top posts/users
  - Engagement analytics
  - Posts with no likes/comments
- Stored procedures for bulk operations and summaries
- Views for dashboard-style reporting
- Function to calculate total engagement per post

## 🧰 Tools Used
- MySQL Workbench
- SQL (MySQL)
- GitHub

## 🛠️ Structure
- `schema.sql`: Database and table creation
- `insert_dummy_data.sql`: Bulk insert scripts
- `trigger_function_create.sql`: Triggers and user-defined functions created
- `trigger_function_testing.sql`: Triggers and user-defined functions tested
- `analytic_queries.sql`: Analytical SQL queries
- `views.sql`: Reusable SQL views for insights
- `procedures_use.sql`: Common procedures
- `report.pdf`: Project report (included)

## 📈 Example Queries
- Top 10 most liked posts
- Most active users by engagement
- Posts with no interaction
- Average likes per post per user
- Comment leaderboard by post

## ✅ How to Run
1. Import `schema.sql` to create DB and tables.
2. Execute insert procedures to populate data.
3. Run `trigger_function_create.sql`.
4. Explore data using queries and views.
5. Call procedures as needed.

---
