# /code-cleanup Command

Review and clean up code changes on the current branch to ensure consistency, eliminate duplication, and align with established codebase patterns.

## Usage

```
/code-cleanup
```

Or with optional scope:

```
/code-cleanup [file-or-directory]
```

## Agents Involved

- **Code Cleanup Agent**: Analyzes code and proposes cleanup changes (see `.claude/agents/code-cleanup.md`)
- **Git Manager Agent**: Manages branch state, helps decide which changes to keep, creates final commit

## What This Command Does

You are entering a **deliberate code cleanup workflow**. Using the **Code Cleanup Agent**, you will analyze the changes made on the current branch compared to `main`, then carefully evaluate each potential improvement before applying it.

**CRITICAL MINDSET**:
- **Think carefully** about every change before making it
- **Question each modification**: Does this actually improve comprehension?
- **Verify no breakage**: Every change must preserve existing behavior
- **Be selective**: Not every possible cleanup is worth doing

**CRITICAL RULES**:
1. **Consolidate, don't create** - Focus on using existing utilities and patterns, not creating new classes or abstractions
2. **Reuse over rebuild** - If functionality exists, use it; don't rebuild it differently
3. **Always preserve** existing functionality
4. **Always match** established conventions exactly
5. **Always verify** tests pass after changes
6. **Always evaluate** if a change is truly beneficial

## The "Think Carefully" Framework

Before making ANY change, run through this decision framework:

### Question 1: Does this improve comprehension?
- Will another developer find this easier to read?
- Does this reduce cognitive load?
- Is the improvement significant or marginal?

**If marginal → Skip the change**

### Question 2: Am I certain this preserves behavior?
- Have I traced all code paths?
- Are there edge cases I might be missing?
- Could this have subtle side effects?

**If any doubt → Skip the change or add extensive testing first**

### Question 3: Does this consolidate rather than create?
- Am I using existing utilities/patterns?
- Am I creating new classes or abstractions? (avoid this)
- Does my change reduce overall code complexity?

**If creating new abstractions → Reconsider; prefer consolidation**

### Question 4: Is the risk worth the benefit?
- What's the worst case if this breaks something?
- How confident am I in the test coverage?
- Would I approve this in a code review?

**If risk > benefit → Skip the change**

### Decision Matrix

| Comprehension | Behavior Safe | Consolidates | Risk/Benefit | Decision |
|---------------|---------------|--------------|--------------|----------|
| ✓ Improved | ✓ Certain | ✓ Yes | ✓ Worth it | **PROCEED** |
| ✓ Improved | ✓ Certain | ✓ Yes | ✗ Risky | Skip |
| ✓ Improved | ✓ Certain | ✗ Creates new | — | Reconsider |
| ✓ Improved | ✗ Uncertain | — | — | Skip |
| ✗ Marginal | — | — | — | Skip |

**Prefer changes that consolidate existing code over those that create new abstractions.**

## Step 1: Analyze Current Branch

First, understand what has changed:

```bash
# Get current branch name
git branch --show-current

# List all changed files compared to main
git diff main --name-only

# Get summary of changes
git diff main --stat

# Review the actual diff
git diff main
```

Create a mental inventory:
- Which files are new vs modified
- What features were added or changed
- What's the scope of changes

## Step 2: Study Existing Patterns

Before making ANY changes, thoroughly research the codebase:

### Find Similar Features

```bash
# Search for similar implementations
codebase_search "how is [similar feature] implemented"

# Find files with similar structure (replace .ext with actual extension)
find . -name "*.ts" -path "*/similar/path/*"

# Look at how existing code handles similar things
grep -r "pattern" --include="*.ts"  # adjust extension as needed
```

### Document the Conventions

For each type of file changed, identify:
- Naming conventions used
- File structure patterns
- Import/require ordering
- Comment and documentation style
- Error handling approach
- Logging patterns

### Find Existing Utilities

