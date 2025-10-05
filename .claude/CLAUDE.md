# AI Factory - Claude Code Configuration

This is an AI Factory: a structured framework for building software using Claude Code and specialized sub-agents.

## Installation

**IMPORTANT**: If you're setting up the AI Factory for the first time:

1. Run `./install.sh` to configure for your project
2. Run `/install` command to apply the configuration

This customizes the factory with your project-specific information.

## Project Context

@.claude/project/overview.md
@.claude/project/architecture.md

## Quick Reference

### Workflow Commands

The AI Factory uses these slash commands:

- **`/install`** - Configure factory for your project (one-time setup)
- **`/prd [description]`** - Create a Product Requirements Document
- **`/plan PRD-XXX [TASK-XXX]`** - Generate implementation plans
- **`/build PRD-XXX TASK-XXX`** - Implement tasks end-to-end

### Sub-Agents

The factory includes six specialized agents:

1. **PRD Writer** - Creates comprehensive Product Requirements Documents
2. **Planner** - Breaks PRDs into actionable tasks with detailed plans
3. **Coder** - Implements functionality following standards
4. **Designer** - Ensures UI consistency and design pattern adherence
5. **Tester** - Verifies quality through comprehensive testing
6. **Git Manager** - Manages branches, commits, and progress tracking

## Repository Structure

```
hf-ai-factory/
├── .claude/               # Factory configuration
│   ├── CLAUDE.md         # This file - main instructions
│   ├── agents/           # Sub-agent definitions
│   ├── commands/         # Slash command definitions
│   ├── project/          # Project context files
│   └── settings.json     # Configuration
├── PRDs/                 # Product Requirements Documents
├── repositories/         # Actual implementation code
└── README.md            # Main documentation
```

## Core Principles

1. **Traceability**: Every implementation traces back through Task → Plan → PRD
2. **Separation**: Factory infrastructure is separate from project code
3. **Automation**: Sub-agents coordinate work with minimal manual intervention
4. **Standards**: Consistent patterns enforced through agent definitions
5. **Persistence**: All context and progress maintained in version-controlled files

## Working with the Factory

### Creating New Features

1. Start with `/prd` to define requirements
2. Use `/plan` to break down into tasks
3. Execute with `/build` for each task
4. Sub-agents handle implementation, testing, and verification

### File Organization

- **PRDs**: Requirements and task plans go in `PRDs/PRD-XXX/`
- **Code**: All implementation goes in `repositories/[project-name]/`
- **Status**: Track progress in `.claude/project/status.json`
- **Tasks**: Track tasks in `PRDs/PRD-XXX/tasks.json`

### Naming Conventions

- PRDs: `PRD-001`, `PRD-002` (zero-padded)
- Tasks: `TASK-001`, `TASK-002` (zero-padded)
- Branches: `prd-001/task-001` (lowercase)

## Status Tracking

The factory maintains two levels of status:

1. **Project Status**: `.claude/project/status.json` - overall progress
2. **Task Status**: `PRDs/PRD-XXX/tasks.json` - per-PRD tracking

Task statuses: `pending`, `in_progress`, `testing`, `blocked`, `completed`, `cancelled`

## Important Notes

- All project code lives in `repositories/` folder
- Factory infrastructure stays separate from project code
- Each task gets its own git branch
- All changes are tracked and committed by Git Manager
- Tests must pass before tasks are marked complete

