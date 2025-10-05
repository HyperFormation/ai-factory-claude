# AI Factory - Repository Structure

> **Updated to align with Claude Code best practices**

## Complete Directory Tree

```
hf-ai-factory/
│
├── .claude/                      # Claude Code configuration (official structure)
│   ├── CLAUDE.md                 # Main instructions with @ imports
│   ├── settings.json             # Project configuration and permissions
│   │
│   ├── agents/                   # Sub-agent definitions (YAML frontmatter)
│   │   ├── prd-writer.md        # Creates Product Requirements Documents
│   │   ├── planner.md           # Breaks PRDs into tasks and plans
│   │   ├── coder.md             # Implements functionality
│   │   ├── designer.md          # Ensures UI consistency
│   │   ├── tester.md            # Writes tests and verifies quality
│   │   └── git-manager.md       # Manages branches, commits, and status
│   │
│   ├── commands/                 # Slash command definitions
│   │   ├── prd.md               # /prd - Create PRDs
│   │   ├── plan.md              # /plan - Generate plans
│   │   └── build.md             # /build - Implement tasks
│   │
│   ├── project/                  # Project context files
│   │   ├── overview.md          # Project vision and goals
│   │   ├── architecture.md      # Tech stack, standards, conventions
│   │   ├── status.json          # Current progress and statistics
│   │   └── permissions.json     # Detailed agent capabilities
│   │
│   └── memory/                   # Persistent memory (future use)
│
├── PRDs/                         # Product Requirements Documents
│   ├── PRD-001/                 # Example/Template PRD
│   │   ├── prd.md               # Requirements document
│   │   ├── plan.md              # Implementation plan (from /plan)
│   │   ├── tasks.json           # Task tracking with status/commits
│   │   ├── TASK-001.md          # Detailed task plans (from /plan)
│   │   ├── TASK-002.md
│   │   └── test-results.md      # Test reports (from tester)
│   │
│   └── README.md                # PRD structure documentation
│
├── repositories/                 # Actual implementation code
│   ├── project-name/            # Your project code
│   │   ├── src/                 # Source code
│   │   ├── tests/               # Test files
│   │   └── ...                  # Project-specific files
│   │
│   └── README.md                # Repositories usage guide
│
├── .gitignore                    # Git ignore patterns
├── README.md                     # Main documentation
└── STRUCTURE.md                  # This file
```

## Claude Code Compliance

