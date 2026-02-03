
🔐 Two-Factor Authentication (2FA) Implementation
📋 Overview
A complete TOTP-based 2FA system built with Next.js 15, PostgreSQL, and TypeScript. Users can secure their accounts with Google Authenticator/Microsoft Authenticator/Authy.

🏗️ Architecture
text
src/
├── app/
│   ├── dashboard/2fa/          # 2FA Settings Page
│   │   ├── page.tsx            # Server Component
│   │   └── TwoFAForm.tsx       # Client Component
│   ├── api/user/2fa/           # 2FA API Endpoints
│   │   └── route.ts
│   └── lib/auth/2fa/           # Core 2FA Logic
│       ├── totp-generator.ts   # Secret generation
│       ├── qr-generator.ts     # QR code creation
│       ├── totp-verifier.ts    # Code verification
│       ├── backup-codes.ts     # Recovery codes
│       ├── crypto-utils.ts     # Security utilities
│       └── db-operations.ts    # Database queries
📊 Database Schema
sql
-- Users table additions for 2FA
ALTER TABLE users ADD COLUMN two_factor_secret TEXT;
ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT false;
ALTER TABLE users ADD COLUMN two_factor_backup_codes TEXT[] DEFAULT '{}';
ALTER TABLE users ADD COLUMN two_factor_verified_at TIMESTAMP;
ALTER TABLE users ADD COLUMN two_factor_setup_at TIMESTAMP;
ALTER TABLE users ADD COLUMN two_factor_recovery_used BOOLEAN DEFAULT false;
🚀 Installation & Setup
1. Install Dependencies
bash
npm install otplib qrcode
npm install --save-dev @types/qrcode
2. Add Database Columns
Run the SQL migration above to add 2FA columns to your users table.

3. Environment Variables
Ensure your .env.local has:

env
# Optional: Add salt for backup code hashing
BACKUP_CODE_SALT=your-secure-salt-here
🔧 API Endpoints
GET /api/user/2fa
Returns: Current 2FA status

json
{
  "two_factor_enabled": false,
  "hasSecret": true,
  "setupIncomplete": true
}
POST /api/user/2fa
Body:

json
{
  "two_factor_enabled": true,  // or false to disable
  "token": "123456"            // optional for verification
}
Responses:

Setup Mode: {"setupMode": true, "qrCodeUrl": "data:image/..."}

Success: {"two_factor_enabled": true, "backupCodes": [...]}

Error: {"error": "Invalid verification code"}

📱 User Flow
1. First-Time Setup
text
User clicks "Enable 2FA" → Generates secret → Shows QR code → 
User scans with authenticator app → Enters 6-digit code → 
2FA enabled + backup codes shown
2. Incomplete Setup Resume
text
User has secret but not enabled → Auto-detects incomplete setup → 
Shows verification input (no QR) → User enters code → 2FA enabled
3. Disable 2FA
text
User clicks "Disable 2FA" → Confirms → Secret removed → 2FA disabled
🛡️ Security Features
🔐 TOTP Implementation
Algorithm: Time-based One-Time Password (TOTP)

Secret Length: 32-character base32

Token Validity: 30-second windows

Verification Window: ±1 time step for clock drift

🔑 Backup Codes
Quantity: 10 one-time-use codes

Format: 10-character hexadecimal (e.g., A1B2C3D4E5)

Storage: SHA-256 hashed in database

Usage: Single-use, auto-removed after use

🛡️ Additional Protections
Rate limiting: 5 attempts per 15 minutes

Input validation: 6-digit numeric codes only

Session management: Automatic status refresh

Secure storage: Secrets never exposed in responses

💻 Frontend Components
TwoFAForm.tsx
Client component handling:

2FA status display

QR code rendering

Verification input

Backup codes display

Enable/disable toggles

Integration Points
Profile Page: Dynamic 2FA status display

Security Tab: Quick access to 2FA settings

Login Flow: (Future) 2FA verification during login

🧪 Testing
Component Tests
bash
# Test secret generation
npx tsx test-totp-secret.ts

# Test QR generation  
npx tsx test-qr-generator.ts

# Test verification
npx tsx test-verification-real.ts

# Test backup codes
npx tsx test-backup-codes.ts
Manual Testing Flow
Enable 2FA and scan QR with Google Authenticator

Verify with 6-digit code

Save backup codes

Test disable/re-enable flow

Test incomplete setup resume

🚨 Error Handling
Common Issues & Solutions
Error	Cause	Solution
Unexpected end of JSON	GET request trying to parse body	Remove request.json() from GET
500 Internal Server Error	Database/auth issues	Check server logs, verify auth
Invalid verification code	Wrong/timeout token	Ensure correct time sync
QR code not showing	Image generation failed	Check qrcode library import
Debug Logging
Enable detailed logs in development:

typescript
console.log('2FA Status Data:', data);
console.log('User 2FA state:', {
  hasSecret: !!user.two_factor_secret,
  isEnabled: user.two_factor_enabled
});
🔄 Maintenance
Database Cleanup
sql
-- Find users with incomplete 2FA setups
SELECT email, two_factor_setup_at 
FROM users 
WHERE two_factor_secret IS NOT NULL 
AND two_factor_enabled = false 
AND two_factor_setup_at < NOW() - INTERVAL '7 days';

-- Cleanup old incomplete setups
UPDATE users 
SET two_factor_secret = NULL 
WHERE two_factor_enabled = false 
AND two_factor_setup_at < NOW() - INTERVAL '30 days';
Backup Code Management
Codes expire after 1 year

Users can regenerate codes via security settings

Used codes are immediately removed from database

📈 Future Enhancements
Phase 2 (Optional)
Email fallback verification

SMS 2FA option

Recovery email/phone setup

Trusted device remember option

Login-time 2FA enforcement

Phase 3 (Enterprise)
WebAuthn/Passkey support

Hardware token compatibility (YubiKey)

Admin 2FA enforcement policies

Audit logging for all 2FA events

Compliance reporting (SOC2, HIPAA)

🐛 Troubleshooting
QR Code Issues
Not scanning? Ensure proper contrast (white background)

Multiple QR codes? User might have old secret - clear and regenerate

Wrong app name? Verify issuer in QR URI: otpauth://totp/AppName:...

Verification Issues
Time sync: Ensure server and client times are synchronized (±2 minutes)

Wrong secret: User might have scanned wrong QR - reset and start fresh

Token reuse: Each token valid for 30 seconds only

📚 Dependencies
Package	Version	Purpose
otplib	^13.1.1	TOTP generation/verification
qrcode	^1.5.4	QR code generation
@types/qrcode	^1.5.5	TypeScript definitions
🔗 Related Resources
RFC 6238: TOTP Specification

Google Authenticator

Authy 2FA Guide

Next.js Authentication

⚠️ Security Note: Always test in staging before production deployment. Monitor logs for failed verification attempts and consider implementing additional security measures based on your threat model.