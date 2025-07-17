#!/bin/bash

# Setup Astro Version of Cloud Native Portfolio
# This script creates an Astro-based version of the portfolio website

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Setting up Astro version of Cloud Native Portfolio${NC}"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js is not installed. Please install Node.js first.${NC}"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm is not installed. Please install npm first.${NC}"
    exit 1
fi

# Create Astro project
echo -e "${GREEN}📦 Creating Astro project...${NC}"
npm create astro@latest astro-portfolio -- --template minimal --typescript --no-install

cd astro-portfolio

# Install dependencies
echo -e "${GREEN}📦 Installing dependencies...${NC}"
npm install

# Install additional dependencies for the portfolio
echo -e "${GREEN}📦 Installing additional dependencies...${NC}"
npm install @astrojs/tailwind @astrojs/vue @astrojs/sitemap @astrojs/rss astro-seo

# Install Vue and Tailwind
npm install vue @vitejs/plugin-vue tailwindcss @tailwindcss/typography

# Create directory structure
echo -e "${GREEN}📁 Creating directory structure...${NC}"
mkdir -p src/components
mkdir -p src/layouts
mkdir -p src/pages
mkdir -p src/styles
mkdir -p src/assets/images
mkdir -p public/assets/images

# Update astro.config.mjs
echo -e "${GREEN}⚙️ Configuring Astro...${NC}"
cat > astro.config.mjs << 'EOF'
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import vue from '@astrojs/vue';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://cloudnative-portfolio.pages.dev',
  integrations: [
    tailwind(),
    vue(),
    sitemap()
  ],
  output: 'static',
  adapter: undefined,
  vite: {
    define: {
      __DATE__: `"${new Date().toISOString()}"`
    }
  }
});
EOF

# Create Tailwind config
echo -e "${GREEN}🎨 Setting up Tailwind CSS...${NC}"
cat > tailwind.config.mjs << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        primary: '#0078d7',
        secondary: '#2b5797',
        accent: '#00b7c3',
        dark: '#333',
        light: '#f4f4f4'
      },
      fontFamily: {
        sans: ['Segoe UI', 'Tahoma', 'Geneva', 'Verdana', 'sans-serif']
      }
    }
  },
  plugins: [
    require('@tailwindcss/typography')
  ]
}
EOF

# Create base layout
echo -e "${GREEN}🏗️ Creating base layout...${NC}"
cat > src/layouts/BaseLayout.astro << 'EOF'
---
import '../styles/global.css';

export interface Props {
  title: string;
  description?: string;
}

const { title, description = "Professional Cloud Native Engineer Portfolio" } = Astro.props;
const canonicalURL = new URL(Astro.url.pathname, Astro.site);
---

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{title}</title>
  <meta name="description" content={description}>
  <link rel="canonical" href={canonicalURL}>

  <!-- Open Graph / Facebook -->
  <meta property="og:type" content="website">
  <meta property="og:url" content={Astro.url}>
  <meta property="og:title" content={title}>
  <meta property="og:description" content={description}>

  <!-- Twitter -->
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:url" content={Astro.url}>
  <meta property="twitter:title" content={title}>
  <meta property="twitter:description" content={description}>

  <!-- Favicon -->
  <link rel="icon" type="image/svg+xml" href="/favicon.svg">

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>
<body class="font-sans bg-light text-dark">
  <slot />
</body>
</html>
EOF

# Create global CSS
echo -e "${GREEN}🎨 Creating global styles...${NC}"
cat > src/styles/global.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

html {
  scroll-behavior: smooth;
}

body {
  line-height: 1.6;
}

.btn {
  @apply inline-block px-8 py-3 bg-primary text-white rounded-md font-semibold transition-all duration-300 hover:bg-secondary hover:-translate-y-1 hover:shadow-lg;
}

.section-title {
  @apply text-center mb-12 relative;
}