This structure follows [Claude Code's official documentation](https://docs.claude.com/en/docs/claude-code/overview):

### ✅ CLAUDE.md
- **Location**: `.claude/CLAUDE.md`
- **Purpose**: Main instructions file for Claude Code
- **Features**: Uses `@` syntax to import other files
- **Status**: ✅ Implemented

### ✅ Sub-Agents
- **Location**: `.claude/agents/`
- **Format**: Markdown files with YAML frontmatter
- **Frontmatter includes**:
  - `name`: Agent name
  - `purpose`: What the agent does
  - `tools`: Tools agent can use
  - `context`: Files/directories agent needs
- **Status**: ✅ All 6 agents implemented with YAML frontmatter

### ✅ Slash Commands
- **Location**: `.claude/commands/`
- **Format**: Markdown files defining command behavior
- **Includes**: Usage, examples, workflow, output
- **Status**: ✅ Three core commands (prd, plan, build)

### ✅ Settings
- **Location**: `.claude/settings.json`
- **Purpose**: Configure permissions, tools, paths
- **Status**: ✅ Comprehensive configuration

### ✅ Project Context
- **Location**: `.claude/project/`
- **Purpose**: Persistent project information
- **Imported by**: `CLAUDE.md` using `@` syntax
- **Status**: ✅ Overview, architecture, status, permissions

### ✅ Memory
- **Location**: `.claude/memory/`
- **Purpose**: Persistent memory across sessions
- **Status**: ✅ Directory created for future use

## Key Changes from Initial Structure

### Before (Non-compliant)
```
hf-ai-factory/
├── .claude/project/        # ❌ Configuration buried too deep
├── agents/                 # ❌ Should be in .claude/
├── slash_commands/         # ❌ Should be in .claude/
└── No CLAUDE.md            # ❌ Missing main instructions file
```

### After (Compliant)
```
hf-ai-factory/
├── .claude/
│   ├── CLAUDE.md           # ✅ Main instructions
│   ├── settings.json       # ✅ Configuration at root of .claude/
│   ├── agents/             # ✅ Agents in .claude/
│   ├── commands/           # ✅ Commands in .claude/
│   ├── project/            # ✅ Context files
│   └── memory/             # ✅ Persistent memory
```

## File Types and Purposes

### Configuration Files

| File | Location | Purpose | Format | Updated By |
|------|----------|---------|--------|------------|
| `CLAUDE.md` | `.claude/` | Main instructions, imports context | Markdown with @ imports | Manual |
| `settings.json` | `.claude/` | Permissions, tools, configuration | JSON | Manual |
| `overview.md` | `.claude/project/` | Project vision and goals | Markdown | Manual |
| `architecture.md` | `.claude/project/` | Tech stack and standards | Markdown | Manual |
| `status.json` | `.claude/project/` | Current progress | JSON | Git Manager |
| `permissions.json` | `.claude/project/` | Detailed agent rules | JSON | Manual |

### Agent Definitions (.claude/agents/)

Each agent file includes:

```markdown
---
name: Agent Name
purpose: What this agent does
tools:
  - read_file
  - write
context:
  - PRDs/
  - .claude/project/
---

# Agent Name

... agent documentation ...
```

| Agent | Primary Responsibility | Key Outputs |
|-------|----------------------|-------------|
| `prd-writer.md` | Create requirements | `PRDs/*/prd.md` |
| `planner.md` | Break down into tasks | `plan.md`, `tasks.json`, `TASK-*.md` |
| `coder.md` | Implement functionality | Code in `repositories/` |
| `designer.md` | Maintain UI consistency | UI components |
| `tester.md` | Verify quality | Tests, `test-results.md` |
| `git-manager.md` | Track progress | Branch management, status |

### Slash Commands (.claude/commands/)

| Command | Purpose | Agents Involved |
|---------|---------|-----------------|
| `prd.md` | Create PRD | PRD Writer, Git Manager |
| `plan.md` | Generate plans | Planner |
| `build.md` | Implement task | Coder, Designer, Tester, Git Manager |

## CLAUDE.md and @ Imports

The `CLAUDE.md` file uses Claude Code's `@` syntax to import context:

```markdown
# AI Factory - Claude Code Configuration

## Project Context

@.claude/project/overview.md
@.claude/project/architecture.md

## Quick Reference
...
```

This allows dynamic inclusion of project context without duplication.

## Data Flow

```
User Request
    ↓
/prd → PRD Writer Agent → prd.md created
    ↓
/plan → Planner Agent → plan.md + tasks.json + TASK-*.md
    ↓
/build → Coder + Designer → Code in repositories/
    ↓
      → Tester → Tests + verification
    ↓
      → Git Manager → Status updates
    ↓
Complete Task ✓
```

## Git Branching Strategy

```
main
  │
  ├── prd-001/task-001
  ├── prd-001/task-002
  ├── prd-001/task-003
  │
  ├── prd-002/task-001
  └── prd-002/task-002
```

Branch naming: `prd-{number}/task-{number}`

## Status Tracking Hierarchy

```
.claude/CLAUDE.md
    ↓ (imports)
.claude/project/status.json
    ↓ (project-wide status)
PRDs/PRD-001/tasks.json
    ↓ (PRD-specific tasks)
PRDs/PRD-001/TASK-001.md
    ↓ (individual task plan)
repositories/project/
    (actual implementation)
```

## Workflow Sequence

1. **Create PRD**: `/prd [description]`
   - Agent: PRD Writer
   - Creates: `PRDs/PRD-XXX/prd.md`, `tasks.json`
   - Updates: `status.json`

2. **Generate Plan**: `/plan PRD-XXX`
   - Agent: Planner
   - Creates: `plan.md`, populates `tasks.json`

3. **Detail Tasks**: `/plan PRD-XXX --all-tasks`
   - Agent: Planner
   - Creates: `TASK-001.md`, `TASK-002.md`, etc.

4. **Implement**: `/build PRD-XXX TASK-001`
   - Agents: Coder, Designer, Tester, Git Manager
   - Creates: Code, tests, branch
   - Updates: `tasks.json`, `status.json`

5. **Repeat**: Continue with remaining tasks

## Best Practices Alignment

### ✅ Configuration Management
- All Claude Code config in `.claude/` directory
- Main instructions in `CLAUDE.md` at root of `.claude/`
- Settings in `settings.json` for permissions and tools

### ✅ Sub-Agent Structure
- Agents defined in `.claude/agents/`
- Each agent has YAML frontmatter with configuration
- Clear purpose, tools, and context defined

### ✅ Slash Commands
- Commands defined in `.claude/commands/`
- Each command has clear usage and examples
- Documented workflow and outputs

### ✅ Imports and Context
- `CLAUDE.md` uses `@` syntax for imports
- Project context separated in `.claude/project/`
- Memory directory for persistent context

### ✅ Separation of Concerns
- Factory infrastructure in `.claude/` and `PRDs/`
- Project code in `repositories/`
- Clear boundaries between configuration and implementation

## Extension Points

### Add New Agent
1. Create `.claude/agents/new-agent.md`
2. Include YAML frontmatter with configuration
3. Define role, workflow, and outputs
4. Reference in relevant commands

### Add New Command
1. Create `.claude/commands/new-command.md`
2. Define usage, examples, workflow
3. Specify agents involved
4. Document expected outputs

### Add New Project
1. Create `repositories/new-project/`
2. Initialize project structure
3. Create PRDs for features
4. Use standard workflow (/prd → /plan → /build)

## File Naming Standards

- **PRDs**: `PRD-001`, `PRD-002` (zero-padded, 3 digits)
- **Tasks**: `TASK-001`, `TASK-002` (zero-padded, 3 digits)
- **Branches**: `prd-001/task-001` (lowercase, hyphenated)
- **Agents**: `kebab-case.md` (e.g., `prd-writer.md`)
- **Commands**: `lowercase.md` (e.g., `build.md`)

## Compliance Summary

| Feature | Required Location | Status |
|---------|------------------|--------|
| Main instructions | `.claude/CLAUDE.md` | ✅ |
| Settings | `.claude/settings.json` | ✅ |
| Sub-agents | `.claude/agents/` | ✅ |
| Slash commands | `.claude/commands/` | ✅ |
| YAML frontmatter | In agent files | ✅ |
| @ imports | In CLAUDE.md | ✅ |
| Project context | `.claude/project/` | ✅ |
| Memory storage | `.claude/memory/` | ✅ |

---

**This structure is fully compliant with [Claude Code's official documentation](https://docs.claude.com/) as of October 2025.**
