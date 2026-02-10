markdown
# API Health Monitor

Real-time API endpoint testing and monitoring system for Orion Rigel.

## 🚀 Features

- **User Selection**: Test APIs with any user's data
- **Dynamic Parameter Resolution**: Automatically resolves `$user.portfolios[0].id` etc.
- **Real-time Testing**: Test individual or all routes
- **Results Dashboard**: Color-coded status, response times, error details
- **Export Options**: JSON, CSV, and email reports
- **Scheduled Tests**: Daily automated tests with email alerts
- **Auto-refresh**: Periodically re-test routes
- **Validation**: Config validation and parameter checking

## 📁 Configuration

### Route Configs
Located in `app/config/api-health/categories/`:

```yaml
# users.yaml example
category: "Users"
routes:
  - name: "Get user profile"
    id: "user-profile"
    path: "/api/user/profile"
    method: "GET"
    parameters:
      query:
        userId: "$user.id"
Available Dynamic Parameters
$user.id - Selected user's ID

$user.portfolios[0].id - First portfolio ID

$user.portfolios[0].leads[0].id - First lead ID

$user.portfolios[0].leads[0].scenarios[0].id - First scenario ID

🛠️ Usage
1. Access
Navigate to: Admin Dashboard → API Health Monitor

2. Select User
Use the search to find and select a user. The system will automatically fetch their portfolios, leads, and scenarios.

3. Test Routes
Test All: Tests every configured route

Test Single: Click "Test" next to any route

Test Group: Group by status/category and test entire groups

Auto-refresh: Enable periodic re-testing

4. View Results
✅ Green = Success

❌ Red = Failure (click for error details)

⏳ Gray = Not tested

Response times shown in milliseconds

5. Export & Share
JSON Export: Full results for analysis

CSV Export: Spreadsheet-friendly format

Email Report: Send to support@orion-rigel.org

6. Schedule Tests
Set daily automated tests that run and email results automatically.

⚙️ Environment Configuration
Edit app/config/environments.yaml:

yaml
environments:
  development:
    baseUrl: "http://localhost:3000"
    timeout: 10000
  production:
    baseUrl: "https://app.yourdomain.com"
    timeout: 20000
🔧 Adding New Routes
Create/edit YAML file in app/config/api-health/categories/

Follow existing format

Use dynamic parameters where possible

Run validation check

📧 Email Integration
Uses existing /api/send-email endpoint. Emails go to:

Manual reports: support@orion-rigel.org

Scheduled tests: support@orion-rigel.org

🚨 Troubleshooting
"No data available" errors
Ensure user has portfolios/leads

Check network tab for failed fetches

Verify route parameters are resolvable

Slow performance
Reduce auto-refresh interval

Limit number of routes tested

Check network latency

Email not sending
Verify /api/send-email endpoint works

Check email service configuration

Review browser console for errors

📈 Monitoring
Check these for system health:

Response times > 5000ms indicate slowness

Failure rate > 10% needs investigation

Missing parameters in validation panel

Maintained by: Admin Team
Contact: support@orion-rigel.org
Last Updated: ${new Date().toLocaleDateString()}

Final deliverables:

✅ Complete API Health Monitor system

✅ Admin interface with all features

✅ Configuration system

✅ Email integration

✅ Scheduled tests

✅ Documentation

✅ Quick reference guide

Ready for production deployment.