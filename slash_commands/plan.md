# /plan Command

## Description

Generate an implementation plan and task breakdown from a PRD. Can be called once to create the overall plan, then repeatedly for each task to create detailed implementation plans.

## Usage

### Phase 1: Create Overall Plan
```
/plan PRD-{number}
```

### Phase 2: Create Task Plans
```
/plan PRD-{number} TASK-{number}
```
or
```
/plan PRD-{number} --all-tasks
```

## Inputs

### Phase 1 Inputs
- **PRD Number**: Which PRD to plan (e.g., PRD-001)

### Phase 2 Inputs
- **PRD Number**: Parent PRD
- **Task Number**: Specific task to plan (e.g., TASK-001)
- **--all-tasks** (optional): Plan all tasks sequentially

## Workflow

### Phase 1: Create Overall Plan

1. **Invoke Planner Agent**
   - Read `PRDs/PRD-{number}/prd.md`
   - Review project architecture and existing codebase
   - Analyze requirements and acceptance criteria

2. **Break Down Requirements**
   - Identify logical implementation phases
   - Determine major components or features needed
   - Assess dependencies between tasks
   - Estimate complexity for each task

3. **Generate Task List**
   - Create unique task IDs (TASK-001, TASK-002, etc.)
   - Write brief description for each task
   - Assign priorities (high, medium, low)
   - Identify dependencies between tasks
   - Map tasks to PRD acceptance criteria

4. **Create Outputs**
   - Save overall plan to `PRDs/PRD-{number}/plan.md`
   - Populate `PRDs/PRD-{number}/tasks.json` with task list

5. **Update Status**
   - Update `.claude/project/status.json` with task count

### Phase 2: Create Task Plans

1. **Select Task**
   - Identify specific task from tasks.json
   - Read overall plan for context

2. **Create Detailed Implementation Plan**
   - Describe exactly what needs to be implemented
   - List specific files to create or modify
   - Define technical approach:
     - Algorithms or patterns to use
     - Dependencies or libraries needed
     - Data structures required
   - Map to specific PRD acceptance criteria
   - Define testing strategy
   - Identify potential challenges or risks

3. **Generate Task Document**
   - Save to `PRDs/PRD-{number}/TASK-{number}.md`
   - Include all implementation details
   - Reference relevant PRD sections

4. **Repeat**
   - Continue for each task if `--all-tasks` specified
   - Otherwise, complete for single task

## Outputs

### Phase 1 Outputs

**Created Files:**
- `PRDs/PRD-{number}/plan.md` - Overall implementation plan
- `PRDs/PRD-{number}/tasks.json` - Task list with metadata

**Console Output:**
```
✓ Created implementation plan for PRD-XXX
✓ Generated 5 tasks: TASK-001 through TASK-005

Tasks Overview:
  TASK-001: [High] Setup project structure
  TASK-002: [High] Implement core functionality
  TASK-003: [Medium] Add user interface
  TASK-004: [Medium] Write tests
  TASK-005: [Low] Documentation

Next Steps:
Run: /plan PRD-XXX TASK-001
Or: /plan PRD-XXX --all-tasks
```

### Phase 2 Outputs

**Created Files:**
- `PRDs/PRD-{number}/TASK-{number}.md` - Detailed task plan

**Console Output:**
```
✓ Created detailed plan for TASK-XXX
✓ Plan saved to PRDs/PRD-XXX/TASK-XXX.md

Next Steps:
Run: /build PRD-XXX TASK-XXX
```

## Next Commands

After Phase 1:
```
/plan PRD-{number} TASK-{number}  # Plan individual tasks
/plan PRD-{number} --all-tasks     # Plan all tasks at once
```

After Phase 2:
```
/build PRD-{number} TASK-{number}  # Start implementation
```

## Permissions

**Agents Involved:**
- **Planner**: Creates all plans and task breakdowns

**Required Access:**
- Read: `PRDs/PRD-{number}/prd.md`, `.claude/project/*`, `repositories/*`
- Write: `PRDs/PRD-{number}/plan.md`, `PRDs/PRD-{number}/tasks.json`, `PRDs/PRD-{number}/TASK-*.md`
- Update: `.claude/project/status.json`

## Validation

### Phase 1 Validation
- [ ] All PRD requirements are covered by tasks
- [ ] Task dependencies are correctly identified
- [ ] Each task is independently testable
- [ ] Task scope is appropriate (not too large or small)
- [ ] Priorities are assigned logically

### Phase 2 Validation
- [ ] Implementation approach is technically sound
- [ ] All files to modify are identified
- [ ] Testing strategy is clear
- [ ] Task maps to specific acceptance criteria
- [ ] Dependencies and libraries are specified

## Examples

### Example 1: Create Overall Plan
```
/plan PRD-001
```

Output: Creates plan.md with 8 tasks covering authentication system

### Example 2: Plan Specific Task
```
/plan PRD-001 TASK-003
```

Output: Creates detailed implementation plan for TASK-003

### Example 3: Plan All Tasks
```
/plan PRD-001 --all-tasks
```

Output: Creates detailed plans for all 8 tasks in PRD-001

