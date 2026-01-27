# Architecture

## Tech Stack

### Factory Infrastructure
- **Agent Framework**: Claude Code sub-agents
- **Configuration**: JSON and Markdown files
- **Version Control**: Git with structured branching per PRD

### Project Code
- To be determined per project in the `repositories/` folder
- Each project maintains its own tech stack documentation

## Standards & Conventions

### File Organization

```
.claude/          # Factory configuration and context
agents/           # Sub-agent definitions
PRDs/             # Product Requirements Documents and task plans
slash_commands/   # Workflow command definitions
repositories/     # Actual implementation code (gitignored if separate repos)
```

### Naming Conventions

- **PRDs**: `PRD-{number}` (e.g., PRD-001, PRD-002)
- **Tasks**: `TASK-{number}` (e.g., TASK-001, TASK-002)
- **Branches**: `prd-{number}` (one branch per PRD, e.g., prd-001)

### Code Standards

- Write clear, maintainable code with appropriate comments
- Follow language-specific best practices
- Ensure all code is testable
- Document public APIs and complex logic

### Git Workflow

1. Create feature branch for each PRD: `prd-{number}`
2. Each task produces one commit: `[TASK-XXX] Description`
3. Commit frequently with descriptive messages linked to task IDs
4. All tasks for a PRD go on the same branch

## Design Principles

- **Separation of Concerns**: Keep factory infrastructure separate from project code
- **Traceability**: Every implementation should trace back to a task and PRD
- **Consistency**: Use agents to enforce design and code consistency
- **Automation**: Leverage sub-agents for repetitive verification tasks
- **Documentation**: Maintain up-to-date documentation alongside code changes

