# /prd Command

Create a Product Requirements Document with acceptance criteria and folder structure.

## Usage

```
/prd [feature description or requirements]
```

## Examples

```
/prd Create a user authentication system with email/password login, 
password reset, and session management. Must integrate with existing 
user database.
```

```
/prd Build a real-time analytics dashboard showing user activity, 
revenue metrics, and system health. Should update every 30 seconds.
```

## What This Command Does

1. **Invokes PRD Writer Agent** to create comprehensive requirements
2. **Creates PRD folder**: `PRDs/PRD-{next-number}/`
3. **Generates `prd.md`** with complete requirements including:
   - Overview and background
   - Goals and success criteria
   - User stories
   - Functional and non-functional requirements
   - Acceptance criteria (testable conditions)
   - Out of scope items
   - Dependencies
   - Timeline estimates
4. **Initializes `tasks.json`** for future task tracking
5. **Updates project status** in `.claude/project/status.json`

## Output

Creates:
- `PRDs/PRD-XXX/prd.md` - Complete requirements document
- `PRDs/PRD-XXX/tasks.json` - Empty task tracking file

Updates:
- `.claude/project/status.json` - Adds new PRD to active list

## Next Steps

After creating a PRD:

```
/plan PRD-XXX
```

This will generate an implementation plan and break the PRD into tasks.

## Agents Involved

- **PRD Writer**: Creates the requirements document
- **Git Manager**: Updates project status

## Tips

- Be specific about requirements and constraints
- Mention integration points with existing systems
- Include non-functional requirements (performance, security)
- Specify user types and their needs
- List any known dependencies

