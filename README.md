# 📚 Orion Rigel Documentation Hub

Welcome to the complete documentation for the **Orion Rigel Financial Analysis Platform**. This hub organizes all technical specifications, implementation guides, and architectural documentation for the project.

## 📁 Documentation Structure

### 🎨 **Visual Documentation & Diagrams**

#### 🏗️ **Architecture & Infrastructure**
- **[Onboarding Flow](./visuals/diagrams/onboarding_diagram_flow.png)** - Overall High Level Onboarding Flow
- **[Sign Up -> Dashboard Access](./visuals/diagrams/sign_up_dashboard_flow.png)** - Sign Up to Dashboard Access
- **[Api Endpoints](./visuals/diagrams/onboarding_api_endpoints_flow.png)** - Core Onboarding API endpoints
- **[High-Level Infrastructure](./visuals/diagrams/high_level_infrastructure.pdf)** - Complete system architecture overview
- **[Database Architecture](./visuals/architecture/orion_rigel_db_schema.pdf)** - Orion Rigel database schema design

#### 🗃️ **Database & Schemas**
- **[Database Schemas](./visuals/database/schemas.sql)** - Complete SQL schema definitions
- **[Database Schema Diagram](./visuals/database/schemas.pdf)** - Visual database relationships and structure
- **[Data Models](./visuals/database/data_models.pdf)** - Entity relationship diagrams

#### 🔄 **Workflows & Processes**
- **[Authentication Flow](./visuals/workflows/authentication-flow.pdf)** - Complete user authentication sequence
- **[Data Upload Pipeline](./visuals/workflows/upload_pipeline.pdf)** - File processing and validation flow
- **[Valuation Process](./visuals/workflows/valuation_workflow.pdf)** - Property valuation sequence
- **[Report Generation](./visuals/workflows/report_generation.pdf)** - PDF and document creation flow

#### 📊 **Dashboard & Interface**
- **[Dashboard Layouts](./visuals/dashboards/dashboard_diagrams.pdf)** - Complete interface wireframes and layouts
- **[User Experience Flows](./visuals/dashboards/user_journeys.pdf)** - Key user interaction paths
- **[Component Library](./visuals/dashboards/component_library.pdf)** - UI elements and design system

#### 📈 **Data Flow & Analytics**
- **[Financial Model Flowcharts](./visuals/workflows/financial_models.pdf)** - Calculation algorithms and workflows
- **[Integration Maps](./visuals/diagrams/integration_maps.pdf)** - External system connections and APIs
- **[Analytics Pipeline](./visuals/workflows/analytics_pipeline.pdf)** - Data processing and insight generation


### 🧮 **Financial Calculations**
- **[Financial Calculations](./finance/README.md)** - Financial models and algorithms
- **[IRR Engine](./irr/README.md)** - Internal Rate of Return calculation system
- **[Optizimer Module](./optizimer/README.md)** - Optimization algorithms
- **[Comparison Engine](./comparison/README.md)** - Portfolio comparison tools

### 📊 **Dashboard & Interface**
- **[Dashboard Overview](./dashboard/README.md)** - Main dashboard architecture
- **[KPIs Validation](./kpis-validation/README.md)** - Key Performance Indicators system
- **[Lead-Scenario Onboarding](./lead-scenario-onboarding/README.md)** - User onboarding flow

### 🔐 **Authentication & Security**
- **[Authentication Flow](./authentication-flow.pdf)** - User authentication system diagram
- **[Profile Management](./profile/README.md)** - User profile and settings

### 🔌 **Integrations**
- **[Integrations Overview](./integrations/README.md)** - All external integrations
- **[DocuSign Integration](./integrations/docusign/README.md)** - Electronic signature workflow

### 📈 **Data Management**
- **[Upload System](./upload/README.md)** - Data import and file upload system
- **[Validation Engine](./validation/README.md)** - Data validation and sanitization
- **[Archiving & Purge](./archiving-purge/README.md)** - Data lifecycle management

### 📈 **Metrics & Analytics**
- **[Metrics Dashboard](./metrics/README.md)** - Performance tracking, analytics, and reporting systems


### 🧪 **Testing & Quality Assurance**
- **[Testing Framework](./testing/stripe/README.md)** - Testing methodologies and tools
- **[Stripe Integration Testing](./testing/stripe/README.md)** - Payment system testing

### 🎯 **Valuations & Analysis**
- **[Valuations System](./valuations/confidenceScore/README.md)** - Property valuation engine
- **[Confidence Scoring](./valuations/confidenceScore/README.md)** - Algorithm confidence metrics

### 📄 **PDF & Export Systems**
- **[PDF Generation](./pdf/README.md)** - Document export and reporting
- **[Mystic Module](./mystic/README.md)** - Advanced analytics engine

### 🔐 **Security & Authentication**
- **[Two-Factor Authentication (2FA)](./2fa/README.md)** - Enhanced security implementation and setup guide

### 💳 **Payment System Testing**
- **[Stripe Integration Testing](./stripe/testing.txt)** - Complete test cases and scenarios for payment processing

### 📋 **Templates & Resources**
- **[Excel Template](./orion_ai_calculator_mock.xlsx)** - Bulk upload Excel template

## 🚀 Quick Start Guides

### For Developers
1. Review the [Database Schemas](./schemas.sql)
2. Set up the [Dashboard](./dashboard/README.md)
3. Implement [Financial Calculations](./finance/README.md)

### For Implementation
1. Configure [Authentication](./authentication-flow.pdf)
2. Set up [Integrations](./integrations/README.md)
3. Implement [Data Validation](./validation/README.md)

### For Testing
1. Run [Stripe Tests](./testing/stripe/README.md)
2. Validate [KPIs](./kpis-validation/README.md)
3. Test [Upload System](./upload/README.md)

## 🔗 Related Resources

### External Dependencies
- **Stripe** - Payment processing
- **DocuSign** - Electronic signatures
- **Next.js** - Frontend framework
- **PostgreSQL** - Database system

### Internal Modules
- **BORB** - Bulk upload processing
- **Orion AI** - Machine learning analysis
- **Rigel Engine** - Core calculation engine

## 📞 Support & Maintenance

### Documentation Updates
When adding new features:
1. Create corresponding README.md in appropriate directory
2. Update this main README with new links
3. Ensure all file paths are relative to `docs/` directory

### Broken Links
Report broken documentation links to the technical documentation team. All paths are case-sensitive and should follow the exact structure above.

## 📝 Version Information
- **Documentation Version:** 2.1.0
- **Last Updated:** $(date)
- **Platform Version:** Orion Rigel v3.4.0

---

*Note: All documentation is written in Markdown format for consistency and easy editing. Use relative paths for all internal links.*