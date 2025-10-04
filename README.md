# AI Factory

A structured framework for building software using Claude Code and specialized sub-agents.

## Overview

The AI Factory is a standardized system for managing software development through coordinated AI agents. It provides:

- **Structured Workflows**: Slash commands for common operations (`/prd`, `/plan`, `/build`)
- **Persistent Context**: Project goals, architecture, and status tracking
- **Sub-Agents**: Specialized agents for PRD writing, planning, coding, design, testing, and git management
- **Traceability**: Clear lineage from PRD → Plan → Tasks → Implementation

## Quick Start

### 1. Create a PRD

Define what you want to build:

```
/prd Create a user authentication system with email/password login,
password reset, and session management.
```

This creates a new PRD in `PRDs/PRD-XXX/` with complete requirements and acceptance criteria.

### 2. Generate Implementation Plan

Break the PRD into tasks:

```
/plan PRD-XXX
```

This creates an overall plan and task list. Then create detailed plans for each task:

```
/plan PRD-XXX --all-tasks
```

### 3. Build Tasks

Implement each task:

```
/build PRD-XXX TASK-001
```

This coordinates Coder, Designer, and Tester agents to implement, test, and verify the task until complete.

## Directory Structure

```
.
├── .claude/
│   └── project/
│       ├── overview.md          # Project vision and goals
│       ├── architecture.md      # Tech stack and standards
│       ├── status.json          # Current progress tracking
│       └── permissions.json     # Agent capabilities and limits
│
├── agents/
│   ├── prd-writer.md           # PRD creation agent
│   ├── planner.md              # Task planning agent
│   ├── coder.md                # Implementation agent
│   ├── designer.md             # UI consistency agent
│   ├── tester.md               # Testing and verification agent
│   └── git-manager.md          # Version control agent
│
├── PRDs/
│   ├── PRD-001/
│   │   ├── prd.md              # Product requirements
│   │   ├── plan.md             # Implementation plan
│   │   ├── tasks.json          # Task tracking
│   │   ├── TASK-001.md         # Detailed task plans
│   │   └── ...
│   └── README.md
│
├── slash_commands/
│   ├── prd.md                  # /prd command definition
│   ├── plan.md                 # /plan command definition
│   └── build.md                # /build command definition
│
├── repositories/
│   ├── project-name/           # Your actual code lives here
│   └── README.md
│
└── README.md                   # This file
```

## Slash Commands

### `/prd [description]`

Creates a Product Requirements Document with acceptance criteria.

**Example:**
```
/prd Build a REST API for managing blog posts with CRUD operations,
authentication, and pagination.
```

**Output:**
- `PRDs/PRD-XXX/prd.md` with complete requirements
- Initialized `tasks.json` file

### `/plan PRD-XXX [TASK-XXX]`

Generates implementation plans from PRDs.

**Phase 1 - Overall Plan:**
```
/plan PRD-001
```

Creates task breakdown and overall strategy.

**Phase 2 - Task Plans:**
```
/plan PRD-001 TASK-003
```

Creates detailed implementation plan for specific task.

**Plan All Tasks:**
```
/plan PRD-001 --all-tasks
```

**Output:**
- `plan.md` with task breakdown
- Populated `tasks.json` with all tasks
- Individual `TASK-XXX.md` files with implementation details

### `/build PRD-XXX TASK-XXX`

Implements a task end-to-end with automated testing.

**Example:**
```
/build PRD-001 TASK-003
```

**Process:**
1. Creates git branch: `prd-001/task-003`
2. Coder implements functionality
3. Designer ensures UI consistency
4. Tester writes and runs tests
5. Iterates until all tests pass and acceptance criteria met
6. Updates status tracking

## Sub-Agents

### PRD Writer
- Creates comprehensive Product Requirements Documents
- Defines acceptance criteria and success metrics
- Establishes project scope and constraints

### Planner
- Breaks PRDs into implementable tasks
- Creates detailed implementation plans
- Identifies dependencies and priorities

### Coder
- Implements functionality per task plans
- Follows architecture standards
- Writes maintainable, documented code

### Designer
- Ensures UI consistency across the project
- Enforces design patterns and component reuse
- Maintains visual coherence and accessibility

### Tester
- Writes comprehensive test suites
- Verifies acceptance criteria
- Reports issues and validates fixes

### Git Manager
- Creates and manages task branches
- Tracks commits and progress
- Updates project status
- Generates summaries and reports

## Workflow Example

### Complete Feature Development

