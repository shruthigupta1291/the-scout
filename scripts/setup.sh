#!/bin/bash

# ==========================================
# THE SCOUT — Mac Setup Script
# ==========================================
# Run this once to set up everything on Mac
# Usage: chmod +x setup.sh && ./setup.sh
# ==========================================

echo "🦅 Setting up The Scout..."
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
else
  echo "✅ Homebrew already installed"
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
  echo "📦 Installing Node.js..."
  brew install node
else
  echo "✅ Node.js already installed ($(node --version))"
fi

# Check if n8n is installed
if ! command -v n8n &> /dev/null; then
  echo "📦 Installing n8n..."
  npm install -g n8n
else
  echo "✅ n8n already installed"
fi

# Copy .env.example to .env if not exists
if [ ! -f .env ]; then
  cp .env.example .env
  echo ""
  echo "⚠️  Created .env file — please fill in your API keys!"
  echo "    Open .env and add your keys before running n8n"
else
  echo "✅ .env file already exists"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Fill in your API keys in .env"
echo "2. Run: n8n start"
echo "3. Open: http://localhost:5678"
echo "4. Import: n8n/workflow.json"
echo ""
echo "🦅 The Scout is ready to hunt!"
