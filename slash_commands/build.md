# /build Command

## Description

Implement a task end-to-end by coordinating Coder, Designer, and Tester agents in an iterative loop until all acceptance criteria are met and tests pass.

## Usage

```
/build PRD-{number} TASK-{number}
```

## Inputs

- **PRD Number**: Parent PRD (e.g., PRD-001)
- **Task Number**: Specific task to implement (e.g., TASK-003)

Example:
```
/build PRD-001 TASK-003
```

## Workflow

### 1. Initialize Task

1. **Load Context**
   - Read `PRDs/PRD-{number}/TASK-{number}.md` for implementation plan
   - Review `PRDs/PRD-{number}/prd.md` for requirements
   - Check `.claude/project/architecture.md` for standards

2. **Create Branch** (Git Manager)
   - Create branch: `prd-{number}/task-{number}`
   - Update task status to "in_progress"
   - Update `tasks.json` with branch name

### 2. Implementation Loop

Iterate through these steps until all criteria are met:

#### Step A: Code Implementation

**Invoke Coder Agent**
- Implement functionality per task plan
- Write code in `repositories/{project}/`
- Follow architecture standards
- Handle errors and edge cases
- Commit changes with descriptive messages

**Invoke Designer Agent** (if UI work involved)
- Review UI components for consistency
- Ensure design patterns are followed
- Verify accessibility standards
- Check responsive behavior
- Commit styling/UI changes

#### Step B: Testing

**Invoke Tester Agent**
- Write comprehensive tests
- Execute test suite
- Verify acceptance criteria
- Document results in `PRDs/PRD-{number}/test-results.md`

#### Step C: Evaluation

- **If tests pass and all acceptance criteria met:**
  - Proceed to Step 3 (Completion)

- **If tests fail or criteria not met:**
  - Tester reports issues to Coder
  - Coder fixes issues
  - Return to Step B (retest)

- **If blocked or needs clarification:**
  - Flag to Git Manager
  - Update task status to "blocked"
  - Document blocker in tasks.json
  - Halt workflow

### 3. Complete Task

1. **Final Verification**
   - All tests pass
   - All acceptance criteria met
   - Code follows standards
   - Documentation is complete

2. **Update Status** (Git Manager)
   - Update task status to "completed"
   - Record completion date
   - Update `tasks.json` with final commits
   - Update `.claude/project/status.json`
   - Update project statistics

3. **Summary**
   - List files changed
   - Summarize implementation
   - Report test results
   - Link commits to task

## Outputs

### Created/Modified Files
- Source code in `repositories/{project}/`
- Test files in `repositories/{project}/tests/`
- `PRDs/PRD-{number}/test-results.md` - Test report

### Updated Files
- `PRDs/PRD-{number}/tasks.json` - Task status and commits
- `.claude/project/status.json` - Project progress

### Git Operations
- Branch: `prd-{number}/task-{number}`
- Multiple commits with task implementation
- All commits tagged with task ID

### Console Output
```
✓ Starting build for PRD-XXX TASK-XXX
✓ Created branch: prd-XXX/task-XXX

[Implementation Phase]
  ✓ Coder: Implemented core functionality
  ✓ Designer: Updated UI components
  ✓ Committed changes (3 commits)

[Testing Phase]
  ✓ Tester: Created test suite
  ✓ Running tests...
  ✗ 2 tests failed

[Fix Phase]
  ✓ Coder: Fixed issue #1
  ✓ Coder: Fixed issue #2
  ✓ Committed fixes

[Testing Phase - Retry]
  ✓ Running tests...
  ✓ All 15 tests passed
  ✓ All acceptance criteria met

[Completion]
  ✓ Task marked complete
  ✓ Updated status tracking

Summary:
  Files changed: 5
  Tests added: 15
  Commits: 5
  Status: COMPLETED

Next Steps:
Continue with next task: /build PRD-XXX TASK-XXX
```

## Next Commands

After completing a task:
```
/build PRD-{number} TASK-{next}  # Build next task
```

Or if all tasks complete:
```
# Review PRD completion status
# Consider creating new PRD for next feature
```

## Permissions

**Agents Involved:**
- **Git Manager**: Branch creation, status updates
- **Coder**: Implementation
- **Designer**: UI implementation and consistency
- **Tester**: Test creation and execution

**Required Access:**
- Read: `PRDs/PRD-{number}/*`, `.claude/project/*`
- Write: `repositories/{project}/*`, `PRDs/PRD-{number}/test-results.md`
- Update: `PRDs/PRD-{number}/tasks.json`, `.claude/project/status.json`
- Git: Create branches, commit changes

## Error Handling

### Test Failures
- Maximum 5 fix-retest iterations
- After 5 failures, mark task as "blocked"
- Document issues for manual review

### Blocked Tasks
- Update status to "blocked"
- Document reason in tasks.json
- Notify via status.json
- Halt automated workflow

### Missing Dependencies
- Check task plan for prerequisites
- Verify dependency tasks are completed
- Alert if dependencies not met

## Validation

Before marking complete:
- [ ] All acceptance criteria from PRD are met
- [ ] All tests pass
- [ ] Code follows architecture standards
- [ ] UI is consistent (if applicable)
- [ ] Documentation is updated
- [ ] No linter errors
- [ ] All commits are properly tagged

## Best Practices

- Run `/build` on one task at a time
- Ensure dependencies are completed first
- Review test results carefully
- Commit frequently during implementation
- Keep tasks focused and independently testable
- Update status promptly
- Document any deviations from plan

