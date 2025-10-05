# AI Factory - Template Notice

## This is a Template Repository

The AI Factory is designed to be **cloned and customized** for your specific project. The current `.claude/project/` files contain placeholder/example content.

## Before Using

**You must configure the AI Factory for your project:**

1. Run the installation script:
   ```bash
   ./install.sh
   ```

2. In Claude Code, run the install command:
   ```
   /install
   ```

This will replace the template content with your project-specific information.

## What Gets Replaced

During installation, these template files are customized:

- `.claude/project/overview.md` - Updated with your project vision and goals
- `.claude/project/architecture.md` - Updated with your tech stack and standards  
- `.claude/project/status.json` - Initialized with your project state
- `.claude/settings.json` - Updated with your project name

## What Stays the Same

These components remain unchanged (they are the AI Factory framework):

- `.claude/CLAUDE.md` - Main instructions
- `.claude/agents/` - All agent definitions
- `.claude/commands/` - All command definitions (including /install)
- `PRDs/` - PRD structure and templates
- `repositories/` - Where your code will live

## Template vs. Configured

### Template State (Current)

The template contains generic placeholder content:

```markdown
# Project Overview

## Vision

This project serves as an AI Factory - a standardized framework...
```

### Configured State (After Installation)

After running installation, content is project-specific:

```markdown
# My Web App - Project Overview

## Vision

My Web App is a task management application that helps teams
collaborate more effectively...
```

## Installation Process

### Step 1: Interactive Data Collection (`install.sh`)

The bash script asks you about:
- Your project name and description
- Repository structure
- Technology stack
- Coding standards
- Project goals

This creates a temporary `project.json` file.

### Step 2: Configuration Application (`/install`)

The `/install` command:
- Reads `project.json`
- Updates `.claude/project/` files
- Customizes settings
- Imports existing documentation
- Cleans up temporary files

### Step 3: Ready to Use

Now the AI Factory is configured for your project and ready to use with:
- `/prd` - Create requirements
- `/plan` - Generate plans
- `/build` - Implement features

## Why This Approach?

### Benefits

1. **Reusable Template**: One AI Factory can be used for many projects
2. **Customized Context**: Each installation is tailored to the specific project
3. **Team Alignment**: All team members get the same configuration
4. **Version Control**: Configuration is tracked with the project

### Alternatives Considered

❌ **Manual Configuration**: Error-prone, inconsistent
❌ **One-Size-Fits-All**: Doesn't adapt to project needs
❌ **No Configuration**: Generic advice without context
✅ **Interactive Installation**: Best balance of ease and customization

## Distribution

### As a Git Template

```bash
# Create template repository
git clone <ai-factory-source> ai-factory-template
cd ai-factory-template
git remote remove origin

# For each new project
git clone ai-factory-template my-project-factory
cd my-project-factory
./install.sh
```

### As a GitHub Template

Mark the repository as a template on GitHub, then:

```bash
# Use "Use this template" button on GitHub
# Clone your new repository
git clone <your-repo>
cd <your-repo>
./install.sh
```

### As a Downloadable Archive

```bash
# Download and extract
curl -L <url> | tar xz
cd ai-factory
./install.sh
```

## Multi-Project Usage

You can use one AI Factory template for multiple projects:

### Option 1: Clone Per Project

```bash
# Project 1
git clone ai-factory-template project1-factory
cd project1-factory
./install.sh  # Configure for project 1

# Project 2
git clone ai-factory-template project2-factory
cd project2-factory
./install.sh  # Configure for project 2
```

### Option 2: Git Branches

```bash
git clone ai-factory-template my-factory
cd my-factory

# Configure for project 1
git checkout -b project1
./install.sh  # Configure for project 1
git commit -am "Configure for project 1"

# Configure for project 2
git checkout -b project2
./install.sh  # Configure for project 2
git commit -am "Configure for project 2"

# Switch between projects
git checkout project1  # Work on project 1
git checkout project2  # Work on project 2
```

## Re-Configuration

If project details change:

```bash
# Re-run installation
./install.sh  # Enter updated information
/install      # Apply new configuration
```

**Note**: This overwrites `.claude/project/` files. Your PRDs and code in `repositories/` are not affected.

## Template Maintenance

As the AI Factory template improves:

### Update Your Configuration

```bash
# In your configured factory
git remote add template <ai-factory-template-url>
git fetch template
git merge template/main

# Resolve conflicts (keep your .claude/project/ customizations)
# Update agents, commands, documentation from template
```

### What to Keep

- Your `.claude/project/` files (project-specific)
- Your `PRDs/` (your requirements)
- Your `repositories/` (your code)

### What to Update

- `.claude/agents/` (agent improvements)
- `.claude/commands/` (new commands, improvements)
- `install.sh` (installation improvements)
- Documentation (README, guides)

## Verification

To check if installation is needed:

```bash
# Check if still using template content
grep "This project serves as an AI Factory" .claude/project/overview.md

# If found, you need to run installation
# If not found, you're already configured
```

## Support

For issues with:

- **Installation script**: Check `install.sh` documentation
- **Install command**: See `.claude/commands/install.md`
- **Configuration**: See [INSTALLATION.md](INSTALLATION.md)
- **Usage**: See [README.md](README.md)

---

**Remember**: The AI Factory is a template. Run `./install.sh` and `/install` before using it for your project!

