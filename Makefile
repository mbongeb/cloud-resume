# Cloud Native Portfolio Makefile
# This Makefile helps customize and deploy your portfolio website

# Default values
NAME ?= John Smith
TITLE ?= Senior Cloud Native Engineer
EMAIL ?= john.smith@example.com
PHONE ?= +1 (123) 456-7890
LOCATION ?= San Francisco, CA
GITHUB_USERNAME ?= johnsmith
PROFILE_IMAGE ?= assets/profile.jpg

# Directories
ASSETS_DIR = assets
IMAGES_DIR = $(ASSETS_DIR)/images
BUILD_DIR = dist
TEMP_DIR = .tmp

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

.PHONY: help setup customize build deploy clean install-deps

# Default target
all: setup customize build

# Help target
help:
	@echo "$(BLUE)Cloud Native Portfolio Makefile$(NC)"
	@echo ""
	@echo "$(YELLOW)Available targets:$(NC)"
	@echo "  help           - Show this help message"
	@echo "  setup          - Initialize project structure"
	@echo "  customize      - Customize portfolio with your information"
	@echo "  build          - Build the website for production"
	@echo "  dev            - Start development server"
	@echo "  deploy         - Deploy to Cloudflare Pages"
	@echo "  clean          - Clean build files"
	@echo "  install-deps   - Install required dependencies"
	@echo ""
	@echo "$(YELLOW)Customization variables:$(NC)"
	@echo "  NAME           - Your full name (default: $(NAME))"
	@echo "  TITLE          - Your professional title (default: $(TITLE))"
	@echo "  EMAIL          - Your email address (default: $(EMAIL))"
	@echo "  PHONE          - Your phone number (default: $(PHONE))"
	@echo "  LOCATION       - Your location (default: $(LOCATION))"
	@echo "  GITHUB_USERNAME- Your GitHub username (default: $(GITHUB_USERNAME))"
	@echo "  PROFILE_IMAGE  - Path to your profile image (default: $(PROFILE_IMAGE))"
	@echo ""
	@echo "$(YELLOW)Example usage:$(NC)"
	@echo "  make customize NAME=\"Jane Doe\" EMAIL=\"jane@example.com\" PROFILE_IMAGE=\"my-photo.jpg\""
	@echo "  make deploy"

# Setup project structure
setup:
	@echo "$(GREEN)Setting up project structure...$(NC)"
	@mkdir -p $(ASSETS_DIR)
	@mkdir -p $(IMAGES_DIR)
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(TEMP_DIR)
	@echo "$(GREEN)✓ Project structure created$(NC)"

# Install dependencies
install-deps:
	@echo "$(GREEN)Installing dependencies...$(NC)"
	@command -v node >/dev/null 2>&1 || { echo "$(RED)Node.js is required but not installed. Please install Node.js first.$(NC)"; exit 1; }
	@command -v python3 >/dev/null 2>&1 || { echo "$(RED)Python3 is required but not installed. Please install Python3 first.$(NC)"; exit 1; }
	@echo "$(GREEN)✓ Dependencies check passed$(NC)"

# Customize the portfolio
customize: setup
	@echo "$(GREEN)Customizing portfolio for $(NAME)...$(NC)"

	# Copy profile image if provided and exists
	@if [ -f "$(PROFILE_IMAGE)" ]; then \
		echo "$(GREEN)Copying profile image...$(NC)"; \
		cp "$(PROFILE_IMAGE)" "$(IMAGES_DIR)/profile.jpg"; \
	else \
		echo "$(YELLOW)Profile image not found, using default placeholder$(NC)"; \
	fi

	# Create customized HTML
	@echo "$(GREEN)Updating HTML with your information...$(NC)"
	@cp index.html $(TEMP_DIR)/index.html.backup
	@sed -i.bak 's/John Smith/$(NAME)/g' index.html
	@sed -i.bak 's/Senior Cloud Native Engineer/$(TITLE)/g' index.html
	@sed -i.bak 's/john.smith@example.com/$(EMAIL)/g' index.html
	@sed -i.bak 's/+1 (123) 456-7890/$(PHONE)/g' index.html
	@sed -i.bak 's/San Francisco, CA/$(LOCATION)/g' index.html
	@sed -i.bak 's/Cloud Native Engineer Portfolio/$(NAME) - $(TITLE) Portfolio/g' index.html

	# Update image paths to use local assets
	@if [ -f "$(IMAGES_DIR)/profile.jpg" ]; then \
		sed -i.bak 's|https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d[^"]*|assets/images/profile.jpg|g' index.html; \
	fi

	@rm -f index.html.bak
	@echo "$(GREEN)✓ Portfolio customized successfully!$(NC)"

