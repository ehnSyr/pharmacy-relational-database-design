# Pharmacy Operations Relational Database Design

**Course:** IST 659 — Data Administration Concepts & Database Management
**Project:** "The Real Housewives of Beverly Pills" — Group 1

A relational database design and implementation project for a fictional pharmacy chain. The database tracks patients, orders, drug inventory, pharmacies, and insurance coverage, and is paired with a Power BI dashboard for reporting on sales, orders, and inventory levels.

## Business Problem

The pharmacy needed a database to track orders, patients, inventory, costs, and insurance providers in order to maintain profitable inventory levels, keep accurate patient records, and ensure proper payment/coverage tracking. Store inventory outside of drugs, vendor invoicing, and employee management were treated as out of scope.

## Repository Contents

| Folder | Contents |
|---|---|
| `sql/` | `SQLQuery_Group_Project.sql` — full DDL (table/constraint creation), sample `INSERT` statements, and reporting views |
| `data/` | `Test_data.xlsx` (sample records used to validate the schema) and `Team_Log.xlsx` (group work log) |
| `powerbi/` | `RealHousewivesOfBeverlyPills.pbix` — Power BI report built on top of the database |
| `docs/` | Project charter and a PDF export of the Power BI dashboard |
| `diagrams/` | Conceptual and logical data model diagrams (`.drawio`, open with [diagrams.net](https://app.diagrams.net)) |

## Database Design

The schema (see `sql/SQLQuery_Group_Project.sql`) includes the following core tables, with lookup/bridge tables to resolve many-to-many relationships:

- `patients`, `patient_address`, `patient_address_lookup`
- `pharmacies`, `pharmacy_address`, `pharmacy_address_lookup`
- `insurance`, `insurance_type`, `patient_insurance_lookup`, `coverage_amounts`
- `drugs`, `inventory`
- `orders`, `order_item_details`
- `state_lookup`

Reporting views (prefixed `v_`) are included for each major entity, e.g. `v_patient_address` and `v_pharmacy_address` concatenate address fields into a single display string, and `v_order_item_details` joins in coverage amounts by drug and insurance.

## Reporting

The `RealHousewivesOfBeverlyPills.pbix` Power BI report (exported as PDF in `docs/`) includes three pages:

- **Pharmacy Summary** — sales, orders, and items ordered by pharmacy and by drug
- **Inventory** — inventory levels by drug and pharmacy, with low/high stock flags
- **Pharmacy Order Details** — per-patient order history, OTC/generic mix, and insurance coverage breakdown

## How to Run

1. Run `sql/SQLQuery_Group_Project.sql` against a SQL Server instance (it creates a `pharmacy` database, tables, constraints, sample data, and views). Update the `USE fudgemart_v3;` line near the top if you don't have that database — it's only referenced so the script can `DROP DATABASE` cleanly before recreating it.
2. Open `powerbi/RealHousewivesOfBeverlyPills.pbix` in Power BI Desktop and point it at your SQL Server instance to refresh the data.

## Team

| Name | Role |
|---|---|
| Jessica Krumm | Data Governance Manager |
| Erika Haase | Project Manager |
| Daylin Hernandez | Subject Matter Expert |
| Noor Adnan Aljiboury | Technical Advisor |

## Notes

- All patient, pharmacy, and insurance data in this repository is fictional and generated for coursework purposes only.
- The `diagrams/` files are placeholders from the original project — they didn't contain the finished conceptual/logical model content, so the ER structure documented above (and the dashboard PDF) currently stand in for them.
