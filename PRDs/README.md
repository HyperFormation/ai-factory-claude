# PRDs Directory

This directory contains Product Requirements Documents and their associated task plans.

## Structure

Each PRD gets its own directory:

```
PRDs/
  PRD-001/
    prd.md           # Product Requirements Document
    plan.md          # Overall implementation plan
    tasks.json       # Task tracking with status and commits
    TASK-001.md      # Detailed plan for individual task
    TASK-002.md
    ...
  PRD-002/
    ...
```

## Workflow

1. **Create PRD**: Use `/prd` command to generate new PRD
2. **Plan**: Use `/plan PRD-XXX` to create implementation plan
3. **Task Planning**: Use `/plan PRD-XXX TASK-XXX` for detailed task plans
4. **Build**: Use `/build PRD-XXX TASK-XXX` to implement tasks

## File Descriptions

### prd.md
Complete product requirements document with:
- Overview and background
- Goals and success criteria
- User stories
- Functional and non-functional requirements
- Acceptance criteria
- Dependencies and timeline

### plan.md
High-level implementation plan including:
- Overall approach
- Major phases
- Task breakdown with IDs and descriptions
- Dependencies between tasks

### tasks.json
Task tracking file with:
- Task IDs, descriptions, and status
- Git branch names
- Commit history
- Dependencies
- Timestamps

### TASK-XXX.md
Detailed implementation plan for a specific task:
- Exact implementation steps
- Files to create/modify
- Technical approach
- Testing strategy
- Acceptance criteria mapping

## Task Status Values

- `pending`: Not yet started
- `in_progress`: Currently being worked on
- `testing`: Implementation complete, under test
- `blocked`: Waiting on dependency or issue
- `completed`: Finished and verified
- `cancelled`: No longer needed