.section-title h2 {
  @apply text-4xl mb-4 text-primary font-bold;
}

.section-title::after {
  content: '';
  @apply absolute bottom-0 left-1/2 transform -translate-x-1/2 w-20 h-1 bg-accent;
}

.animate-fade-in-up {
  animation: fadeInUp 0.6s ease-out;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.skill-category {
  @apply bg-white rounded-lg p-8 shadow-md transition-all duration-300 hover:-translate-y-2 hover:shadow-xl;
}

.skill-category h3 {
  @apply text-xl mb-6 text-primary font-semibold relative pb-3;
}

.skill-category h3::after {
  content: '';
  @apply absolute bottom-0 left-0 w-12 h-1 bg-accent;
}

.project-card {
  @apply bg-white rounded-lg overflow-hidden shadow-md transition-all duration-300 hover:-translate-y-2 hover:shadow-xl;
}

.project-tag {
  @apply px-3 py-1 bg-primary/10 text-primary rounded-full text-sm font-medium mr-2 mb-2;
}

.timeline-item {
  @apply relative mb-12;
}

.timeline-content {
  @apply bg-white p-8 rounded-lg shadow-md;
}

.contact-icon {
  @apply w-10 h-10 flex items-center justify-center text-xl mr-4;
}

.form-control {
  @apply w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent;
}

.social-link {
  @apply w-12 h-12 flex items-center justify-center bg-primary text-white rounded-full mx-2 transition-all duration-300 hover:bg-accent hover:-translate-y-1;
}
EOF

# Create Header component
echo -e "${GREEN}🧩 Creating Header component...${NC}"
cat > src/components/Header.astro << 'EOF'
---
---

<header class="fixed top-0 left-0 w-full bg-white shadow-md z-50 transition-all duration-300">
  <div class="container mx-auto px-6">
    <nav class="flex justify-between items-center py-5">
      <div class="text-2xl font-bold text-primary">
        <a href="#hero">John Smith</a>
      </div>
      <ul class="hidden md:flex space-x-8">
        <li><a href="#hero" class="text-dark font-semibold hover:text-primary transition-colors">Home</a></li>
        <li><a href="#about" class="text-dark font-semibold hover:text-primary transition-colors">About</a></li>
        <li><a href="#skills" class="text-dark font-semibold hover:text-primary transition-colors">Skills</a></li>
        <li><a href="#projects" class="text-dark font-semibold hover:text-primary transition-colors">Projects</a></li>
        <li><a href="#experience" class="text-dark font-semibold hover:text-primary transition-colors">Experience</a></li>
        <li><a href="#contact" class="text-dark font-semibold hover:text-primary transition-colors">Contact</a></li>
      </ul>
      <div class="md:hidden">
        <button id="mobile-menu-btn" class="text-dark text-xl">☰</button>
      </div>
    </nav>
  </div>
</header>

<script>
document.addEventListener('DOMContentLoaded', function() {
  const mobileMenuBtn = document.getElementById('mobile-menu-btn');
  const navLinks = document.querySelector('.md\\:flex');

  if (mobileMenuBtn && navLinks) {
    mobileMenuBtn.addEventListener('click', function() {
      navLinks.classList.toggle('hidden');
      navLinks.classList.toggle('flex');
      navLinks.classList.toggle('flex-col');
      navLinks.classList.toggle('absolute');
      navLinks.classList.toggle('top-full');
      navLinks.classList.toggle('left-0');
      navLinks.classList.toggle('w-full');
      navLinks.classList.toggle('bg-white');
      navLinks.classList.toggle('shadow-md');
      navLinks.classList.toggle('p-4');
    });
  }
});
</script>
EOF

# Create Hero section
echo -e "${GREEN}🧩 Creating Hero section...${NC}"
cat > src/components/Hero.astro << 'EOF'
---
---

<section id="hero" class="min-h-screen flex items-center bg-gradient-to-br from-primary via-secondary to-accent bg-cover bg-center bg-fixed relative">
  <div class="absolute inset-0 bg-black/70"></div>
  <div class="container mx-auto px-6 relative z-10">
    <div class="max-w-4xl text-white">
      <h1 class="text-5xl md:text-6xl font-bold mb-4 animate-fade-in-up">
        John Smith
      </h1>
      <h2 class="text-3xl md:text-4xl mb-8 text-accent animate-fade-in-up">
        Senior Cloud Native Engineer
      </h2>
      <p class="text-xl mb-8 animate-fade-in-up">
        Architecting scalable, resilient and secure cloud-native solutions with 8+ years of experience in AWS, Kubernetes, and microservices architecture.
      </p>
      <a href="#contact" class="btn animate-fade-in-up">Get In Touch</a>
    </div>
  </div>
</section>
EOF

# Create About section
echo -e "${GREEN}🧩 Creating About section...${NC}"
cat > src/components/About.astro << 'EOF'
---
---

<section id="about" class="py-24 bg-white">
  <div class="container mx-auto px-6">
    <div class="section-title">
      <h2>About Me</h2>
    </div>
    <div class="grid md:grid-cols-3 gap-12 items-center">
      <div class="md:col-span-1">
        <div class="rounded-lg overflow-hidden shadow-lg">
          <img
            src="/assets/images/profile.jpg"
            alt="Profile Image"
            class="w-full h-auto transition-transform duration-300 hover:scale-105"
          />
        </div>
      </div>
      <div class="md:col-span-2">
        <h3 class="text-2xl font-bold text-primary mb-6">Cloud Native Specialist</h3>
        <p class="mb-6 text-gray-700">
          I'm a Senior Cloud Native Engineer with expertise in designing, implementing, and managing cloud infrastructure and applications. With over 8 years of experience, I specialize in building scalable, resilient, and secure systems using modern cloud-native technologies.
        </p>
        <p class="mb-6 text-gray-700">
          My approach focuses on implementing DevOps practices, Infrastructure as Code, and continuous delivery pipelines to streamline software development and operations. I have a proven track record of successfully leading complex cloud migration projects and establishing best practices for cloud governance and security.
        </p>
        <p class="mb-8 text-gray-700">
          I'm passionate about keeping up with the latest advancements in cloud technology and sharing knowledge with the community through mentoring, technical writing, and speaking at industry events.
        </p>
        <a href="#" class="btn">Download Resume</a>
      </div>
    </div>
  </div>
</section>
EOF

# Create Skills section
echo -e "${GREEN}🧩 Creating Skills section...${NC}"
cat > src/components/Skills.astro << 'EOF'
---
const skillCategories = [
  {
    title: "Cloud Platforms",
    skills: [
      "AWS (Certified Solutions Architect)",
      "Google Cloud Platform (GCP)",
      "Microsoft Azure",
      "Multi-cloud Architecture"
    ]
  },
  {
    title: "Container Orchestration",
    skills: [
      "Kubernetes (CKA, CKAD certified)",
      "Docker & Containerization",
      "Helm Charts",
      "Service Mesh (Istio, Linkerd)"
    ]
  },
  {
    title: "Infrastructure as Code",
    skills: [
      "Terraform",
      "AWS CloudFormation",
      "Ansible",
      "Pulumi"
    ]
  },
  {
    title: "CI/CD & DevOps",
    skills: [
      "Jenkins",
      "GitHub Actions",
      "GitLab CI/CD",
      "ArgoCD"
    ]
  },
  {
    title: "Monitoring & Observability",
    skills: [
      "Prometheus & Grafana",
      "ELK Stack",
      "Datadog",
      "New Relic"
    ]
  },
  {
    title: "Programming & Scripting",
    skills: [
      "Python",
      "Go",
      "Bash/Shell Scripting",
      "JavaScript/TypeScript"
    ]
  }
];
---

<section id="skills" class="py-24 bg-gray-50">
  <div class="container mx-auto px-6">
    <div class="section-title">
      <h2>My Skills</h2>
    </div>
    <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
      {skillCategories.map((category) => (
        <div class="skill-category">
          <h3>{category.title}</h3>
          <ul class="space-y-3">
            {category.skills.map((skill) => (
              <li class="flex items-center">
                <span class="text-primary mr-3 text-lg">✓</span>
                <span>{skill}</span>
              </li>
            ))}
          </ul>
        </div>
      ))}
    </div>
  </div>
</section>
EOF

# Create main index page
echo -e "${GREEN}📄 Creating main page...${NC}"
cat > src/pages/index.astro << 'EOF'
---
import BaseLayout from '../layouts/BaseLayout.astro';
import Header from '../components/Header.astro';
import Hero from '../components/Hero.astro';
import About from '../components/About.astro';
import Skills from '../components/Skills.astro';
---

<BaseLayout title="John Smith - Cloud Native Engineer Portfolio">
  <Header />
  <Hero />
  <About />
  <Skills />

  <!-- Projects Section -->
  <section id="projects" class="py-24 bg-white">
    <div class="container mx-auto px-6">
      <div class="section-title">
        <h2>Featured Projects</h2>
      </div>
      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div class="project-card">
          <div class="h-48 bg-gray-200 overflow-hidden">
            <img
              src="https://images.unsplash.com/photo-1667372393119-3d4c48d07fc9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80"
              alt="Kubernetes Platform"
              class="w-full h-full object-cover transition-transform duration-300 hover:scale-110"
            />
          </div>
          <div class="p-6">
            <h3 class="text-xl font-bold text-primary mb-3">Enterprise Kubernetes Platform</h3>
            <p class="text-gray-700 mb-4">
              Designed and implemented a multi-cluster Kubernetes platform supporting 200+ microservices across 3 geographical regions.
            </p>
            <div class="flex flex-wrap mb-4">
              <span class="project-tag">Kubernetes</span>
              <span class="project-tag">AWS EKS</span>
              <span class="project-tag">Istio</span>
              <span class="project-tag">Terraform</span>
            </div>
            <a href="#" class="btn">View Details</a>
          </div>
        </div>

        <div class="project-card">
          <div class="h-48 bg-gray-200 overflow-hidden">
            <img
              src="https://images.unsplash.com/photo-1544197150-b99a580bb7a8?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80"
              alt="Cloud Migration"
              class="w-full h-full object-cover transition-transform duration-300 hover:scale-110"
            />
          </div>
          <div class="p-6">
            <h3 class="text-xl font-bold text-primary mb-3">Large-Scale Cloud Migration</h3>
            <p class="text-gray-700 mb-4">
              Led migration of legacy monolithic application to cloud-native microservices architecture, reducing costs by 45%.
            </p>
            <div class="flex flex-wrap mb-4">
              <span class="project-tag">AWS</span>
              <span class="project-tag">Microservices</span>
              <span class="project-tag">Docker</span>
              <span class="project-tag">CI/CD</span>
            </div>
            <a href="#" class="btn">View Details</a>
          </div>
        </div>

        <div class="project-card">
          <div class="h-48 bg-gray-200 overflow-hidden">
            <img
              src="https://images.unsplash.com/photo-1563986768609-322da13575f3?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80"
              alt="Security Pipeline"
              class="w-full h-full object-cover transition-transform duration-300 hover:scale-110"
            />
          </div>
          <div class="p-6">
            <h3 class="text-xl font-bold text-primary mb-3">Automated Security Pipeline</h3>
            <p class="text-gray-700 mb-4">
              Created comprehensive security automation framework reducing security incidents by 75%.
            </p>
            <div class="flex flex-wrap mb-4">
              <span class="project-tag">DevSecOps</span>
              <span class="project-tag">AWS Security Hub</span>
              <span class="project-tag">OPA</span>
              <span class="project-tag">Python</span>
            </div>
            <a href="#" class="btn">View Details</a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Experience Section -->
  <section id="experience" class="py-24 bg-gray-50">
    <div class="container mx-auto px-6">
      <div class="section-title">
        <h2>Work Experience</h2>
      </div>
      <div class="max-w-4xl mx-auto">
        <div class="relative">
          <div class="absolute left-4 top-0 bottom-0 w-1 bg-primary"></div>

          <div class="timeline-item pl-12">
            <div class="absolute left-0 w-8 h-8 bg-primary rounded-full"></div>
            <div class="bg-accent text-white px-4 py-2 rounded-full inline-block text-sm font-semibold mb-4">
              2021 - Present
            </div>
            <div class="timeline-content">
              <h3 class="text-xl font-bold text-primary mb-2">Senior Cloud Native Engineer</h3>
              <h4 class="text-secondary font-semibold mb-4">TechInnovate Inc.</h4>
              <ul class="list-disc pl-6 space-y-2 text-gray-700">
                <li>Lead team of 8 engineers in cloud-native infrastructure design</li>
                <li>Architected multi-region Kubernetes platform with 99.99% uptime</li>
                <li>Implemented GitOps workflows reducing deployment time by 70%</li>
                <li>Established cost optimization strategies saving 30% monthly spend</li>
              </ul>
            </div>
          </div>

          <div class="timeline-item pl-12">
            <div class="absolute left-0 w-8 h-8 bg-primary rounded-full"></div>
            <div class="bg-accent text-white px-4 py-2 rounded-full inline-block text-sm font-semibold mb-4">
              2018 - 2021
            </div>
            <div class="timeline-content">
              <h3 class="text-xl font-bold text-primary mb-2">DevOps Engineer</h3>
              <h4 class="text-secondary font-semibold mb-4">CloudSystems Global</h4>
              <ul class="list-disc pl-6 space-y-2 text-gray-700">
                <li>Led migration to containerized microservices on AWS EKS</li>
                <li>Developed infrastructure as code using Terraform</li>
                <li>Implemented CI/CD pipelines reducing release cycles</li>
                <li>Deployed monitoring solutions improving observability</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Contact Section -->
  <section id="contact" class="py-24 bg-gradient-to-br from-primary to-secondary text-white">
    <div class="container mx-auto px-6">
      <div class="section-title">
        <h2 class="text-white">Get In Touch</h2>
      </div>
      <div class="grid md:grid-cols-2 gap-12">
        <div>
          <h3 class="text-2xl font-bold mb-6">Let's Connect</h3>
          <p class="mb-8 opacity-90">
            Feel free to reach out for cloud native projects, architecture questions, or professional networking.
          </p>
          <div class="space-y-4">
            <div class="flex items-center">
              <span class="contact-icon">📧</span>
              <span>john.smith@example.com</span>
            </div>
            <div class="flex items-center">
              <span class="contact-icon">📱</span>
              <span>+1 (123) 456-7890</span>
            </div>
            <div class="flex items-center">
              <span class="contact-icon">📍</span>
              <span>San Francisco, CA</span>
            </div>
          </div>
        </div>
        <div class="bg-white/10 backdrop-blur-sm rounded-lg p-8">
          <h3 class="text-xl font-bold mb-6">Send Me a Message</h3>
          <form class="space-y-4">
            <input type="text" placeholder="Your Name" class="form-control" required />
            <input type="email" placeholder="Your Email" class="form-control" required />
            <input type="text" placeholder="Subject" class="form-control" required />
            <textarea placeholder="Your Message" rows="5" class="form-control" required></textarea>
            <button type="submit" class="btn w-full bg-white text-primary hover:bg-accent hover:text-white">
              Send Message
            </button>
          </form>
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="bg-dark text-white py-12 text-center">
    <div class="container mx-auto px-6">
      <div class="flex justify-center space-x-4 mb-8">
        <a href="#" class="social-link">LI</a>
        <a href="#" class="social-link">GH</a>
        <a href="#" class="social-link">TW</a>
        <a href="#" class="social-link">MD</a>
      </div>
      <p class="opacity-70">© 2025 John Smith. All Rights Reserved.</p>
    </div>
  </footer>
</BaseLayout>

<script>
document.addEventListener('DOMContentLoaded', function() {
  // Smooth scrolling for navigation links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    });
  });

  // Header background change on scroll
  window.addEventListener('scroll', function() {
    const header = document.querySelector('header');
    if (window.scrollY > 100) {
      header.classList.add('bg-white/95', 'backdrop-blur-sm');
    } else {
      header.classList.remove('bg-white/95', 'backdrop-blur-sm');
    }
  });
});
</script>
EOF

