# AI Factory - Repository Structure

## Complete Directory Tree

```
hf-ai-factory/
│
├── .claude/                      # Factory configuration and persistent context
│   └── project/
│       ├── overview.md           # Project vision, goals, and success criteria
│       ├── architecture.md       # Tech stack, standards, and conventions
│       ├── status.json           # Current progress and statistics
│       └── permissions.json      # Agent capabilities and restrictions
│
├── agents/                       # Sub-agent definitions
│   ├── prd-writer.md            # Creates Product Requirements Documents
│   ├── planner.md               # Breaks PRDs into tasks and plans
│   ├── coder.md                 # Implements functionality
│   ├── designer.md              # Ensures UI consistency and patterns
│   ├── tester.md                # Writes tests and verifies quality
│   └── git-manager.md           # Manages branches, commits, and status
│
├── PRDs/                         # Product Requirements Documents
│   ├── PRD-001/                 # Example/Template PRD
│   │   ├── prd.md               # Requirements document
│   │   ├── plan.md              # Implementation plan (created by /plan)
│   │   ├── tasks.json           # Task tracking with status/commits
│   │   ├── TASK-001.md          # Detailed task plan (created by /plan)
│   │   ├── TASK-002.md          # Additional tasks...
│   │   └── test-results.md      # Test reports (created by tester)
│   │
│   └── README.md                # PRD structure documentation
│
├── slash_commands/               # Workflow command definitions
│   ├── prd.md                   # /prd command - Create PRDs
│   ├── plan.md                  # /plan command - Generate plans
│   └── build.md                 # /build command - Implement tasks
│
├── repositories/                 # Actual implementation code
│   ├── project-name/            # Your project code (example)
│   │   ├── src/                 # Source code
│   │   ├── tests/               # Test files
│   │   └── ...                  # Project-specific files
│   │
│   └── README.md                # Repositories usage guide
│
├── .gitignore                    # Git ignore patterns
├── README.md                     # Main documentation (this file)
└── STRUCTURE.md                  # This structure document
```

## File Types and Purposes

### Configuration Files (.claude/project/)

| File | Purpose | Updated By |
|------|---------|------------|
| `overview.md` | High-level project description and goals | Manual / Factory setup |
| `architecture.md` | Tech stack, standards, conventions | Manual / as needed |
| `status.json` | Current progress, active tasks, statistics | Git Manager |
| `permissions.json` | Agent capabilities and workflow rules | Manual / Factory setup |

### Agent Definitions (agents/)

| Agent | Primary Responsibility | Outputs |
|-------|----------------------|---------|
| PRD Writer | Create requirements documents | `prd.md` |
| Planner | Break down into tasks | `plan.md`, `tasks.json`, `TASK-*.md` |
| Coder | Implement functionality | Code in `repositories/` |
| Designer | Maintain UI consistency | UI components in `repositories/` |
| Tester | Verify quality | Tests, `test-results.md` |
| Git Manager | Track progress | Branch management, status updates |

### PRD Structure (PRDs/PRD-XXX/)

| File | Created By | Purpose |
|------|-----------|---------|
| `prd.md` | PRD Writer | Requirements and acceptance criteria |
| `plan.md` | Planner | Overall implementation strategy |
| `tasks.json` | Planner | Task tracking with status and commits |
| `TASK-001.md` | Planner | Detailed implementation plan per task |
| `test-results.md` | Tester | Test execution reports |

### Slash Commands (slash_commands/)

| Command | Purpose | Agents Involved |
|---------|---------|-----------------|
| `/prd` | Create PRD | PRD Writer, Git Manager |
| `/plan` | Generate task plans | Planner |
| `/build` | Implement task | Coder, Designer, Tester, Git Manager |

## Data Flow

```
User Request
    ↓
/prd command → PRD Writer → prd.md
    ↓
/plan command → Planner → plan.md + tasks.json + TASK-*.md
    ↓
/build command → Coder + Designer → Code in repositories/
    ↓
              → Tester → Tests + test-results.md
    ↓
              → Git Manager → Update tasks.json + status.json
    ↓
Complete Task
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

Each task gets its own branch following the pattern: `prd-{number}/task-{number}`

## Status Tracking Hierarchy

```
.claude/project/status.json
    ↓ (project-wide status)
    │
PRDs/PRD-001/tasks.json
    ↓ (PRD-specific task status)
    │
PRDs/PRD-001/TASK-001.md
    ↓ (individual task plan)
    │
repositories/project/
    (actual implementation)
```

## Typical Workflow Sequence

1. **Create PRD**: `/prd [description]`
   - Creates: `PRDs/PRD-XXX/prd.md`
   - Updates: `status.json`

2. **Generate Plan**: `/plan PRD-XXX`
   - Creates: `plan.md`, `tasks.json`
   - Updates: `status.json`

3. **Detail Tasks**: `/plan PRD-XXX --all-tasks`
   - Creates: `TASK-001.md`, `TASK-002.md`, etc.

4. **Implement**: `/build PRD-XXX TASK-001`
   - Creates: Code in `repositories/`, tests, branch
   - Updates: `tasks.json`, `status.json`

5. **Repeat**: Continue with remaining tasks

## Extension Points

### Add New Agent
1. Create `agents/new-agent.md`
2. Define role, tasks, and steps
3. Update `permissions.json`
4. Reference in relevant commands

### Add New Command
1. Create `slash_commands/new-command.md`
2. Define inputs, outputs, workflow
3. Specify agents involved
4. Document usage examples

### Add New Project
1. Create `repositories/new-project/`
2. Initialize project structure
3. Create PRDs for features
4. Follow standard workflow

## Key Design Principles

1. **Separation**: Factory infrastructure separate from project code
2. **Traceability**: Every implementation traces to task → PRD
3. **Automation**: Agents coordinate work with minimal manual intervention
4. **Flexibility**: Structure adapts to single or multi-repo projects
5. **Persistence**: All context and progress maintained in files
6. **Standards**: Consistent patterns enforced through agents

## File Naming Standards

- **PRDs**: `PRD-001`, `PRD-002`, ... (zero-padded, 3 digits)
- **Tasks**: `TASK-001`, `TASK-002`, ... (zero-padded, 3 digits)
- **Branches**: `prd-001/task-001` (lowercase, hyphenated)
- **Agents**: `kebab-case.md` (e.g., `git-manager.md`)
- **Commands**: `lowercase.md` (e.g., `build.md`)

## Status Values

### Task Status
- `pending`: Not started
- `in_progress`: Currently being worked on
- `testing`: Implementation complete, under test
- `blocked`: Waiting on dependency or issue
- `completed`: Finished and verified
- `cancelled`: No longer needed

### Project Phase
- `initialization`: Setting up factory
- `planning`: Creating PRDs and plans
- `development`: Active implementation
- `testing`: Verification phase
- `completed`: Project finished

---

This structure provides a complete, organized framework for AI-assisted software development with full traceability and automated coordination.

