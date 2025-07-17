# 🎓 Cloud Native Portfolio Training Guide

Welcome to the Cloud Native Portfolio training program! This guide will help you create your own personalized portfolio website using modern cloud technologies and automated deployment workflows.

## 🎯 Training Objectives

By the end of this training, you will:
- Have a professional portfolio website deployed on Cloudflare Pages
- Understand GitHub Actions for automated deployment
- Know how to customize and maintain your portfolio
- Be familiar with cloud-native deployment practices
- Have hands-on experience with modern web development workflows

## 📋 Prerequisites

### Required Knowledge
- Basic understanding of Git and GitHub
- Basic HTML/CSS knowledge (helpful but not required)
- Command line familiarity
- Text editor usage

### Required Tools
- [ ] **Git** - [Download here](https://git-scm.com/downloads)
- [ ] **GitHub Account** - [Sign up here](https://github.com/join)
- [ ] **Cloudflare Account** - [Sign up here](https://dash.cloudflare.com/sign-up)
- [ ] **Text Editor** - VS Code, Sublime Text, or similar
- [ ] **Web Browser** - Chrome, Firefox, or Safari
- [ ] **Terminal/Command Prompt** access

### Optional Tools
- [ ] **Node.js 18+** - For Astro version
- [ ] **Python 3.11+** - For local development server
- [ ] **Make** - Usually pre-installed on macOS/Linux

## 🚀 Training Module 1: Initial Setup

### 1.1 Clone the Repository

```bash
# Clone the training repository
git clone https://github.com/your-instructor/cloudnative-portfolio.git
cd cloudnative-portfolio

# Or download as ZIP and extract
```

### 1.2 Understand the Project Structure

```
cloudnative-portfolio/
├── .github/workflows/     # GitHub Actions for deployment
├── assets/               # Images and static files
├── index.html           # Main website file
├── Makefile            # Automation scripts
├── package.json        # Node.js configuration
├── wrangler.toml       # Cloudflare configuration
├── README.md           # Project documentation
├── DEPLOYMENT.md       # Deployment guide
└── TRAINING.md         # This training guide
```

### 1.3 Verify Your Environment

```bash
# Check Git installation
git --version

# Check if Make is available
make --version

# Check Python (optional)
python3 --version

# Check Node.js (optional)
node --version
```

## 🎨 Training Module 2: Basic Customization

### 2.1 Using the Interactive Setup

The easiest way to customize your portfolio is using the interactive setup:

```bash
# Run the training setup command
make training-setup
```

This will prompt you for:
- **Full Name**: Your professional name
- **Professional Title**: e.g., "Senior Cloud Engineer"
- **Email**: Your professional email address
- **Phone**: Your contact number (optional)
- **Location**: Your city and country
- **GitHub Username**: Your GitHub username
- **Profile Image**: Path to your profile photo

### 2.2 Adding Your Profile Image

1. **Prepare your image**:
   - Format: JPG, PNG, or WebP
   - Size: 400x400 pixels (square)
   - File size: Under 500KB
   - Professional appearance

2. **Add to project**:
   ```bash
   # Create assets directory
   mkdir -p assets/images
   
   # Copy your image
   cp /path/to/your/profile-photo.jpg assets/images/profile.jpg
   ```

3. **Update during setup**:
   ```bash
   # Use your image during customization
   make customize PROFILE_IMAGE="assets/images/profile.jpg"
   ```

### 2.3 Manual Customization

If you prefer manual editing, update these sections in `index.html`:

#### Personal Information
```html
<!-- Line ~750: Hero section -->
<h1>Your Name Here</h1>
<h2>Your Professional Title</h2>

<!-- Line ~1100: Contact section -->
<span>your.email@example.com</span>
<span>+1 (555) 123-4567</span>
<span>Your City, Country</span>
```

#### Profile Image
```html
<!-- Line ~775: About section -->
<img src="assets/images/profile.jpg" alt="Your Name">
```

#### Page Title
```html
<!-- Line ~6: HTML head -->
<title>Your Name - Cloud Native Engineer Portfolio</title>
```

## 🛠️ Training Module 3: Advanced Customization

### 3.1 Customizing Skills Section

Update your technical skills (lines ~820-950):

```html
<div class="skill-category">
    <h3>Your Technology Category</h3>
    <div class="skill-item">
        <span class="skill-icon">✓</span>
        <span>Your Technology/Certification</span>
    </div>
    <!-- Add more skills -->
</div>
```

**Example categories**:
- Cloud Platforms (AWS, Azure, GCP)
- Container Technologies (Docker, Kubernetes)
- Programming Languages (Python, Go, JavaScript)
- DevOps Tools (Jenkins, GitLab CI, Terraform)
- Monitoring (Prometheus, Grafana, ELK)

### 3.2 Adding Your Projects

Replace the sample projects (lines ~970-1050) with your actual work:

```html
<div class="project-card">
    <div class="project-img">
        <img src="assets/images/project1.jpg" alt="Project Name">
    </div>
    <div class="project-content">
        <h3>Your Project Title</h3>
        <p>Detailed description of your project, technologies used, and outcomes achieved.</p>
        <div class="project-tags">
            <span class="project-tag">Technology 1</span>
            <span class="project-tag">Technology 2</span>
        </div>
        <a href="https://github.com/yourusername/project" class="btn">View Details</a>
    </div>
</div>
```

**Project Ideas**:
- Kubernetes cluster setup
- CI/CD pipeline implementation
- Cloud migration project
- Infrastructure automation
- Security implementation
- Monitoring solution

### 3.3 Updating Work Experience

Modify the timeline section (lines ~1055-1095):

```html
<div class="timeline-item">
    <div class="timeline-dot"></div>
    <div class="timeline-date">2020 - Present</div>
    <div class="timeline-content">
        <h3>Your Job Title</h3>
        <h4>Company Name</h4>
        <ul>
            <li>Key achievement or responsibility</li>
            <li>Quantifiable result (e.g., "Reduced costs by 30%")</li>
            <li>Technologies used</li>
        </ul>
    </div>
</div>
```

## 🔧 Training Module 4: Local Development

### 4.1 Testing Your Changes

```bash
# Start local development server
make dev

# Alternative using Python
python3 -m http.server 8000

# Open in browser
# http://localhost:8000
```

### 4.2 Making and Testing Changes

1. **Edit files** in your text editor
2. **Save changes**
3. **Refresh browser** to see updates
4. **Test on mobile** by resizing browser window

### 4.3 Validating Your Work

```bash
# Check for HTML issues
make validate

# Clean up build files
make clean

# Show current configuration
make show-config
```

## 📁 Training Module 5: GitHub Repository Setup

### 5.1 Create Your Own Repository

```bash
# Method 1: Using GitHub CLI (recommended)
gh repo create your-username/cloudnative-portfolio --public

# Method 2: Using web interface
# Go to github.com and click "New repository"
```

### 5.2 Initialize Git Repository

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: My Cloud Native Portfolio"

# Add remote repository
git remote add origin https://github.com/YOUR_USERNAME/cloudnative-portfolio.git

# Push to GitHub
git push -u origin main
```

### 5.3 Repository Settings

Configure your repository:
1. Go to **Settings** → **Actions** → **General**
2. Enable **"Allow all actions and reusable workflows"**
3. Go to **Settings** → **Pages**
4. Set source to **"GitHub Actions"**

## ☁️ Training Module 6: Cloudflare Pages Deployment

### 6.1 Create Cloudflare Project

1. **Log into Cloudflare Dashboard**
2. **Navigate to Pages** → **Create a project**
3. **Connect to Git** → **Connect GitHub**
4. **Select your repository**
5. **Configure build settings**:
   - Build command: `make build` (or leave empty)
   - Build output directory: `dist` (or `/`)
   - Root directory: `/`

### 6.2 Environment Variables

Set these in Cloudflare Pages:
- `NODE_VERSION`: `18`
- `PYTHON_VERSION`: `3.11`

### 6.3 Custom Domain (Optional)

```bash
# Add custom domain in Cloudflare Pages
# Example: portfolio.yourdomain.com
```

## 🤖 Training Module 7: Automated Deployment

### 7.1 GitHub Secrets Setup

Add these secrets to your GitHub repository:

1. **CLOUDFLARE_API_TOKEN**:
   - Go to Cloudflare → **My Profile** → **API Tokens**
   - Create token with **Cloudflare Pages:Edit** permission

2. **CLOUDFLARE_ACCOUNT_ID**:
   - Found in Cloudflare Dashboard sidebar

### 7.2 Understanding the Workflow

The `.github/workflows/deploy.yml` file:
- Triggers on push to `main` branch
- Builds your site (if needed)
- Deploys to Cloudflare Pages
- Provides deployment status

### 7.3 Making Your First Deployment

```bash
# Make a change to your portfolio
# Edit index.html or add new content

# Commit and push
git add .
git commit -m "Update portfolio with my information"
git push origin main

# Check GitHub Actions tab for deployment status
```

## 🔍 Training Module 8: Testing and Validation

### 8.1 Pre-Deployment Checklist

```bash
# Use the built-in checklist
make show-config

# Verify all sections are updated:
# - Personal information
# - Profile image
# - Skills and technologies
# - Projects
# - Work experience
# - Contact information
```

### 8.2 Testing Across Devices

Test your portfolio on:
- [ ] Desktop browser (Chrome, Firefox, Safari)
- [ ] Mobile browser (responsive design)
- [ ] Different screen sizes
- [ ] Slow internet connection

### 8.3 Performance Testing

```bash
# Check site performance
# Use browser developer tools
# Test loading speed
# Verify all images load correctly
```

## 🎯 Training Module 9: Best Practices

### 9.1 Content Guidelines

**Professional Information**:
- Use professional email address
- Keep phone number current
- Include relevant certifications
- Use action verbs in descriptions

**Technical Skills**:
- Focus on cloud-native technologies
- Include certifications and levels
- Group related technologies
- Update regularly

**Projects**:
- Include 3-5 best projects
- Quantify achievements
- Link to GitHub repositories
- Use professional screenshots

### 9.2 Image Optimization

```bash
# Optimize images before adding
# Recommended tools:
# - ImageOptim (macOS)
# - TinyPNG (web)
# - GIMP (cross-platform)

# Image specifications:
# - Profile: 400x400px, <500KB
# - Projects: 800x600px, <1MB
# - Format: JPG or WebP
```

### 9.3 SEO and Accessibility

- Use descriptive alt text for images
- Include relevant keywords in descriptions
- Ensure proper heading structure
- Test with screen readers
- Maintain good color contrast

## 🚨 Training Module 10: Troubleshooting

### 10.1 Common Issues

**Make Command Not Found**:
```bash
# On macOS: Install Xcode Command Line Tools
xcode-select --install

# On Windows: Use Git Bash or WSL
# Or run commands manually
```

**Git Push Rejected**:
```bash
# Pull latest changes first
git pull origin main

# Then push again
git push origin main
```

**Images Not Displaying**:
```bash
# Check file paths
# Ensure images are in assets/images/
# Use correct case for filenames
# Verify image formats (JPG, PNG, WebP)
```

**Deployment Failures**:
- Check GitHub Actions logs
- Verify Cloudflare secrets
- Ensure build command is correct
- Check for syntax errors in HTML

### 10.2 Getting Help

1. **Check documentation**:
   - README.md
   - DEPLOYMENT.md
   - GitHub Actions logs

2. **Debug locally**:
   ```bash
   make dev
   # Test changes locally first
   ```

3. **Ask for help**:
   - Instructor or mentor
   - GitHub Issues
   - Community forums

## 🎉 Training Module 11: Going Live

### 11.1 Final Review

Before making your portfolio public:

```bash
# Final customization check
make show-config

# Test deployment
make deploy

# Verify live site
# Check all links work
# Test contact form
# Verify responsive design
```

### 11.2 Sharing Your Portfolio

Share your portfolio:
- [ ] LinkedIn profile
- [ ] Resume/CV
- [ ] Email signature
- [ ] Business cards
- [ ] Social media profiles
- [ ] Job applications

### 11.3 Maintenance

Regular updates:
- [ ] Update projects quarterly
- [ ] Add new skills and certifications
- [ ] Refresh content annually
- [ ] Monitor site performance
- [ ] Update contact information

## 📚 Additional Resources

### Learning Materials
- [Cloudflare Pages Documentation](https://developers.cloudflare.com/pages/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [HTML/CSS Tutorials](https://www.w3schools.com/)
- [Git Tutorial](https://git-scm.com/docs/gittutorial)

### Tools and Extensions
- [VS Code](https://code.visualstudio.com/) - Code editor
- [GitHub Desktop](https://desktop.github.com/) - Git GUI
- [Figma](https://figma.com/) - Design tool
- [Canva](https://canva.com/) - Image creation

### Professional Development
- AWS Certifications
- Kubernetes Certifications (CKA, CKAD)
- Cloud Native Computing Foundation (CNCF)
- DevOps Institute

## 🏆 Training Assessment

### Completion Criteria

You have successfully completed this training when:
- [ ] Portfolio is customized with your information
- [ ] GitHub repository is set up and configured
- [ ] Automated deployment is working
- [ ] Site is live on Cloudflare Pages
- [ ] All sections are complete and professional
- [ ] Site is mobile-responsive
- [ ] All links are functional

### Portfolio Evaluation Rubric

**Excellent (90-100%)**:
- All personal information accurate
- Professional profile image
- 5+ relevant projects
- Detailed work experience
- Custom domain configured
- Perfect mobile responsiveness

**Good (80-89%)**:
- Most information complete
- Good profile image
- 3-4 projects
- Basic work experience
- Default domain
- Good mobile experience

**Satisfactory (70-79%)**:
- Basic information complete
- Acceptable profile image
- 2-3 projects
- Limited work experience
- Working deployment
- Basic mobile support

## 🎓 Next Steps

After completing this training:

1. **Continue Learning**:
   - Explore Astro framework version
   - Learn about CI/CD best practices
   - Study cloud architecture patterns

2. **Enhance Your Portfolio**:
   - Add blog functionality
   - Implement analytics
   - Add more interactive features
   - Create project detail pages

3. **Career Development**:
   - Use portfolio in job applications
   - Network with other cloud professionals
   - Contribute to open source projects
   - Speak at conferences or meetups

## 🤝 Community and Support

Join the Cloud Native community:
- [Cloud Native Computing Foundation](https://www.cncf.io/)
- [Kubernetes Community](https://kubernetes.io/community/)
- [AWS Community](https://aws.amazon.com/developer/community/)
- [DevOps Communities](https://devops.com/)

## 📞 Training Support

If you need help during training:
- 📧 Email: training@cloudnative-portfolio.com
- 💬 Slack: #cloudnative-training
- 📚 Documentation: README.md and DEPLOYMENT.md
- 🐛 Issues: GitHub Issues page

---

**Congratulations! 🎉**

You now have the skills to create, customize, and deploy a professional cloud native engineer portfolio. Your portfolio will help you showcase your expertise and advance your career in cloud engineering.

**Remember**: Keep your portfolio updated, stay curious, and continue learning. The cloud native ecosystem is always evolving, and your portfolio should reflect your growth and expertise.

**Good luck with your cloud native journey! ☁️🚀**