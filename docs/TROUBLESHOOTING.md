# The Scout — Troubleshooting Guide

## Common Errors and Fixes

---

### Error: "Forbidden" on Search LinkedIn Jobs node

**Cause:** JSearch API key is wrong or subscription expired

**Fix:**
1. Go to rapidapi.com → JSearch
2. Check your subscription is active
3. Copy fresh API key
4. Update X-RapidAPI-Key header in node

---

### Error: "Too many requests" on Groq nodes

**Cause:** Hitting Groq free tier rate limit (30 RPM)

**Fix:**
1. Click "Rate Limit Delay" wait node
2. Increase wait time to 60 seconds
3. Reduce batch size in "Split Jobs" to 5

Or switch to Google Gemini API (more generous free tier):
- URL: `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=YOUR_KEY`

---

### Error: "Client authentication failed" on Google

**Cause:** OAuth credentials are wrong

**Fix:**
1. Go to console.cloud.google.com
2. APIs & Services → Credentials
3. Edit your OAuth client
4. Generate new client secret
5. Update in n8n credential

---

### Error: "Gmail API not enabled"

**Cause:** Gmail API not enabled in Google Cloud

**Fix:**
1. Go to console.cloud.google.com
2. APIs & Services → Enable APIs
3. Search "Gmail API" → Enable

---

### Error: "Redirect URI mismatch"

**Cause:** n8n callback URL not added to Google OAuth

**Fix:**
1. Go to console.cloud.google.com
2. APIs & Services → Credentials
3. Edit OAuth client
4. Add URI: `http://localhost:5678/rest/oauth2-credential/callback`

---

### Workflow not running at scheduled time

**Cause:** n8n is not running when schedule triggers

**Fix:**
1. Make sure Terminal is open
2. Make sure n8n is running (`n8n start`)
3. Make sure Mac is not in sleep mode
4. Check System Settings → Battery → disable auto sleep

To run n8n in background:
```bash
n8n start &
```

---

### Duplicate jobs being applied to

**Cause:** Google Sheets duplicate check not working

**Fix:**
1. Check "Duplicate Check" node
2. Make sure Filter is set to Column D (Job URL)
3. Make sure Google Sheets credential is connected

---

### WhatsApp report not received

**Cause:** Twilio sandbox not activated or wrong number

**Fix:**
1. Go to twilio.com → Console → WhatsApp Sandbox
2. Send "join [sandbox-word]" to +1 415 523 8886 from your WhatsApp
3. Check "To" number format: `whatsapp:+91YOURNUMBER`

---

### Dashboard not loading data

**Cause:** Apps Script not deployed correctly or CORS issue

**Fix:**
1. Go to script.google.com
2. Open Scout API project
3. Deploy → New Deployment → Web App
4. Set Who has access: Anyone
5. Copy new URL and update dashboard

---

## Getting Help

If you're stuck, check:
1. n8n Executions tab for error details
2. n8n community forum: community.n8n.io
3. Groq docs: console.groq.com/docs
4. JSearch docs: rapidapi.com/letscrape-6bRBa3QguO5/api/jsearch
