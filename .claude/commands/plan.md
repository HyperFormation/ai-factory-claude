# /plan Command

Generate implementation plan and task breakdown from a PRD.

## Usage

```
/plan PRD-{number}
```

Example: `/plan PRD-001`

### Create Plan with Specific Task Count

```
/plan PRD-{number} {count}
```

Example: `/plan PRD-001 4` will create 4 tasks.
Example: `/plan PRD-001 5` will create 5 tasks.

## What This Command Does

1. **Reads the PRD** and understands requirements
2. **Analyzes** project architecture and existing code
3. **Breaks down** requirements into logical tasks
4. **Creates task list** with IDs, descriptions, priorities, dependencies
5. **Generates**:
   - `PRDs/PRD-XXX/plan.md` - Overall implementation strategy
   - `PRDs/PRD-XXX/tasks.json` - Task tracking with metadata

## Output

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

## Next Steps

After creating the plan:
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

- Inspect existing code relevant to the PRD to understand the project and determine how to break down the PRD into tasks.
- Review task breakdown before starting implementation
- Consider dependencies when planning task order
- Each task should be independently testable
- Task scope should be reasonable (not too large or small)