# Build for production
build: setup
	@echo "$(GREEN)Building for production...$(NC)"
	@rm -rf $(BUILD_DIR)/*
	@mkdir -p $(BUILD_DIR)
	@cp index.html $(BUILD_DIR)/
	@if [ -d "$(ASSETS_DIR)" ]; then \
		cp -r $(ASSETS_DIR) $(BUILD_DIR)/; \
	fi
	@if [ -f "README.md" ]; then \
		cp README.md $(BUILD_DIR)/; \
	fi
	@echo "$(GREEN)✓ Build completed in $(BUILD_DIR)/$(NC)"

# Start development server
dev: setup
	@echo "$(GREEN)Starting development server...$(NC)"
	@echo "$(YELLOW)Open your browser to: http://localhost:8000$(NC)"
	@python3 -m http.server 8000

# Deploy to Cloudflare Pages
deploy: build
	@echo "$(GREEN)Deploying to Cloudflare Pages...$(NC)"
	@if [ -z "$(CLOUDFLARE_API_TOKEN)" ] || [ -z "$(CLOUDFLARE_ACCOUNT_ID)" ]; then \
		echo "$(RED)Error: CLOUDFLARE_API_TOKEN and CLOUDFLARE_ACCOUNT_ID environment variables are required$(NC)"; \
		echo "$(YELLOW)Please set these variables:$(NC)"; \
		echo "  export CLOUDFLARE_API_TOKEN=your_token_here"; \
		echo "  export CLOUDFLARE_ACCOUNT_ID=your_account_id_here"; \
		exit 1; \
	fi
	@echo "$(GREEN)✓ Ready to deploy! Push to GitHub to trigger automatic deployment.$(NC)"

# Create a GitHub repository
create-repo:
	@echo "$(GREEN)Creating GitHub repository...$(NC)"
	@command -v gh >/dev/null 2>&1 || { echo "$(RED)GitHub CLI is required. Install it from https://cli.github.com/$(NC)"; exit 1; }
	@gh repo create $(GITHUB_USERNAME)/cloudnative-portfolio --public --clone=false --description="Professional Cloud Native Engineer Portfolio"
	@git init
	@git add .
	@git commit -m "Initial commit: Cloud Native Portfolio"
	@git branch -M main
	@git remote add origin https://github.com/$(GITHUB_USERNAME)/cloudnative-portfolio.git
	@git push -u origin main
	@echo "$(GREEN)✓ Repository created and pushed to GitHub!$(NC)"

# Generate sample content
generate-sample:
	@echo "$(GREEN)Generating sample content...$(NC)"
	@mkdir -p $(TEMP_DIR)
	@echo "# Sample Projects" > $(TEMP_DIR)/sample-projects.md
	@echo "" >> $(TEMP_DIR)/sample-projects.md
	@echo "## Kubernetes Cluster Setup" >> $(TEMP_DIR)/sample-projects.md
	@echo "- Multi-region EKS cluster with Istio service mesh" >> $(TEMP_DIR)/sample-projects.md
	@echo "- Terraform-based infrastructure automation" >> $(TEMP_DIR)/sample-projects.md
	@echo "- GitOps deployment with ArgoCD" >> $(TEMP_DIR)/sample-projects.md
	@echo "" >> $(TEMP_DIR)/sample-projects.md
	@echo "## CI/CD Pipeline" >> $(TEMP_DIR)/sample-projects.md
	@echo "- GitHub Actions workflow for automated testing" >> $(TEMP_DIR)/sample-projects.md
	@echo "- Docker image building and security scanning" >> $(TEMP_DIR)/sample-projects.md
	@echo "- Automated deployment to staging and production" >> $(TEMP_DIR)/sample-projects.md
	@echo "$(GREEN)✓ Sample content generated in $(TEMP_DIR)/$(NC)"

# Validate HTML
validate:
	@echo "$(GREEN)Validating HTML...$(NC)"
	@command -v tidy >/dev/null 2>&1 || { echo "$(YELLOW)HTML Tidy not found. Install it for HTML validation.$(NC)"; exit 0; }
	@tidy -q -e index.html && echo "$(GREEN)✓ HTML is valid$(NC)" || echo "$(YELLOW)⚠ HTML has some issues$(NC)"

# Clean build files
clean:
	@echo "$(GREEN)Cleaning build files...$(NC)"
	@rm -rf $(BUILD_DIR)
	@rm -rf $(TEMP_DIR)
	@rm -f index.html.bak
	@echo "$(GREEN)✓ Clean completed$(NC)"

# Reset to original
reset:
	@echo "$(YELLOW)Resetting to original template...$(NC)"
	@if [ -f "$(TEMP_DIR)/index.html.backup" ]; then \
		cp "$(TEMP_DIR)/index.html.backup" index.html; \
		echo "$(GREEN)✓ Reset to original template$(NC)"; \
	else \
		echo "$(RED)No backup found. Please restore from git.$(NC)"; \
	fi

# Quick setup for training
training-setup:
	@echo "$(BLUE)🎓 Training Setup - Cloud Native Portfolio$(NC)"
	@echo "$(YELLOW)This will set up your personalized portfolio website$(NC)"
	@echo ""
	@read -p "Enter your full name: " name; \
	read -p "Enter your professional title: " title; \
	read -p "Enter your email: " email; \
	read -p "Enter your phone (optional): " phone; \
	read -p "Enter your location: " location; \
	read -p "Enter your GitHub username: " github; \
	read -p "Enter path to your profile image (optional): " image; \
	echo ""; \
	echo "$(GREEN)Setting up your portfolio...$(NC)"; \
	make customize NAME="$$name" TITLE="$$title" EMAIL="$$email" PHONE="$$phone" LOCATION="$$location" GITHUB_USERNAME="$$github" PROFILE_IMAGE="$$image"
	@echo "$(GREEN)✓ Your portfolio is ready!$(NC)"
	@echo "$(YELLOW)Run 'make dev' to preview your site$(NC)"

# Show current configuration
show-config:
	@echo "$(BLUE)Current Configuration:$(NC)"
	@echo "  NAME: $(NAME)"
	@echo "  TITLE: $(TITLE)"
	@echo "  EMAIL: $(EMAIL)"
	@echo "  PHONE: $(PHONE)"
	@echo "  LOCATION: $(LOCATION)"
	@echo "  GITHUB_USERNAME: $(GITHUB_USERNAME)"
	@echo "  PROFILE_IMAGE: $(PROFILE_IMAGE)"
