# ⭐ Lead-to-Lead Comparison v1

A premium comparison tool that visualizes lead performance through cosmic-inspired graphs and AI-powered insights.

---

## ✨ Features

### 🔍 Selection Interface
- **Portfolio Picker** – Dropdown listing all accessible portfolios
- **Multi-Lead Selector** – Multi-select box showing all leads within the chosen portfolio
- **KPI Metric Chooser** – Checkbox list of financial KPIs:
  - NOI (Net Operating Income)
  - DSCR (Debt Service Coverage Ratio)
  - Cap Rate (Capitalization Rate)
  - CoC (Cash on Cash Return)
  - IRR (Internal Rate of Return)
  - Monthly Cashflow
  - ...and more

### 📊 Visualization
- **Glowing Line Graph** – Cosmic-style visualization with each lead assigned a distinct glowing color
- **Interactive Chart** – Hover details, zoom, and metric toggling

### 🤖 AI Insights
- **Generate Insight Button** – Triggers loading animation followed by AI analysis
- **Insight Tiles** – Formatted, actionable insights displayed in digestible cards

### 💾 Data Persistence
- **Comparison History** – Full database schema for saving user comparisons
- **User Favorites** – Users can bookmark and revisit previous comparisons

### 📄 Export Capabilities
- **Premium PDF Export** – Generate detailed comparison reports in PDF format
- **Shareable Links** – Unique URLs for saved comparisons

---

## 🎨 Orion Design Aesthetic

### Visual Identity
- **Borders**: `border-orion-gold/30` with subtle gold accents
- **Gradients**: Cosmic color schemes with deep space to nebula transitions
- **Animations**: Pulsing tiles and smooth transitions
- **Typography**:
  - **Titles**: Lusitana (serif, elegant)
  - **Body**: Inter (sans-serif, highly readable)
- **Interactive Elements**:
  - Gold hover rings on clickable components
  - Slight glow shadows for depth and emphasis
  - Cosmic particle effects on graph backgrounds

### UI Components
```css
/* Example theme implementation */
.comparison-card {
  border: 1px solid var(--orion-gold-30);
  background: var(--cosmic-gradient);
  font-family: 'Inter', sans-serif;
  box-shadow: 0 4px 20px rgba(255, 215, 0, 0.1);
}

.graph-container {
  background: radial-gradient(circle at 50% 50%, #0f172a, #020617);
}