# Update package.json for Astro version
echo -e "${GREEN}📦 Updating package.json...${NC}"
cat > package.json << 'EOF'
{
  "name": "cloudnative-portfolio-astro",
  "type": "module",
  "version": "1.0.0",
  "scripts": {
    "dev": "astro dev",
    "start": "astro dev",
    "build": "astro build",
    "preview": "astro preview",
    "astro": "astro"
  },
  "dependencies": {
    "@astrojs/rss": "^4.0.1",
    "@astrojs/sitemap": "^3.0.3",
    "@astrojs/tailwind": "^5.0.3",
    "@astrojs/vue": "^4.0.2",
    "@tailwindcss/typography": "^0.5.10",
    "astro": "^4.0.7",
    "astro-seo": "^0.8.0",
    "tailwindcss": "^3.3.6",
    "vue": "^3.3.13"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.5.2"
  }
}
EOF

# Create deployment script
echo -e "${GREEN}🚀 Creating deployment script...${NC}"
cat > deploy-astro.sh << 'EOF'
#!/bin/bash

echo "🚀 Deploying Astro version to Cloudflare Pages..."

# Build the project
echo "📦 Building project..."
npm run build

# Deploy to Cloudflare Pages
echo "🌐 Deploying to Cloudflare Pages..."
npx wrangler pages deploy dist --project-name=cloudnative-portfolio-astro

