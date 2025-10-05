# AI Factory - Installation Guide

This guide explains how to install and configure the AI Factory for your project.

## Overview

The AI Factory is a **template framework** that can be installed into any new or existing project. The installation process customizes the factory configuration for your specific project needs.

## Quick Start

```bash
# 1. Clone or copy AI Factory to your project
git clone <ai-factory-repo> ./ai-factory
cd ai-factory

# 2. Run the installation script
./install.sh
# This will:
# - Collect your project information
# - Create project.json
# - Copy /install command to clipboard
# - Open Claude Code automatically

# 3. In Claude Code (opens automatically), paste and run
/install

# 4. Start using the AI Factory
/prd Create user authentication system
```

## Installation Methods

### Method 1: As a Subdirectory (Recommended)

Install AI Factory as a subdirectory in your existing project:

```bash
cd /path/to/your/project
git clone <ai-factory-repo> ./ai-factory
cd ai-factory
./install.sh
```

Your structure:
```
your-project/
├── ai-factory/          # AI Factory installation
│   ├── .claude/
│   ├── PRDs/
│   ├── repositories/
│   │   └── your-project/ -> symlink to ../..
│   └── ...
├── src/                 # Your actual code
├── tests/
└── ...
```

**Tip**: Create a symlink in `repositories/` to your project root:
```bash
cd repositories
ln -s ../.. your-project-name
```

### Method 2: As Project Root

Use AI Factory as the main repository structure:

```bash
git clone <ai-factory-repo> your-project-name
cd your-project-name
./install.sh
# Create your code in repositories/your-project-name/
```

Your structure:
```
your-project-name/       # AI Factory IS the root
├── .claude/
├── PRDs/
├── repositories/
│   └── your-project/    # Your code here
└── ...
```

### Method 3: Separate Repository

Keep AI Factory completely separate:

```bash
# Clone AI Factory separately
git clone <ai-factory-repo> project-name-factory
cd project-name-factory
./install.sh
# Configure to point to external repositories
```

Multiple project repositories:
```
workspace/
├── project-factory/     # AI Factory
├── project-frontend/    # Your frontend code
├── project-backend/     # Your backend code
└── project-mobile/      # Your mobile app
```

## Step-by-Step Installation

### Step 1: Run install.sh

The installation script collects information about your project and prepares Claude Code:

```bash
./install.sh
```

**What it does:**
- Collects project information interactively
- Generates `project.json` configuration
- Copies `/install` command to clipboard
- Opens Claude Code automatically (if available)

You'll be prompted for:

#### Project Information
- **Project name**: Name of your project
- **Project description**: Brief description
- **Project type**: web-app, api, mobile, library, etc.

#### Repository Structure
- **Is existing project?**: Yes if you have existing code
- **Multiple repositories?**: Yes for multi-repo projects
- **Repository names**: Names of each repository

#### Technology Stack
- **Primary language**: JavaScript, Python, Go, etc.
- **Framework**: React, Django, Express, etc.
- **Database**: PostgreSQL, MongoDB, etc.
- **Other technologies**: Redis, Docker, AWS, etc.

#### Coding Standards
- **Linter**: eslint, black, golint, etc.
- **Style guide**: Airbnb, Google, PEP 8, etc.
- **Test framework**: Jest, pytest, etc.

#### Project Goals
- Enter multiple goals that define project success
- These guide PRD generation and planning

#### Existing Documentation
- Path to README (optional)
- Path to docs folder (optional)

### Step 2: Review project.json

After running `install.sh`, review the generated configuration:

```bash
cat project.json
```

Example:
```json
{
  "project_name": "My Web App",
  "project_description": "A modern web application for task management",
  "project_type": "web-app",
  "is_existing_project": false,
  "is_multi_repo": false,
  "repositories": ["my-web-app"],
  "tech_stack": {
    "primary_language": "TypeScript",
    "framework": "React",
    "database": "PostgreSQL",
    "other_technologies": "Node.js, Express, Redux",
    "linter": "eslint, prettier",
    "style_guide": "Airbnb",
    "test_framework": "Jest, React Testing Library"
  },
  "goals": [
    "Create intuitive task management interface",
    "Support team collaboration features",
    "Ensure mobile responsiveness"
  ],
  "existing_documentation": {
    "readme_path": "",
    "docs_path": ""
  },
  "installation_date": "2025-10-04T15:30:00Z"
}
```

If anything needs correction, edit `project.json` directly or re-run `install.sh`.

### Step 3: Run /install Command

The project should open automatically in Claude Code. If it opens, simply paste and run:

```
/install
```

**Note:** The command is already copied to your clipboard by `install.sh`!

If Claude Code didn't open automatically, manually open the folder and run the command.

This command:
1. ✅ Reads `project.json`
2. ✅ Updates `.claude/project/overview.md` with your project info
3. ✅ Updates `.claude/project/architecture.md` with your tech stack
4. ✅ Initializes `.claude/project/status.json` with project state
5. ✅ Updates `.claude/settings.json` with project name
6. ✅ Imports existing documentation (if provided)
7. ✅ Deletes `project.json` (cleanup)

### Step 4: Verify Installation

Check that files were updated correctly:

```bash
# View project overview
cat .claude/project/overview.md

# View architecture
cat .claude/project/architecture.md

# View status
cat .claude/project/status.json

# Verify project.json was cleaned up
ls project.json  # Should not exist
```

### Step 5: Commit Configuration

Commit the configured AI Factory:

```bash
git add .claude/
git commit -m "Configure AI Factory for project"
```

This ensures your team has the same configuration.

## What Gets Configured

### `.claude/project/overview.md`

Customized with:
- Your project name and description
- Project type and context
- Your specific goals
- Repository structure
- Current phase (new/existing)
- Links to existing documentation

