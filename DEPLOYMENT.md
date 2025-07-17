# 🚀 Cloudflare Pages Deployment Guide

This guide provides step-by-step instructions for deploying your Cloud Native Portfolio website to Cloudflare Pages with automated GitHub integration.

## 📋 Prerequisites

Before you begin, ensure you have:

- [ ] **GitHub Account** - [Sign up here](https://github.com/join)
- [ ] **Cloudflare Account** - [Sign up here](https://dash.cloudflare.com/sign-up)
- [ ] **Git** installed on your local machine
- [ ] **Node.js 18+** installed (for Astro version)
- [ ] **Basic knowledge** of Git and GitHub

## 🔧 Step 1: GitHub Repository Setup

### 1.1 Create a New Repository

1. Go to [GitHub](https://github.com) and click **"New repository"**
2. Repository settings:
   - **Repository name**: `cloudnative-portfolio`
   - **Description**: `Professional Cloud Native Engineer Portfolio`
   - **Visibility**: Public (recommended for free Cloudflare Pages)
   - **Initialize with**: README (optional)

### 1.2 Clone and Push Your Code

```bash
# Clone your new repository
git clone https://github.com/YOUR_USERNAME/cloudnative-portfolio.git
cd cloudnative-portfolio

# Copy your portfolio files into the repository
cp -r /path/to/your/portfolio/* .

# Add and commit files
git add .
git commit -m "Initial commit: Cloud Native Portfolio website"
git push origin main
```

### 1.3 Repository Structure

Your repository should look like this:

```
cloudnative-portfolio/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions workflow
├── assets/
│   └── images/
│       └── profile.jpg         # Your profile image
├── index.html                  # Main HTML file
├── package.json               # Node.js dependencies
├── wrangler.toml              # Cloudflare configuration
├── Makefile                   # Build and deployment scripts
├── README.md                  # Project documentation
└── DEPLOYMENT.md              # This file
```

## ☁️ Step 2: Cloudflare Pages Setup

### 2.1 Access Cloudflare Pages

1. Log into [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Click **"Pages"** in the left sidebar
3. Click **"Create a project"**
4. Select **"Connect to Git"**

### 2.2 Connect GitHub Repository

1. Click **"Connect GitHub"**
2. Authorize Cloudflare to access your GitHub account
3. Select your repository: `YOUR_USERNAME/cloudnative-portfolio`
4. Click **"Begin setup"**

### 2.3 Configure Build Settings

#### For HTML Version:
- **Project name**: `cloudnative-portfolio`
- **Production branch**: `main`
- **Build command**: `make build` or leave empty
- **Build output directory**: `dist` or `/` (root)

#### For Astro Version:
- **Project name**: `cloudnative-portfolio-astro`
- **Production branch**: `main`
- **Build command**: `npm run build`
- **Build output directory**: `dist`

### 2.4 Environment Variables

In the Cloudflare Pages dashboard:

1. Go to **Settings** → **Environment variables**
2. Add the following variables:

```
NODE_VERSION=18
PYTHON_VERSION=3.11
```

### 2.5 Deploy

1. Click **"Save and Deploy"**
2. Wait for the initial deployment to complete
3. Your site will be available at: `https://cloudnative-portfolio.pages.dev`

## 🤖 Step 3: GitHub Actions Setup

### 3.1 Repository Secrets

Add these secrets to your GitHub repository:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. Click **"New repository secret"**
3. Add the following secrets:

```
CLOUDFLARE_API_TOKEN=your_cloudflare_api_token_here
CLOUDFLARE_ACCOUNT_ID=your_cloudflare_account_id_here
```

### 3.2 Get Cloudflare API Token

1. Go to [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens)
2. Click **"Create Token"**
3. Use **"Custom token"** template
4. Configure permissions:
   - **Account**: `Cloudflare Pages:Edit`
   - **Zone**: `Zone:Read` (if using custom domain)
   - **Account Resources**: `Include - Your Account`
5. Copy the token and add it to GitHub secrets

### 3.3 Get Account ID

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Select your account
3. Find **Account ID** in the right sidebar
4. Copy and add to GitHub secrets

## 🔄 Step 4: Automated Deployment Workflow

### 4.1 Workflow Triggers

The GitHub Actions workflow will trigger on:
- Push to `main` branch
- Pull request to `main` branch
- Manual trigger from GitHub Actions tab

### 4.2 Deployment Process

1. **Code Push**: You push changes to GitHub
2. **GitHub Actions**: Workflow starts automatically
3. **Build**: Project is built (if needed)
4. **Deploy**: Built files are deployed to Cloudflare Pages
5. **Notification**: You receive deployment status

### 4.3 Check Deployment Status

1. Go to **Actions** tab in your GitHub repository
2. Click on the latest workflow run
3. Monitor the deployment progress
4. Check the deployment URL in the logs

## 🌐 Step 5: Custom Domain Setup (Optional)

### 5.1 Add Custom Domain

1. In Cloudflare Pages dashboard, go to **Custom domains**
2. Click **"Set up a custom domain"**
3. Enter your domain (e.g., `portfolio.yourdomain.com`)
4. Follow the DNS setup instructions

### 5.2 DNS Configuration

Add these DNS records to your domain:

```
Type: CNAME
Name: portfolio (or your subdomain)
Value: cloudnative-portfolio.pages.dev
```

### 5.3 SSL Certificate

Cloudflare automatically provisions SSL certificates for your custom domain.

## 🛠️ Step 6: Customization Workflow

### 6.1 For Training/Multiple Users

Use the Makefile for easy customization:

```bash
# Customize with your information
make customize NAME="Your Name" EMAIL="your@email.com" PROFILE_IMAGE="path/to/your/photo.jpg"

# Build and test locally
make dev

# Commit and push changes
git add .
git commit -m "Customize portfolio with personal information"
git push origin main
```

### 6.2 Using the Training Setup

```bash
# Interactive setup
make training-setup

# This will prompt you for:
# - Full name
# - Professional title
# - Email address
# - Phone number
# - Location
# - GitHub username
# - Profile image path
```

## 🎯 Step 7: Astro Version Deployment

### 7.1 Setup Astro Version

```bash
# Run the Astro setup script
chmod +x setup-astro.sh
./setup-astro.sh
```

### 7.2 Deploy Astro Version

```bash
# Navigate to Astro directory
cd astro-portfolio

# Install dependencies
npm install

# Build and deploy
npm run build
./deploy-astro.sh
```

### 7.3 Astro-specific Configuration

Update your Cloudflare Pages project with:
- **Build command**: `npm run build`
- **Build output directory**: `dist`
- **Node.js version**: `18`

## 🔍 Step 8: Monitoring and Maintenance

### 8.1 Analytics

Enable analytics in Cloudflare Pages:
1. Go to **Analytics** tab
2. Enable **Web Analytics**
3. Add the analytics script to your HTML

### 8.2 Performance Monitoring

Monitor your site's performance:
- **Core Web Vitals**: Check in Cloudflare Analytics
- **Load Times**: Use Cloudflare Speed tab
- **Uptime**: Monitor via Cloudflare dashboard

### 8.3 Updates and Maintenance

Regular maintenance tasks:
- Update dependencies: `npm update`
- Update content: Edit HTML/Astro files
- Monitor deployment logs
- Check for security updates

## 🚨 Troubleshooting

### Common Issues and Solutions

#### 1. Build Failures

**Problem**: Build fails with "Command not found"
**Solution**: 
```bash
# Check your build command in Cloudflare Pages
# For HTML version: leave empty or use "make build"
# For Astro version: use "npm run build"
```

#### 2. Images Not Loading

**Problem**: Profile images show as broken
**Solution**:
```bash
# Ensure images are in the correct directory
mkdir -p assets/images
cp your-profile-image.jpg assets/images/profile.jpg

# Update HTML to reference correct path
# Use: assets/images/profile.jpg
```

#### 3. Deployment Not Triggering

**Problem**: Changes pushed but deployment doesn't start
**Solution**:
- Check GitHub Actions tab for errors
- Verify CLOUDFLARE_API_TOKEN is correct
- Ensure repository secrets are set
- Check branch name (should be `main`)

#### 4. Custom Domain Issues

**Problem**: Custom domain not working
**Solution**:
- Verify DNS records are correctly set
- Wait for DNS propagation (up to 24 hours)
- Check SSL certificate status
- Ensure domain is verified in Cloudflare

#### 5. Node.js Version Errors

**Problem**: Build fails with Node.js version error
**Solution**:
```bash
# Set Node.js version in environment variables
NODE_VERSION=18

# Or update package.json engines
"engines": {
  "node": ">=18.0.0"
}
```

## 📊 Performance Optimization

### 8.1 Image Optimization

```bash
# Optimize images before deployment
# Use WebP format for better compression
# Recommended sizes:
# - Profile image: 400x400px
# - Project images: 800x600px
```

### 8.2 Caching Strategy

Cloudflare Pages automatically handles caching:
- HTML files: 5 minutes
- Assets (CSS, JS, images): 1 year
- Custom cache headers in `wrangler.toml`

### 8.3 Bundle Size Optimization

For Astro version:
```bash
# Analyze bundle size
npm run build -- --analyze

# Optimize dependencies
npm audit
npm prune
```

## 🔐 Security Best Practices

### 9.1 Repository Security

- Use repository secrets for sensitive data
- Enable branch protection rules
- Review pull requests before merging
- Keep dependencies updated

### 9.2 Cloudflare Security

- Enable security headers (configured in `wrangler.toml`)
- Use HTTPS everywhere
- Monitor security tab in Cloudflare dashboard
- Set up rate limiting if needed

## 📈 Going Live Checklist

Before making your portfolio public:

- [ ] All personal information is updated
- [ ] Profile image is added and optimized
- [ ] All links are working
- [ ] Contact form is tested
- [ ] Site is mobile-responsive
- [ ] SSL certificate is active
- [ ] Custom domain is configured (if applicable)
- [ ] Analytics are enabled
- [ ] Social media links are updated
- [ ] Resume download link is working
- [ ] All project links are valid

## 🎉 Success!

Your Cloud Native Portfolio is now live on Cloudflare Pages with automated deployment from GitHub!

**Your site is available at**:
- Default URL: `https://cloudnative-portfolio.pages.dev`
- Custom domain: `https://your-custom-domain.com`

## 📞 Support

If you encounter issues:

1. Check the [Cloudflare Pages documentation](https://developers.cloudflare.com/pages/)
2. Review [GitHub Actions documentation](https://docs.github.com/en/actions)
3. Check the troubleshooting section above
4. Create an issue in the repository

## 🔄 Next Steps

Consider these enhancements:
- Add a blog section
- Implement contact form backend
- Add more projects
- Enable comments system
- Add testimonials section
- Implement dark mode
- Add language switcher
- Create project detail pages

---

**Happy Deploying! 🚀**

*Your portfolio is now ready to showcase your cloud native engineering expertise to the world!*