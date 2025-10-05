# /plan Command

Generate implementation plan and task breakdown from a PRD.

## Usage

### Create Overall Plan

```
/plan PRD-{number}
```

Example: `/plan PRD-001`

### Create Detailed Task Plans

```
/plan PRD-{number} TASK-{number}
```

Example: `/plan PRD-001 TASK-003`

### Plan All Tasks at Once

```
/plan PRD-{number} --all-tasks
```

## What This Command Does

### Phase 1: Overall Plan (`/plan PRD-XXX`)

1. **Reads the PRD** and understands requirements
2. **Analyzes** project architecture and existing code
3. **Breaks down** requirements into logical tasks
4. **Creates task list** with IDs, descriptions, priorities, dependencies
5. **Generates**:
   - `PRDs/PRD-XXX/plan.md` - Overall implementation strategy
   - `PRDs/PRD-XXX/tasks.json` - Task tracking with metadata

### Phase 2: Task Plans (`/plan PRD-XXX TASK-XXX`)

1. **Reads** overall plan and specific task
2. **Creates detailed implementation plan** including:
   - Exact files to create/modify
   - Technical approach and patterns
   - Required dependencies
   - Testing strategy
   - Acceptance criteria mapping
3. **Generates**: `PRDs/PRD-XXX/TASK-{number}.md`

## Output

### After Phase 1

Creates:
- `PRDs/PRD-XXX/plan.md` - High-level implementation plan
- `PRDs/PRD-XXX/tasks.json` - Task list with status tracking

Console shows:
```
✓ Created implementation plan for PRD-001
✓ Generated 5 tasks: TASK-001 through TASK-005

Tasks Overview:
  TASK-001: [High] Setup project structure
  TASK-002: [High] Implement core functionality  
  TASK-003: [Medium] Add user interface
  TASK-004: [Medium] Write tests
  TASK-005: [Low] Documentation
```

### After Phase 2

Creates:
- `PRDs/PRD-XXX/TASK-{number}.md` - Detailed task implementation plan

## Next Steps

After creating overall plan:
```
/plan PRD-XXX --all-tasks     # Plan all tasks
# or
/plan PRD-XXX TASK-001        # Plan one task
```

After creating task plans:
```
/build PRD-XXX TASK-001       # Start implementation
```

## Agents Involved

- **Planner**: Creates all plans and task breakdowns

## Task Structure

Each task in `tasks.json`:

```json
{
  "task_id": "TASK-001",
  "description": "Brief task description",
  "status": "pending",
  "branch": null,
  "commits": [],
  "dependencies": [],
  "priority": "high",
  "started": null,
  "completed": null
}
```

## Tips

- Run overall plan first to see all tasks
- Review task breakdown before detailing individual tasks
- Consider dependencies when planning task order
- Each task should be independently testable
- Task scope should be reasonable (not too large or small)

