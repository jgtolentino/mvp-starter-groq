# JTI Analytics Dashboard

Real-time market intelligence platform for Japan Tobacco International Philippines.

## Overview

This dashboard provides comprehensive analytics for JTI's operations in the Philippine market, including:
- Real-time sales tracking
- Competitive intelligence
- Geographic performance analysis
- Consumer behavior insights
- Brand switching patterns

## Features

### 📊 Analytics
- **Sales Dashboard**: Real-time sales metrics and trends
- **Geographic Analysis**: Interactive maps showing regional performance
- **Product Performance**: SKU-level analytics with market share tracking
- **Consumer Insights**: Purchase patterns and brand loyalty analysis

### 🎯 JTI-Specific Features
- Winston, Mevius, Camel, Mighty brand tracking
- Competitor analysis (Marlboro, Fortune)
- Sari-sari store performance metrics
- Sin tax impact modeling

### 🔧 Technical Features
- React 18 + TypeScript
- Vite for fast development
- Tailwind CSS for styling
- Supabase for real-time data
- AI-powered insights (OpenAI/Anthropic)

## Quick Start

### Prerequisites
- Node.js 18+
- npm or yarn
- Supabase account

### Installation

1. Clone and install dependencies:
\`\`\`bash
npm install
\`\`\`

2. Set up environment variables:
\`\`\`bash
cp .env.example .env.local
# Edit .env.local with your Supabase credentials
\`\`\`

3. Run development server:
\`\`\`bash
npm run dev
\`\`\`

## Deployment

### Vercel (Recommended)
1. Connect GitHub repository to Vercel
2. Set environment variables in Vercel dashboard
3. Deploy with automatic CI/CD

### Manual Deployment
\`\`\`bash
npm run build
# Deploy dist/ folder to your hosting service
\`\`\`

## Project Structure

\`\`\`
src/
├── components/     # Reusable UI components
├── pages/         # Route pages
├── services/      # API and data services
├── hooks/         # Custom React hooks
├── utils/         # Utility functions
├── lib/           # External library configs
└── config/        # App configuration

data/
├── jti-actual-skus-philippines.json
└── jti-sample-data.json

supabase/
└── migrations/    # Database schema
\`\`\`

## Security

- All API keys should be kept in environment variables
- Row Level Security (RLS) enabled on all tables
- Authentication required for write operations

## Support

For issues or questions, contact the TBWA Analytics team.

---

Built with ❤️ by TBWA Analytics for JTI Philippines
