# /build Command

Implement a task end-to-end with automated testing and verification.

## Usage

```
/build PRD-{number} TASK-{number}
```

Example: `/build PRD-001 TASK-003`

## What This Command Does

This command orchestrates multiple agents to implement, test, and verify a task:

### 1. Initialize (Git Manager)

- Creates branch: `prd-{number}/task-{number}`
- Updates task status to `in_progress`
- Records start time

### 2. Implementation Loop

Repeats until all tests pass:

#### Code (Coder + Designer)

- **Coder** implements functionality per task plan
- **Designer** ensures UI consistency (if UI work)
- Code committed to task branch

#### Test (Tester)

- **Tester** writes comprehensive tests
- Runs test suite
- Verifies acceptance criteria
- Documents results

#### Evaluate

- **All tests pass** → Proceed to completion
- **Tests fail** → Coder fixes issues, return to testing
- **Blocked** → Mark task blocked, halt workflow

### 3. Complete (Git Manager)

- Updates task status to `completed`
- Records completion time
- Updates project statistics
- Documents all commits

## Output

Creates/Modifies:
- Source code in `repositories/{project}/`
- Test files in `repositories/{project}/tests/`
- `PRDs/PRD-XXX/test-results.md` - Test report

Updates:
- `PRDs/PRD-XXX/tasks.json` - Task status and commits
- `.claude/project/status.json` - Project progress

Git:
- Branch: `prd-{number}/task-{number}`
- Multiple commits tagged with task ID

## Console Output Example

```
✓ Starting build for PRD-001 TASK-003
✓ Created branch: prd-001/task-003
✓ Task status: in_progress

[Implementation]
  ✓ Coder: Implemented user registration endpoint
  ✓ Designer: Updated registration form styling
  ✓ Committed 3 changes

[Testing]
  ✓ Tester: Created 12 unit tests
  ✓ Tester: Created 3 integration tests
  ✓ Running tests...
  ✗ 2 tests failed

[Fix Iteration]
  ✓ Coder: Fixed validation issue
  ✓ Coder: Fixed email format check
  ✓ Committed fixes

[Re-testing]
  ✓ Running tests...
  ✓ All 15 tests passed
  ✓ All acceptance criteria verified

[Completion]
  ✓ Task marked complete
  ✓ Updated status tracking

Summary:
  Files changed: 5
  Tests added: 15
  Commits: 5
  Status: COMPLETED ✓
```

## Next Steps

After completing a task:

```
/build PRD-XXX TASK-{next}    # Build next task
```

Check task list to see what's next:
- Review `PRDs/PRD-XXX/tasks.json`
- Respect task dependencies

## Agents Involved

- **Git Manager**: Branch creation, status updates
- **Coder**: Implementation
- **Designer**: UI consistency and design
- **Tester**: Test creation and execution

All agents coordinate automatically during the build process.

## Success Criteria

Task is marked complete when:
- [ ] All tests pass
- [ ] All acceptance criteria met
- [ ] Code follows architecture standards
- [ ] UI is consistent (if applicable)
- [ ] No linter errors
- [ ] Test results documented

## Error Handling

### Test Failures
- Maximum 5 fix-retest iterations
- After 5 failures, task marked `blocked`
- Issues documented in tasks.json

### Blocked Tasks
- Status set to `blocked`
- Reason documented
- Manual intervention required

### Missing Dependencies
- Checks if dependency tasks completed
- Warns if prerequisites not met

## Tips

- Build tasks in dependency order
- One task at a time
- Review test results carefully
- Ensure task plan is detailed before building
- Check `.claude/project/architecture.md` for standards