```bash
# Search for helper functions
grep -r "export function" --include="*.{ts,js}"
grep -r "export const" --include="*.{ts,js}"

# Find utility directories
ls -la utils/ helpers/ common/ shared/ lib/

# Search for specific functionality
codebase_search "utility for [what you need]"
```

## Step 3: Identify Cleanup Opportunities

Review the changed code looking for:

### 3.1 Duplication

Check if the new code duplicates existing logic:

```bash
# Search for similar code patterns already in codebase
grep -r "distinctive pattern" --include="*.ts"  # adjust extension

# Use semantic search
codebase_search "code that does [same thing]"
```

**Common duplications:**
- Validation logic that exists elsewhere
- API calls that could use existing services
- Formatting/transformation functions that are already utilities
- Error handling that's standardized elsewhere
- UI components that exist in a component library

### 3.2 Pattern Violations

Compare new code against existing conventions:

- Does naming match? (`getUserData` vs `get_user_data` vs `fetchUserData`)
- Does structure match? (Same file organization as similar features)
- Does error handling match? (Same try/catch patterns, error types)
- Does logging match? (Same log levels, message formats)

### 3.3 Unnecessary Complexity

Look for:
- Over-engineered solutions for simple problems
- Multiple abstraction layers where one suffices
- Excessive configuration for fixed behavior
- Dead code or unreachable branches
- Redundant null checks or validations

### 3.4 Missing Standard Elements

Check if new code is missing patterns that similar code has:
- Standard error handling
- Logging statements
- Input validation
- Documentation comments

## Step 4: Execute Cleanup (Using Code Cleanup Agent)

Invoke the **Code Cleanup Agent** mindset (`.claude/agents/code-cleanup.md`) for all changes.

Work through these phases, but **think carefully before each change**:

### Phase 1: Deduplication (Highest Priority)

**Goal**: Eliminate copy-paste code and redundant implementations

For each potential deduplication, **ask yourself**:
- ✓ Is this actually duplicated, or just similar?
- ✓ Will using the existing utility make code clearer or more confusing?
- ✓ Does the existing utility handle all the cases needed?
- ✓ Is the duplication significant enough to warrant the change?

**If YES to all**, proceed:
1. Locate the existing utility/helper/component
2. Replace the duplicate with usage of the existing code
3. **Run tests immediately** to verify no breakage

**If NO to any**, skip this deduplication and document why.

Example:
```javascript
// BEFORE: Duplicate validation in new code
function validateUserEmail(email) { /* same logic */ }
function validateContactEmail(email) { /* same logic */ }

// AFTER: Use existing utility
import { validateEmail } from '../utils/validation';
// ... use validateEmail() instead
```

### Phase 2: Pattern Alignment

**Goal**: Make new code indistinguishable from existing code in style

For each potential alignment, **ask yourself**:
- ✓ Does this change make the code more consistent?
- ✓ Will developers immediately recognize this pattern?
- ✓ Is the existing pattern actually better, or just different?
- ✓ Does this change affect any behavior at all?

**If YES to consistency and NO to behavior change**, proceed:
1. Fix naming to match conventions exactly
2. Restructure files to match similar features
3. Reorder imports to match existing patterns
4. Apply standard error handling/logging
5. **Run tests immediately** to verify no breakage

Example:
```javascript
// BEFORE: New code with different style
const getUserInfo = async (userId) => {
  // different naming, arrow function
}

// AFTER: Matches existing pattern
async function fetchUser(id) {
  // matches existing function style and naming
}
```

### Phase 3: Simplification

**Goal**: Reduce complexity without changing behavior

For each potential simplification, **ask yourself**:
- ✓ Does this make the code genuinely easier to understand?
- ✓ Am I 100% certain this doesn't change behavior?
- ✓ Would another developer agree this is simpler?
- ✓ Is the original code actually problematic, or am I just preferring my style?

**Only proceed if you're confident** the change improves comprehension:
1. Remove dead code (unused variables, unreachable branches)
2. Flatten unnecessary nesting (early returns, guard clauses)
3. Eliminate redundant operations
4. Simplify conditionals
5. **Run tests immediately** to verify no breakage