echo "✅ Deployment complete!"
EOF

chmod +x deploy-astro.sh

# Create sample profile image placeholder
echo -e "${GREEN}🖼️ Creating sample profile image...${NC}"
mkdir -p public/assets/images
cat > public/assets/images/profile-placeholder.svg << 'EOF'
<svg width="400" height="400" viewBox="0 0 400 400" xmlns="http://www.w3.org/2000/svg">
  <rect width="400" height="400" fill="#f3f4f6"/>
  <circle cx="200" cy="160" r="60" fill="#d1d5db"/>
  <path d="M200 240c-50 0-90 40-90 90v70h180v-70c0-50-40-90-90-90z" fill="#d1d5db"/>
  <text x="200" y="350" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" fill="#6b7280">Profile Image</text>
</svg>
EOF

# Create README for Astro version
echo -e "${GREEN}📚 Creating Astro README...${NC}"
cat > README.md << 'EOF'
# Cloud Native Portfolio - Astro Version

This is the Astro-powered version of the Cloud Native Engineer portfolio website.

## 🚀 Getting Started

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Start development server**:
   ```bash
   npm run dev
   ```

3. **Build for production**:
   ```bash
   npm run build
   ```

4. **Deploy to Cloudflare Pages**:
   ```bash
   ./deploy-astro.sh
   ```

## 📁 Project Structure

```
/
├── public/
│   └── assets/
│       └── images/
├── src/
│   ├── components/
│   ├── layouts/
│   ├── pages/
│   └── styles/
├── astro.config.mjs
└── tailwind.config.mjs
```

## 🎨 Customization

Edit the components