```bash
# 1. Create PRD for user authentication
/prd Implement user authentication with email/password, JWT tokens,
password reset, and session management.

# Output: Created PRD-001

# 2. Generate implementation plan
/plan PRD-001

# Output: Created 6 tasks

# 3. Plan all tasks
/plan PRD-001 --all-tasks

# Output: Detailed plans for TASK-001 through TASK-006

# 4. Build each task
/build PRD-001 TASK-001  # Setup auth infrastructure
/build PRD-001 TASK-002  # Implement login
/build PRD-001 TASK-003  # Implement registration
/build PRD-001 TASK-004  # Add password reset
/build PRD-001 TASK-005  # Session management
/build PRD-001 TASK-006  # Testing and documentation
```

## File Formats

### tasks.json

Tracks task progress and git history:

```json
{
  "prd_id": "PRD-001",
  "tasks": [
    {
      "task_id": "TASK-001",
      "description": "Setup authentication infrastructure",
      "status": "completed",
      "branch": "prd-001/task-001",
      "commits": [
        {
          "hash": "abc123",
          "message": "Add JWT library and auth middleware",
          "date": "2025-10-04"
        }
      ],
      "dependencies": [],
      "priority": "high",
      "started": "2025-10-04",
      "completed": "2025-10-04"
    }
  ]
}
```

### status.json

Tracks overall project state:

```json
{
  "project_name": "AI Factory",
  "last_updated": "2025-10-04",
  "current_phase": "development",
  "active_prds": ["PRD-001", "PRD-002"],
  "active_tasks": ["TASK-003", "TASK-007"],
  "recent_changes": [
    {
      "date": "2025-10-04",
      "description": "Completed TASK-002: User login implementation",
      "type": "task_completion",
      "prd": "PRD-001"
    }
  ],
  "statistics": {
    "total_prds": 2,
    "total_tasks": 12,
    "completed_tasks": 5,
    "in_progress_tasks": 2
  }
}
```

## Naming Conventions

### PRDs
- Format: `PRD-{number}` (e.g., PRD-001, PRD-015)
- Sequential numbering across the project

### Tasks
- Format: `TASK-{number}` (e.g., TASK-001, TASK-023)
- Sequential numbering within each PRD

### Branches
- Format: `prd-{number}/task-{number}` (e.g., prd-001/task-003)
- One branch per task
- Tagged with parent PRD

## Best Practices

### PRD Creation
- ✅ Be specific about requirements
- ✅ Define measurable acceptance criteria
- ✅ Clearly state what's out of scope
- ✅ Identify dependencies early

### Planning
- ✅ Keep tasks focused and independently testable
- ✅ Define clear success criteria per task
- ✅ Consider dependencies and order
- ✅ Be specific about implementation approach

### Implementation
- ✅ Follow task plan and PRD requirements
- ✅ Write tests for all functionality
- ✅ Commit frequently with clear messages
- ✅ Keep code maintainable and documented
- ✅ Ensure UI consistency across features

### Testing
- ✅ Cover happy paths and edge cases
- ✅ Test error handling
- ✅ Verify all acceptance criteria
- ✅ Write independent, repeatable tests

## Customization

### Adding New Agents

Create a new agent file in `agents/`:

```markdown
# My Custom Agent

**Role**: Agent Name

**Task**: What this agent does

## Steps
1. Step 1
2. Step 2
...
```

### Adding New Commands

Create a new command file in `slash_commands/`:

```markdown
# /mycommand Command

## Description
What the command does

## Usage
/mycommand [args]

## Workflow
1. Step 1
2. Step 2
...
```

### Updating Architecture

Modify `.claude/project/architecture.md` to define:
- Tech stack choices
- Coding standards
- Design patterns
- Testing requirements

## Extending the Factory

The AI Factory is designed to be extended:

- **Custom Workflows**: Add new slash commands for your specific needs
- **Specialized Agents**: Create domain-specific agents (e.g., Security Auditor, Performance Optimizer)
- **Integration**: Connect to external tools, APIs, or services
- **Templates**: Create PRD templates for common project types

## Project Status

Check current status:
- View `.claude/project/status.json` for active work
- Review `PRDs/*/tasks.json` for task-level progress
- Check git branches for in-progress tasks

## Getting Help

- **PRD Templates**: See `PRDs/PRD-001/prd.md` for example structure
- **Agent Definitions**: Review `agents/` for agent capabilities
- **Command Reference**: Check `slash_commands/` for detailed usage
- **Architecture**: Read `.claude/project/architecture.md` for standards

## License

This framework is provided as-is for use with Claude Code. Adapt it to your needs.

---

**Ready to start building?**

```
/prd [Describe what you want to build]
```

