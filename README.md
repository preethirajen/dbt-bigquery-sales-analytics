# Sales Analytics Pipeline | dbt + BigQuery

An end-to-end sales analytics project built using **dbt Core, Google BigQuery and SQL**, demonstrating data transformation, data quality, incremental processing and historical data tracking.

## Tech Stack

- **Google BigQuery** — Cloud data warehouse
- **dbt Core** — SQL transformation and data modelling
- **SQL & Jinja** — Data cleansing, joins, reusable logic and incremental processing
- **Git & GitHub** — Version control

## Data Architecture

```text
BigQuery Raw Data
├── customers
├── orders
└── products
       │
       ▼
dbt Staging Layer (Views)
├── stg_customers
├── stg_orders
└── stg_products
       │
       ▼
Sales Mart (Table)
└── fct_sales
       │
       ▼
Incremental Sales Mart
└── fct_sales_incremental
```

Additional components:

- **customers_snapshot** — SCD Type 2 customer history
- **country_lookup.csv** — Reference data loaded using dbt seeds
- **dbt tests** — Data quality validation

## Key Features

### Data Cleaning and Transformation

- Standardised customer names, emails, countries and product information.
- Removed duplicate orders using `ROW_NUMBER()`.
- Joined orders, customers and products to calculate sales revenue.
- Applied business rules to exclude invalid or incomplete transactions.

### Data Quality Testing

Implemented dbt tests including:

- `unique`
- `not_null`
- `relationships`
- `accepted_values`

These tests identify duplicate keys, missing values, invalid statuses and orphan customer references.

### Incremental Loading

Implemented an incremental model using BigQuery `MERGE`, with `order_id` as the unique key.

- Inserts new orders.
- Updates existing orders.
- Uses an `updated_at` watermark to detect changes.
- Handles late-arriving updates to older orders.

### Slowly Changing Dimensions (SCD Type 2)

Implemented a dbt snapshot using the `check` strategy to track changes in customer attributes.

Historical records are preserved using `dbt_valid_from` and `dbt_valid_to`.

### Documentation and Lineage

Generated dbt documentation with model descriptions, column metadata, tests and an interactive dependency graph.

## Project Structure

```text
sales_analytics/
├── macros/
│   └── generate_schema_name.sql
├── models/
│   ├── staging/
│   │   ├── sources.yml
│   │   ├── schema.yml
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   └── stg_products.sql
│   └── marts/
│       ├── fct_sales.sql
│       └── fct_sales_incremental.sql
├── seeds/
│   └── country_lookup.csv
├── snapshots/
│   └── customers_snapshot.sql
├── dbt_project.yml
└── README.md
```

## Running the Project

Requires dbt Core, the BigQuery adapter, access to a Google Cloud project and a locally configured dbt profile.

```bash
pip install dbt-bigquery

dbt debug
dbt seed
dbt run
dbt test
dbt snapshot
dbt docs generate
dbt docs serve
```

The source BigQuery tables (`customers`, `orders`, `products`) must exist before running the models. Database and dataset configuration should be adjusted for the target environment.

## Learning Outcomes

This project demonstrates hands-on experience with:

- Building modular SQL transformations in dbt
- Designing staging and reporting layers
- Implementing data quality checks
- Developing incremental ELT pipelines
- Managing SCD Type 2 history
- Understanding model dependencies and lineage
- Version-controlling a data engineering project

## Future Enhancements

- GitHub Actions for automated dbt validation
- Additional business-level data quality tests
- Sales reporting and analytics models
