-- 00_schema.sql

-- Generic updated_at trigger
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- users
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  role VARCHAR(50) NOT NULL DEFAULT 'user',
  phone TEXT,
  subscribed BOOLEAN NOT NULL DEFAULT FALSE,
  image_url TEXT NOT NULL DEFAULT '/users/default-user.png',
  location TEXT,
  join_date DATE,
  last_login TIMESTAMP,
  password_last_changed DATE,
  reset_token TEXT,
  reset_token_expiry DATE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
CREATE TRIGGER trg_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW EXECUTE PROCEDURE set_updated_at();

-- property_leads (each property belongs to a user)
CREATE TABLE IF NOT EXISTS property_leads (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  city TEXT NOT NULL,
  state TEXT NOT NULL,
  zip_code TEXT NOT NULL,
  country TEXT NOT NULL DEFAULT 'USA',
  image_url TEXT NOT NULL DEFAULT '/properties/default-property.png',
  client_type TEXT NOT NULL, -- buyer | investor | owner
  property_type TEXT NOT NULL, -- single family | condo | etc.
  property_size INTEGER,       -- sq ft
  year_built INTEGER,
  bedrooms INTEGER,
  bathrooms NUMERIC(3,1),
  parking_spaces INTEGER,
  amenities TEXT,
  notes TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_property_leads_user_id ON property_leads(user_id);
CREATE TRIGGER trg_property_leads_updated_at
BEFORE UPDATE ON property_leads
FOR EACH ROW EXECUTE PROCEDURE set_updated_at();

-- property_financial_inputs (one row per property)
CREATE TABLE IF NOT EXISTS property_financial_inputs (
  id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES property_leads(id) ON DELETE CASCADE,
  asking_price NUMERIC(14,2) NOT NULL,
  market_price NUMERIC(14,2) NOT NULL,
  purchase_price NUMERIC(14,2) NOT NULL,
  down_payment NUMERIC(14,2) NOT NULL,
  loan_amount NUMERIC(14,2) NOT NULL,
  interest_rate NUMERIC(6,4) NOT NULL,     -- decimal e.g., 0.0625
  loan_term_years INTEGER NOT NULL,        -- 20/25/30
  gross_income NUMERIC(14,2) NOT NULL,     -- annual
  expenses NUMERIC(14,2) NOT NULL,         -- annual
  vacancy_rate NUMERIC(14,2) NOT NULL,     -- annual dollar amount
  maintenance_cost NUMERIC(14,2) NOT NULL,
  insurance NUMERIC(14,2) NOT NULL,
  taxes NUMERIC(14,2) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS uq_fin_inputs_property_id ON property_financial_inputs(property_id);
CREATE TRIGGER trg_property_financial_inputs_updated_at
BEFORE UPDATE ON property_financial_inputs
FOR EACH ROW EXECUTE PROCEDURE set_updated_at();

-- property_financials (calculated outputs; can be stored or computed on the fly)
CREATE TABLE IF NOT EXISTS property_financials (
  id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES property_leads(id) ON DELETE CASCADE,
  noi NUMERIC(14,2),
  cap_rate NUMERIC(10,6),
  debt_coverage_ratio NUMERIC(10,6),
  cash_on_cash_return NUMERIC(10,6),
  roi NUMERIC(10,6),
  projected_appreciation_5y NUMERIC(14,2),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX IF NOT EXISTS uq_financials_property_id ON property_financials(property_id);
CREATE TRIGGER trg_property_financials_updated_at
BEFORE UPDATE ON property_financials
FOR EACH ROW EXECUTE PROCEDURE set_updated_at();

-- user_activities (dashboard feed)
CREATE TABLE IF NOT EXISTS user_activities (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  action TEXT NOT NULL,
  details TEXT,
  data_size_gb FLOAT DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_user_activities_user_id ON user_activities(user_id);
CREATE TRIGGER trg_user_activities_updated_at
BEFORE UPDATE ON user_activities
FOR EACH ROW EXECUTE PROCEDURE set_updated_at();


CREATE TABLE IF NOT EXISTS property_scenarios (
id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
property_id UUID NOT NULL REFERENCES property_leads(id) ON DELETE CASCADE,
scenario_name VARCHAR(255) NOT NULL,

/* Financial Inputs */
asking_price NUMERIC,
market_price NUMERIC,
purchase_price NUMERIC,
down_payment NUMERIC,
loan_amount NUMERIC,
interest_rate NUMERIC,
loan_term_years INT,
gross_income NUMERIC,
expenses NUMERIC,
vacancy_rate NUMERIC,
maintenance_cost NUMERIC,
insurance NUMERIC,
taxes NUMERIC,

/* Financial Metrics */
noi NUMERIC,
cap_rate NUMERIC,
dcr NUMERIC,
cash_on_cash_return NUMERIC,
roi NUMERIC,
projected_appreciation_5y NUMERIC,

/* Notes */
notes TEXT,

created_at TIMESTAMP DEFAULT NOW(),
updated_at TIMESTAMP DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_property_scenarios_user_id ON property_scenarios(user_id);
CREATE INDEX IF NOT EXISTS idx_property_scenarios_property_id ON property_scenarios(property_id);
CREATE TRIGGER trg_property_scenarios_updated_at
BEFORE UPDATE ON property_scenarios
FOR EACH ROW EXECUTE PROCEDURE set_updated_at();  
