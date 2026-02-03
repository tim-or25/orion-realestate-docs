|  #  | Metric                                 | Formula                                         | Meaning                                             |
| :-: | -------------------------------------- | ----------------------------------------------- | --------------------------------------------------- |
|  1  | **Gross Scheduled Income (GSI)**       | `GSI = Monthly_Rent × Units × 12`               | Annual income if fully occupied                     |
|  2  | **Vacancy Loss**                       | `Vacancy = GSI × Vacancy_Rate`                  | Expected income loss due to vacancies               |
|  3  | **Effective Gross Income (EGI)**       | `EGI = GSI – Vacancy`                           | Income actually collected                           |
|  4  | **Operating Expenses (OPEX)**          | Sum of maintenance, taxes, insurance, utilities | Annual cost to operate property                     |
|  5  | **Net Operating Income (NOI)**         | `NOI = EGI – OPEX`                              | Profit before financing; core profitability measure |
|  6  | **Capitalization Rate (Cap Rate)**     | `CapRate = NOI / Purchase_Price`                | Return on investment ignoring financing             |
|  7  | **Cash Flow Before Tax (CFBT)**        | `CFBT = NOI – Debt_Service`                     | Annual free cash flow before taxes                  |
|  8  | **Cash on Cash Return (CoC)**          | `CoC = CFBT / Initial_Cash_Invested`            | Actual % return on invested cash                    |
|  9  | **Gross Rent Multiplier (GRM)**        | `GRM = Purchase_Price / Annual_Rent`            | Quick valuation ratio                               |
|  10 | **Debt Service Coverage Ratio (DSCR)** | `DSCR = NOI / Debt_Service`                     | Lender’s measure of safety margin                   |
|  11 | **Loan-to-Value (LTV)**                | `LTV = Loan_Amount / Property_Value`            | Financing ratio                                     |
|  12 | **Break-Even Ratio (BER)**             | `(OPEX + Debt_Service) / EGI`                   | % occupancy required to break even                  |
|  13 | **Total Return (TR)**                  | `(Cash_Flow + Appreciation) / Total_Investment` | Overall yield including appreciation                |
|  14 | **Internal Rate of Return (IRR)**      | `IRR = irr(cash_flows[])`                       | Multi-year performance metric                       |
|  15 | **Return on Investment (ROI)**         | `(Gain – Cost) / Cost`                          | Simple overall return                               |
