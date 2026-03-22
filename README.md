# 🦅 The Scout — PM Job Outreach Agent

An automated job outreach agent built on n8n that finds Product Manager roles, extracts HR contact details, sends personalised emails using AI, logs everything to Google Sheets and sends you a daily report on WhatsApp and Email.

Note : This is a PM case study and system design. Built as a personal productivity tool — code shared on request.
---

## What The Scout Does

Every day at your scheduled time, The Scout:

1. Searches for fresh PM job postings on LinkedIn (via JSearch API)
2. Skips duplicate jobs already applied to
3. Scrapes each job posting for HR contact details
4. Uses Groq AI (Llama 3.3) to extract or guess HR email
5. Generates a personalised email for each HR using Groq AI
6. Sends the email automatically via Gmail
7. Logs every outreach to Google Sheets
8. Sends you a WhatsApp + Email daily report

---
## Workflow Structure 

<img width="1378" height="532" alt="Screenshot 2026-03-22 at 1 06 29 PM" src="https://github.com/user-attachments/assets/7ef04dd3-9557-4a88-a17b-00534cdf6640" />

## Architecture

```
⏰ Schedule Trigger (Daily at set time)
        ↓
🔍 Search PM Jobs (JSearch API)
        ↓
🔄 Split into Individual Jobs
        ↓
🛡️ Duplicate Check (Google Sheets)
        ↓
⚡ Is Duplicate? (IF Node)
   ↙              ↘
Skip           📋 Scrape Job Details
                   ↓
               🤖 Groq AI Extracts Contact
                   ↓
               📋 Parse Contact Info
                   ↓
               🔀 Switch (Router)
            ↙        ↓        ↘
      Has Email  Has LinkedIn   Skip
          ↓           ↓
    ⏳ Wait      ⏳ Wait
    (Rate Limit)  (Rate Limit)
          ↓           ↓
    🤖 Generate  🤖 Generate
    Email Msg    LinkedIn Msg
          ↓           ↓
    📧 Send      📝 Log for
    Email        Manual Send
          ↓
    📊 Log to Google Sheets
          ↓
    📋 Build Daily Report
          ↓
    📱 WhatsApp + 📧 Email Report
```

---

## Tech Stack

| Component | Tool | Cost |
|---|---|---|
| Automation | n8n (self-hosted) | Free |
| Job Discovery | JSearch API (RapidAPI) | Free (100/day) |
| AI Messages | Groq API (Llama 3.3 70B) | Free |
| Email Sending | Gmail via Google OAuth | Free |
| Data Storage | Google Sheets | Free |
| WhatsApp Report | Twilio Sandbox | Free |
| Dashboard | Google Apps Script + Claude | Free |

**Total cost: $0/month** ✅

---

## Guardrails Built In

| Guardrail | How |
|---|---|
| Skip duplicate jobs | Check job URL in Google Sheets before applying |
| Rate limit protection | 30-60 second wait between each AI call |
| Only fresh jobs | JSearch filters jobs posted in last 7 days |
| Max daily limit | Split node caps at 20 jobs/day |
| Blacklist companies | Separate Blacklist tab in Google Sheets |
| No repeated messages | Groq generates unique message per company |
| Weekdays only | Schedule set Mon-Fri |

---

## Folder Structure

```
the-scout/
├── README.md                    # This file
├── .env.example                 # Environment variables template
├── n8n/
│   └── workflow.json            # Full n8n workflow export
├── scripts/
│   ├── apps-script.js           # Google Apps Script for dashboard API
│   └── setup.sh                 # One-click Mac setup script
├── dashboard/
│   └── index.html               # Live dashboard connected to Google Sheets
└── docs/
    ├── SETUP.md                 # Step by step setup guide
    ├── GUARDRAILS.md            # All guardrails explained
    └── TROUBLESHOOTING.md       # Common errors and fixes
```

---

## Quick Start

### Prerequisites
- Mac with Homebrew installed
- Google account
- RapidAPI account (free)
- Groq account (free)
- Twilio account (free sandbox)

### Setup

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/the-scout.git
cd the-scout

# Run setup script
chmod +x scripts/setup.sh
./scripts/setup.sh

# Start n8n
n8n start
```

Then open `http://localhost:5678` and import `n8n/workflow.json`

See [docs/SETUP.md](docs/SETUP.md) for full step by step instructions.

---

## Environment Variables

Copy `.env.example` to `.env` and fill in your values:

```bash
cp .env.example .env
```

See `.env.example` for all required variables.

---

## Dashboard

The Scout comes with a live dashboard that connects to your Google Sheets via Google Apps Script.

To set up the dashboard:
1. Deploy `scripts/apps-script.js` as a Google Apps Script Web App
2. Copy the Web App URL
3. Open `dashboard/index.html` and replace `API_URL` with your Web App URL

---

## License

MIT — use freely, modify as needed.

---

Built by Shruthi 🦅
