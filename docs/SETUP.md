# The Scout — Setup Guide

## Prerequisites

- Mac (M1/M2/M3 or Intel)
- Google Account
- RapidAPI Account (free)
- Groq Account (free)
- Twilio Account (free sandbox)

---

## Step 1 — Install n8n on Mac

Open Terminal and run:

```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH (Apple Silicon Macs)
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Install Node.js
brew install node

# Install n8n
npm install -g n8n

# Start n8n
n8n start
```

Open `http://localhost:5678` in your browser.

---

## Step 2 — Get API Keys

### JSearch API (Job Discovery)
1. Go to rapidapi.com
2. Sign up free
3. Search "JSearch"
4. Subscribe to Basic plan (free — 100 requests/day)
5. Copy your X-RapidAPI-Key

### Groq API (AI Messages)
1. Go to console.groq.com
2. Sign up free
3. Go to API Keys → Create API Key
4. Copy the key

### Google OAuth (Gmail + Sheets)
1. Go to console.cloud.google.com
2. Create new project → "The Scout"
3. Enable APIs: Gmail API, Google Sheets API, Google Drive API
4. Create OAuth 2.0 credentials (Web Application)
5. Add redirect URI: `http://localhost:5678/rest/oauth2-credential/callback`
6. Copy Client ID and Client Secret
7. Add your email as test user in OAuth Consent Screen

### Twilio WhatsApp (Reports)
1. Go to twilio.com
2. Sign up free
3. Go to Console → Messaging → WhatsApp Sandbox
4. Send "join [sandbox-word]" to +1 415 523 8886 from your WhatsApp
5. Copy Account SID and Auth Token

---

## Step 3 — Set Up Google Sheet

1. Go to sheets.google.com
2. Create new sheet named "The Scout — Job Tracker"
3. Add these headers in Row 1:

| A | B | C | D | E | F | G | H | I | J |
|---|---|---|---|---|---|---|---|---|---|
| Date | Company | Job Title | Job URL | Poster Name | Contact Found | Outreach Method | Message Sent | Status | Notes |

4. Create a second sheet tab named "Blacklist"
5. Add header in Row 1: "Company Name"
6. Add any companies you don't want to apply to

---

## Step 4 — Import n8n Workflow

1. Open n8n at `http://localhost:5678`
2. Click "New Workflow"
3. Click the three dots menu (...)
4. Click "Import from File"
5. Select `n8n/workflow.json`

---

## Step 5 — Configure Credentials in n8n

### JSearch
In the "Search LinkedIn Jobs" node:
- Header: `X-RapidAPI-Key` → your key
- Header: `X-RapidAPI-Host` → `jsearch.p.rapidapi.com`

### Groq
In all Groq nodes:
- Header: `Authorization` → `Bearer YOUR_GROQ_KEY`
- Header: `Content-Type` → `application/json`

### Gmail
In Gmail nodes:
- Click "Create Credential"
- Enter Client ID and Client Secret
- Click "Sign in with Google"

### Google Sheets
In Google Sheets nodes:
- Use same Google credential as Gmail
- Set Spreadsheet URL to your sheet URL

### Twilio
In "Send WhatsApp Report" node:
- Account SID → your Twilio SID
- Auth Token → your Twilio token

---

## Step 6 — Set Your Schedule

1. Click "Schedule Trigger" node
2. Set your preferred time (21:00 = 9 PM IST)
3. Set timezone to Asia/Kolkata

---

## Step 7 — Activate The Scout

1. Click "Save" at top right
2. Click "Publish" button
3. Toggle to "Active"

The Scout will now run automatically every day! 🦅

---

## Step 8 — Set Up Dashboard

1. Go to script.google.com
2. Create new project named "Scout API"
3. Paste contents of `scripts/apps-script.js`
4. Replace `YOUR_GOOGLE_SHEET_ID` with your actual Sheet ID
5. Click Deploy → New Deployment → Web App
6. Set Execute as: Me, Who has access: Anyone
7. Copy the Web App URL
8. Open `dashboard/index.html`
9. Replace `YOUR_APPS_SCRIPT_URL` with your Web App URL

---

## Keeping The Scout Running

Since n8n is self-hosted on your Mac, it only runs when your Mac is on and Terminal is open.

To keep it running in background:
```bash
n8n start &
```

For 24/7 running, consider migrating to n8n Cloud (free tier available).