Example:
```javascript
// BEFORE: Unnecessary nesting
if (user) {
  if (user.isActive) {
    if (user.hasPermission) {
      doThing();
    }
  }
}

// AFTER: Guard clauses
if (!user) return;
if (!user.isActive) return;
if (!user.hasPermission) return;
doThing();
```

### Phase 4: Verification Checkpoint

**Before proceeding to commit, verify EVERYTHING**:

```bash
# Run linters
npm run lint  # or project equivalent

# Run ALL tests
npm test  # or project equivalent

# Run type checking (if applicable)
npm run typecheck
```

**If ANY test fails:**
1. Identify which change caused the failure
2. **Revert that specific change**
3. Document why that change was problematic
4. Re-run tests to confirm green

**Do not proceed until all tests pass.**

## Step 5: Review Changes with Git Manager

Now collaborate with the **Git Manager Agent** to review all changes and decide what to keep.

### 5.1 Review All Staged Changes

```bash
# See all changes made during cleanup
git diff

# See summary of changed files
git diff --stat
```

### 5.2 Evaluate Each Change Category

For each category of changes, work with Git Manager to decide:

| Change Type | Keep? | Criteria |
|-------------|-------|----------|
| Deduplication | ✓/✗ | Did it simplify without breaking? |
| Pattern alignment | ✓/✗ | Is it genuinely more consistent? |
| Simplification | ✓/✗ | Does it actually improve readability? |
| Dead code removal | ✓/✗ | Was the code truly unused? |

### 5.3 Selectively Stage Changes

**If some changes should be discarded:**

```bash
# Interactively stage only the good changes
git add -p

# Or restore specific files to their pre-cleanup state
git restore [file-to-discard]

# Or restore specific hunks
git checkout -p HEAD -- [file]
```

### 5.4 Document Discarded Changes

Track what was intentionally not included and why:

```markdown
### Discarded Changes (intentional)
- [Change]: [Reason it wasn't worth including]
- [Change]: [Reason it might break things]
```

## Step 6: Final Test Run

**Critical**: Run the full test suite one more time with only the approved changes staged:

```bash
# Stash any unstaged changes temporarily
git stash -k

# Run full test suite
npm test  # or project equivalent

# Run linters
npm run lint

# If tests pass, proceed to commit
# If tests fail, investigate and adjust

# Restore stashed changes if needed
git stash pop
```

**Tests must pass before committing.** If they don't:
1. Identify the problematic change
2. Either fix it or discard it
3. Re-run tests until green

## Step 7: Create Final Cleanup Commit (Git Manager)

Work with **Git Manager Agent** to create the final commit on the current PRD branch:

### 7.1 Confirm Branch

```bash
# Verify you're on the correct PRD branch
git branch --show-current

# Should show: prd-{number}
```

### 7.2 Stage Approved Changes

```bash
# Stage all approved changes
git add [specific files]

# Or if all changes are approved
git add -A
```

### 7.3 Create Descriptive Commit

```bash
git commit -m "[CLEANUP] Simplify and align code with existing patterns

Changes included:
- Deduplicated [X] by using existing [Y]
- Aligned naming conventions in [files]
- Simplified [specific improvements]
- Removed unused [what was removed]

Changes evaluated but discarded:
- [What was intentionally not included and why]

Verification:
- All tests passing
- No functional changes
- Linter clean"
```

### 7.4 Update Task Tracking (if applicable)

If this cleanup is associated with a specific task, Git Manager should update `tasks.json` accordingly.

## Step 8: Summary Report

After completion, provide a comprehensive summary:

