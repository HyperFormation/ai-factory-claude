# Repositories Directory

This directory contains the actual implementation code for projects managed by the AI Factory.

## Purpose

All project code lives in this directory, separated from the factory infrastructure. This keeps the factory tooling (agents, slash commands, PRDs) separate from the projects being built.

## Structure

Each project or repository gets its own subdirectory:

```
repositories/
  my-web-app/
    src/
    tests/
    package.json
    README.md
  
  backend-api/
    src/
    tests/
    requirements.txt
    README.md
  
  mobile-app/
    ...
```

## Guidelines

### Single Repository Projects
If your project consists of a single codebase:
```
repositories/
  project-name/
    # All project code here
```

### Multi-Repository Projects
If your project has multiple repositories (e.g., frontend and backend):
```
repositories/
  project-name-frontend/
    # Frontend code
  
  project-name-backend/
    # Backend code
```

### What Goes Here
- ✅ Source code
- ✅ Tests
- ✅ Configuration files
- ✅ Project-specific documentation
- ✅ Assets (images, styles, etc.)
- ✅ Build scripts
- ✅ Dependency files (package.json, requirements.txt, etc.)

### What Doesn't Go Here
- ❌ PRDs or task plans (those go in `PRDs/`)
- ❌ Agent definitions (those go in `agents/`)
- ❌ Factory configuration (that goes in `.claude/`)
- ❌ Slash commands (those go in `slash_commands/`)

## Git Management

### Option 1: Subdirectories
Keep repositories as subdirectories within this folder. The AI Factory repository tracks everything together.

### Option 2: Separate Git Repositories
Each project in `repositories/` can be its own git repository:
1. Add `repositories/*/` to `.gitignore` in the factory repo
2. Initialize separate git repos within each project folder
3. Git Manager tracks both factory changes and project changes separately

### Recommended Approach
- For small projects or prototypes: Use subdirectories (Option 1)
- For production projects: Use separate repositories (Option 2)

## Starting a New Project

When beginning a new project:

1. Create project directory:
   ```
   repositories/my-new-project/
   ```

2. Initialize project structure:
   ```
   repositories/my-new-project/
     src/           # Source code
     tests/         # Test files
     README.md      # Project documentation
     # Additional files based on tech stack
   ```

3. Set up dependencies and tooling for your tech stack

4. Reference the project in your PRDs and tasks

## Tech Stack Examples

### Node.js / JavaScript
```
repositories/my-app/
  src/
  tests/
  package.json
  package-lock.json
  .eslintrc.js
  README.md
```

### Python
```
repositories/my-app/
  src/
  tests/
  requirements.txt
  setup.py
  .pylintrc
  README.md
```

### Go
```
repositories/my-app/
  cmd/
  internal/
  pkg/
  go.mod
  go.sum
  README.md
```

Adapt the structure to match your project's needs and best practices for your chosen tech stack.

