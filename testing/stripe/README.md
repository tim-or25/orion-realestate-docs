# 🧪 Testing Checklist
1. Environment Setup Verification
bash
# Check your environment variables

```bash
echo "Stripe Keys:"
echo "PUBLISHABLE: ${NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY}"
echo "SECRET: ${STRIPE_SECRET_KEY}"
echo "WEBHOOK: ${STRIPE_WEBHOOK_SECRET}"
echo "Price IDs:"
echo "STARTER: ${NEXT_PUBLIC_STRIPE_STARTER_PRICE_ID}"
echo "PRO: ${NEXT_PUBLIC_STRIPE_PRO_PRICE_ID}"
echo "ENTERPRISE: ${NEXT_PUBLIC_STRIPE_ENTERPRISE_PRICE_ID}"
```

2. Database Verification
sql
-- Check your subscription_plans table
```sql
SELECT * FROM subscription_plans;
```
-- Check your tables exist

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('user_subscriptions', 'subscription_plans', 'user_usage', 'monthly_usage');
```

3. Step-by-Step Testing Process
Phase 1: Public User Flow (Not Logged In)
Navigate to pricing page as anonymous user

Click "Sign Up for Free Trial" on Pro plan

✅ Should redirect to /signup?returnUrl=/pricing?subscribe=pro

Complete signup form

✅ Should create user account

✅ Should redirect back to pricing page

Click "Start Free Trial" on Pro plan (now logged in)

✅ Should open Stripe Checkout

Phase 2: Stripe Test Mode Setup
Enable Stripe Test Mode in Dashboard

Use test cards:

Successful: 4242 4242 4242 4242

Requires auth: 4000 0025 0000 3155

Decline: 4000 0000 0000 9995

Phase 3: Webhook Testing
bash
# Install Stripe CLI for local testing
stripe login
stripe listen --forward-to localhost:3000/api/webhooks

# For production testing, set up webhook endpoint in Stripe Dashboard
# Point to: https://yourapp.vercel.app/api/webhooks
Phase 4: Complete Subscription Flow
Start checkout with test card 4242 4242 4242 4242

Complete payment in Stripe Checkout

Verify webhook processing:

Check Stripe CLI logs

Check database: SELECT * FROM user_subscriptions WHERE status = 'active'

Verify redirect to success page

Phase 5: Customer Portal Testing
Navigate to user dashboard

Click "Manage Subscription"

Verify Stripe Customer Portal opens

Test cancellation flow

Cancel subscription

Check database updates: status = 'canceled'

4. API Endpoint Testing
Test Plans API
bash
curl http://localhost:3000/api/plans
# Should return JSON with your subscription plans
Test Checkout Session API
```bash
curl -X POST http://localhost:3000/api/create-checkout-session \
  -H "Content-Type: application/json" \
  -d '{
    "priceId": "price_1ABC...",
    "userId": "test-user-id",
    "userEmail": "test@example.com"
  }'
  ```
# Should return { "sessionId": "cs_test_..." }
Test Webhook Manually
bash
# Use Stripe CLI to trigger test events
stripe trigger checkout.session.completed
stripe trigger customer.subscription.updated
stripe trigger customer.subscription.deleted
5. Database State Verification
After each test, check these tables:

sql
-- Active subscriptions
```sql
SELECT us.*, sp.name as plan_name 
FROM user_subscriptions us
LEFT JOIN subscription_plans sp ON us.price_id = sp.stripe_price_id
WHERE us.status = 'active';
```
-- Webhook events processed
```sql
SELECT * FROM user_subscriptions ORDER BY updated_at DESC LIMIT 5;
```
-- Usage tracking (if implemented)
```sql
SELECT * FROM user_usage ORDER BY created_at DESC LIMIT 5;
SELECT * FROM monthly_usage ORDER BY month DESC LIMIT 5;
```
6. Error Scenario Testing
Test Failure Cases:
Invalid price ID - should show error

Expired card - use 4000 0000 0000 0069

Insufficient funds - use 4000 0000 0000 9995

Network issues - disconnect during checkout

Duplicate subscription - try subscribing twice

Test Edge Cases:
User without Stripe customer ID trying to subscribe

Webhook signature verification failure

Database connection issues during webhook processing

7. Performance Testing
Multiple simultaneous subscriptions

Webhook load handling

Database query performance with many subscriptions

8. Production Verification
Before going live:

Switch to live Stripe keys

Test with real payment method ($1 test)

Verify live webhooks in Stripe Dashboard

Test customer support flow - refunds, upgrades, downgrades

9. Monitoring Setup
Add these checks:

typescript
// Add to your webhook handler for debugging
console.log('Webhook received:', event.type);
console.log('Webhook data:', event.data.object);

// Add error tracking
```tsx
try {
  // your webhook logic
} catch (error) {
  console.error('Webhook processing failed:', error);
  // Send to error tracking service
}
```
10. Final Smoke Test
Complete happy path:

Anonymous user → Sign up → Stripe Checkout → Success

Login → Manage subscription → Customer Portal → Cancel

Check all database tables updated correctly

🚨 Common Issues to Watch For:
Webhook secrets mismatch

Database foreign key constraints

Stripe customer ID not saved

Price ID mismatches between DB and Stripe

Timezone issues with subscription periods

📋 Testing Tools:
Stripe CLI for local webhook testing

Stripe Dashboard for monitoring events

pgAdmin/TablePlus for database inspection

Browser DevTools for API call debugging

Start with Phase 1 and work through systematically. Let me know which step you encounter issues with, and I'll help troubleshoot!