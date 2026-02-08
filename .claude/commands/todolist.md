# /todolist Command

Autonomous loop to process pending items from `claude-to-do-list.md`, executing the full PRD → Plan → Build workflow for each item.

## Usage

```
/todolist
```

## What This Command Does

You are entering an **autonomous processing loop**. You will process each pending item in `claude-to-do-list.md` by executing the complete workflow: `/prd` → `/plan` → `/build`.

**IMPORTANT**: This is a self-directed loop. Continue processing items until ALL pending items are either completed or blocked. Do not stop after one item.

## Step 1: Parse the Todo List

Read `claude-to-do-list.md` and identify all **pending items** (checkboxes with `- [ ]`).

For each item, extract:
- **Task name**: Text after the checkbox
- **Description**: The `Description:` field value (used for PRD generation)
- **PRD**: The `PRD:` field value (if exists)
- **Status**: The `Status:` field value (if exists)

Skip items that are:
- Already checked `- [x]`
- Have `Status: Completed`
- Have `Status: Blocked`

## Step 2: Process Each Pending Item

For EACH pending item, execute the following phases in order:

### Phase 1: PRD Creation

Check the `PRD:` field:

- **If empty or missing**: Execute `/prd {Description}` to create a new PRD
  - After creation, update the item's `PRD:` field with the new PRD ID (e.g., `PRD-032`)
  - Update `Status: In Progress`
  - Update `Started:` with today's date if not set

- **If has valid PRD ID** (e.g., `PRD-032`): Skip to Phase 2

### Phase 2: Planning

Check if the PRD has a plan (the plan exist if there are both a `plan.md` and a `tasks.json` in `PRDs/{PRD-ID}`):

- **If plan and tasks.json do not exist**: Execute `/plan {PRD-ID}` to generate the plan
- **If plan and tasks.json exist**: Skip to Phase 3

### Phase 3: Build All Tasks

Get the list of tasks from `PRDs/{PRD-ID}/tasks.json`.

For each task that is NOT `completed`:
1. Execute `/build {PRD-ID} {TASK-ID}`
2. If build fails or gets blocked:
   - Update item in `claude-to-do-list.md` with `Status: Blocked`
   - Add `BlockedReason:` field explaining what failed
   - Move to the next pending item in the todo list
   - Do NOT stop the loop

### Phase 4: Mark Complete

After all tasks for an item are completed:

1. Check the checkbox for the item in `claude-to-do-list.md`: Change `- [ ]` to `- [x]`
2. Update the item's `Status: Completed` in `claude-to-do-list.md`
3. Set the item's `Completed:` to today's date (YYYY-MM-DD) in `claude-to-do-list.md`
4. Add the item's `Implementation:` with a brief summary of what was built in `claude-to-do-list.md`

## Step 3: Continue the Loop

**CRITICAL**: After completing or blocking one item, immediately proceed to the next pending item. Continue until:
- All items are either `Completed` or `Blocked`
- No more pending items remain

## Step 4: Final Summary

After processing all items, provide a summary:

```
## Todolist Processing Complete

### Summary
- Processed: X items
- Completed: X items
- Blocked: X items
- Remaining: X items

### Completed Items
- [Item name] → PRD-XXX

### Blocked Items (need attention)
- [Item name]: [reason]
```

## Todo List Format Reference

Expected format in `claude-to-do-list.md`:

```markdown
- [ ] Pending Task Example Name
    Description: Feature description for PRD generation

- [x] Completed Task Example Name
    Description: Feature description for PRD generation
    PRD: PRD-XXX (or empty)
    Status: Completed | In Progress | Completed | Blocked 
    Started: YYYY-MM-DD
    Completed: YYYY-MM-DD
    Implementation: (added on completion)
    BlockedReason: (added if blocked)
```

## Key Behaviors

1. **Autonomous looping**: You continue processing until all items are done or blocked
2. **State tracking**: The todo list file is the source of truth - update it after each phase
3. **Idempotent**: Safe to re-run - picks up where it left off based on current state
4. **Progress visibility**: Update the todo list after each item to show progress
5. **Error resilience**: If one item blocks, continue to the next item

## Error Handling

- **Missing Description**: Mark item as `Blocked` with reason "Missing Description field"
- **PRD creation fails**: Mark item as `Blocked` with reason "PRD creation failed"
- **Planning fails**: Mark item as `Blocked` with reason "Planning failed"
- **Build fails**: Mark item as `Blocked` with reason "{TASK-ID} build failed"

## Agents Involved

- **PRD Writer**: Creates requirements documents
- **Planner**: Breaks PRDs into tasks
- **Coder**: Implements functionality
- **Designer**: Ensures UI consistency
- **Tester**: Verifies quality
- **Git Manager**: Manages branches and commits

## Now Begin

1. Read `claude-to-do-list.md`
2. Find the first pending item (unchecked `- [ ]`)
3. Start processing with Phase 1
4. Continue until all items are processed

**Start now.**