```markdown
## Code Cleanup Complete

### Branch Info
- Branch: prd-{number}
- Commit: [hash] [CLEANUP] message

### Files Reviewed
- [list of files analyzed]

### Changes Included (after evaluation)

#### Deduplication
- Replaced duplicate [X] with existing utility [Y]
- Consolidated [N] similar functions into [one]

#### Pattern Alignment
- Fixed naming in [files] to match [convention]
- Restructured [file] to match [pattern]
- Applied standard error handling in [places]

#### Simplification
- Removed [N] lines of dead code
- Flattened nested conditionals in [files]
- Eliminated redundant [checks/operations]

### Changes Evaluated but Discarded
- [Change]: [Why it wasn't worth the risk/didn't improve comprehension]
- [Change]: [Why it might have introduced subtle bugs]

### Verification
- ✓ Linter: No errors
- ✓ Tests: All passing (X tests)
- ✓ Type check: Clean (if applicable)
- ✓ Manual: Feature works correctly

### Metrics
- Files changed: X
- Lines before: X
- Lines after: Y
- Net reduction: Z lines (N%)

### Decision Log
| Proposed Change | Decision | Rationale |
|-----------------|----------|-----------|
| [change 1] | ✓ Included | Improved readability |
| [change 2] | ✗ Discarded | Risk outweighed benefit |
```

## DO NOT Do These Things

### ❌ Create New Classes or Abstractions
Cleanup is about consolidation, not architecture. If you find yourself designing a new class hierarchy or abstraction layer, stop and reconsider.
- Prefer adding to existing utilities over creating new ones
- Prefer direct code reuse over new wrapper abstractions
- Keep changes minimal and focused

### ❌ Rebuild Existing Functionality
If something already exists and works, use it—don't build a "better" version.
- Search thoroughly for existing solutions
- Match existing patterns even if you'd do it differently

### ❌ Refactor Beyond the Branch
Only touch files that were changed on this branch. Don't clean up "while you're there."

### ❌ Change Behavior
This is a cleanup, not a feature change. If something works, preserve exactly how it works.

### ❌ Add Dependencies
Don't add new libraries to solve problems. Use what's already in the project.

### ❌ Over-Engineer
Cleanup should simplify, not complicate. If your "improvement" adds more code or indirection than it removes, reconsider.

## When to Stop

Stop the cleanup when:
- All obvious duplications are eliminated
- Code style matches existing patterns
- All linter errors are fixed
- Tests pass
- Feature works correctly

**Do not** keep iterating to "perfection." Good enough conformity is better than perfect abstraction.

## Agent Collaboration

### Code Cleanup Agent (Steps 1-4)
- Analyzes branch changes
- Studies existing patterns
- Identifies cleanup opportunities
- **Thinks carefully** about each proposed change
- Executes cleanup with verification after each change

### Git Manager Agent (Steps 5-7)
- Reviews all changes made by Code Cleanup Agent
- Helps decide which changes to keep vs discard
- Manages selective staging of approved changes
- Creates final cleanup commit on PRD branch
- Updates task tracking if applicable

### Implicit: Tester
- Test suite must pass at each verification checkpoint
- Final test run before commit is mandatory

## Tips for Effective Cleanup

1. **Search before writing** - The utility you need probably exists
2. **Copy existing patterns** - Find similar code and mirror it exactly  
3. **Small changes, frequent tests** - Verify after each modification
4. **When in doubt, match** - If unsure how to do something, find existing example
5. **Preserve behavior religiously** - The feature must work identically after cleanup

## Now Begin

### Phase A: Analysis (Code Cleanup Agent)
1. Run `git diff main --name-only` to see changed files
2. Study each changed file's existing patterns in the codebase
3. Identify cleanup opportunities (deduplication, alignment, simplification)

### Phase B: Deliberate Execution (Code Cleanup Agent)
4. For each proposed change, **think carefully**:
   - Does this actually improve code comprehension?
   - Am I certain this won't break anything?
   - Is this change worth the risk?
5. Execute only the changes that pass the evaluation
6. Run tests after each change, revert if they fail

### Phase C: Review & Commit (Git Manager Agent)
7. Review all changes with Git Manager
8. Decide which changes to keep vs discard
9. Run final test suite
10. Create cleanup commit on PRD branch

**Start the analysis now.**