### `.claude/project/architecture.md`

Customized with:
- Your technology stack
  - Programming language
  - Framework
  - Database
  - Additional technologies
- Your coding standards
  - Linter/formatter configuration
  - Style guide reference
  - Testing framework
- Repository organization
- File structure conventions
- Project-specific design principles

### `.claude/project/status.json`

Initialized with:
- Your project name
- Current timestamp
- Phase: "initialization"
- Empty PRD and task lists
- Initial change log entry
- Statistics counters at zero

### `.claude/settings.json`

Updated with:
- Your project name
- Your project description
- Maintained permissions and configuration

## Using AI Factory After Installation

Once installed, start using the AI Factory:

### Create Your First PRD

```
/prd Create a user authentication system with email/password login,
JWT tokens, and session management
```

### Generate Implementation Plan

```
/plan PRD-001
```

### Plan Individual Tasks

```
/plan PRD-001 --all-tasks
```

### Implement Tasks

```
/build PRD-001 TASK-001
```

## Multi-Repository Configuration

For projects with multiple repositories:

### During Installation

When `install.sh` asks "Does this project use multiple repositories?", answer **Yes**, then provide:

```
Repository name: frontend
Repository name: backend
Repository name: mobile
Repository name: [empty line to finish]
```

This creates:
```json
{
  "repositories": ["frontend", "backend", "mobile"]
}
```

### Repository Structure

Create corresponding directories:

```bash
mkdir -p repositories/frontend
mkdir -p repositories/backend
mkdir -p repositories/mobile
```

### Separate Git Repos

If each repository is a separate git repo:

```bash
cd repositories/frontend
git init
# or
git clone <frontend-repo> .

cd ../backend
git clone <backend-repo> .
```

### PRDs Across Repositories

PRDs can span multiple repositories:

```markdown
# PRD-001: API and Frontend Integration

## Implementation

### Backend (repositories/backend/)
- API endpoints
- Database schema

### Frontend (repositories/frontend/)
- API client
- UI components
```

## Existing Project Integration

For existing projects with code and documentation:

### 1. Provide Documentation Paths

When running `install.sh`:

```
Do you have existing documentation to import? [y/N]: y
Path to README (relative or absolute): ../README.md
Path to docs folder (optional): ../docs
```

### 2. Import Existing Code Structure

After installation, document your existing architecture in `.claude/project/architecture.md`:

```markdown
## Existing Code Structure

```
existing-project/
├── src/
│   ├── api/
│   ├── components/
│   └── utils/
├── tests/
└── ...
```
```

### 3. Create PRDs for Current Features

Document existing features as PRDs:

```
/prd Document existing user authentication system currently in src/auth/
```

This creates a PRD that describes what's already built, useful for:
- Onboarding new team members
- Planning enhancements
- Maintaining consistency

### 4. Create PRDs for New Features

Use PRDs for new development:

```
/prd Add two-factor authentication to existing auth system
```

## Team Collaboration

### Sharing Configuration

Commit `.claude/` directory so the team shares:
- Project configuration
- Agent definitions
- Command definitions
- Project context

```bash
git add .claude/
git commit -m "Add AI Factory configuration"
git push
```

### Team Member Setup

New team members:

```bash
# Clone project with AI Factory
git clone <project-repo>
cd project

# AI Factory is already configured!
# Start using immediately:
/prd [description]
```

### Updating Configuration

To update project configuration:

```bash
# Edit files directly
vim .claude/project/architecture.md

# Or re-run installation
./install.sh
/install

# Commit changes
git add .claude/
git commit -m "Update project configuration"
```

## Advanced Configuration

### Custom Agents

Add project-specific agents in `.claude/agents/`:

```bash
cat > .claude/agents/security-auditor.md << 'EOF'
---
name: Security Auditor
purpose: Review code for security vulnerabilities
tools:
  - read_file
  - grep
context:
  - repositories/
---

# Security Auditor Agent
...
EOF
```

### Custom Commands

Add project-specific commands in `.claude/commands/`:

```bash
cat > .claude/commands/audit.md << 'EOF'
# /audit Command

Run security audit on current code.
...
EOF
```

### Environment-Specific Configuration

Use `settings.local.json` for local overrides:

```json
{
  "local_paths": {
    "repository_root": "/Users/you/projects/myapp"
  }
}
```

Add to `.gitignore`:
```
.claude/settings.local.json
```

## Troubleshooting

### install.sh won't run

```bash
# Make executable
chmod +x install.sh

# Run with bash explicitly
bash install.sh
```

### /install command fails

Check for `project.json`:
```bash
ls -la project.json
cat project.json  # Validate JSON format
```

If missing, re-run:
```bash
./install.sh
```

### Generated files look wrong

Review and manually edit:
```bash
vim .claude/project/overview.md
vim .claude/project/architecture.md
```

Or re-run installation with corrected input.

### Multiple installations needed

You can run `install.sh` and `/install` multiple times. Each run overwrites `.claude/project/` files but preserves:
- PRDs (in `PRDs/`)
- Code (in `repositories/`)
- Custom agents/commands

## Best Practices

1. **Run installation immediately** after setting up AI Factory
2. **Be thorough** with `install.sh` prompts - good input = good output
3. **Review generated files** and refine as needed
4. **Commit configuration** so team shares the same setup
5. **Update architecture.md** as project evolves
6. **Document decisions** in PRDs and task plans
7. **Use descriptive goals** for better AI assistance

## Next Steps

After installation:

1. **Review** `.claude/project/` files
2. **Create** your first PRD: `/prd [description]`
3. **Generate** implementation plan: `/plan PRD-001`
4. **Start** building: `/build PRD-001 TASK-001`

Happy building! 🚀

