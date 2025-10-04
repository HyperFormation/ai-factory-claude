# /prd Command

## Description

Generate a Product Requirements Document (PRD) with acceptance criteria and create the PRD folder structure.

## Usage

```
/prd [feature description or requirements]
```

## Inputs

- **Feature Description**: High-level description of what needs to be built
- **User Requirements**: Specific user needs or business goals
- **Context**: Any additional context, constraints, or dependencies

Example:
```
/prd Create a user authentication system with email/password login, 
password reset, and session management. Must integrate with existing 
user database.
```

## Workflow

1. **Invoke PRD Writer Agent**
   - Pass requirements to PRD Writer agent
   - Agent gathers context from `.claude/project/`
   - Agent researches existing architecture and patterns

2. **Generate PRD**
   - Create next available PRD number (PRD-XXX)
   - Write comprehensive PRD with:
     - Overview and background
     - Goals and success criteria
     - User stories
     - Functional requirements
     - Non-functional requirements
     - Acceptance criteria
     - Out of scope
     - Dependencies
     - Timeline estimates

3. **Create Folder Structure**
   - Create `PRDs/PRD-{number}/` directory
   - Save PRD as `prd.md`
   - Initialize empty `tasks.json`:
     ```json
     {
       "prd_id": "PRD-{number}",
       "tasks": []
     }
     ```

4. **Update Status**
   - Update `.claude/project/status.json` with new PRD
   - Add to `active_prds` list
   - Increment PRD counter

## Outputs

### Created Files
- `PRDs/PRD-{number}/prd.md` - Complete PRD document
- `PRDs/PRD-{number}/tasks.json` - Empty task list (initialized)

### Updated Files
- `.claude/project/status.json` - Added new PRD to tracking

### Console Output
```
✓ Created PRD-XXX: [Feature Name]
✓ PRD document saved to PRDs/PRD-XXX/prd.md
✓ Initialized tasks.json

Next Steps:
Run: /plan PRD-XXX
```

## Next Command

After creating a PRD, run:
```
/plan PRD-{number}
```

## Permissions

**Agents Involved:**
- **PRD Writer**: Creates PRD document
- **Git Manager**: Updates status.json

**Required Access:**
- Read: `.claude/project/overview.md`, `.claude/project/architecture.md`
- Write: `PRDs/PRD-{number}/prd.md`, `PRDs/PRD-{number}/tasks.json`
- Update: `.claude/project/status.json`

## Validation

Before completing, verify:
- [ ] PRD has clear, measurable acceptance criteria
- [ ] All sections are complete and detailed
- [ ] Requirements align with project architecture
- [ ] Scope is clearly defined (including out-of-scope)
- [ ] Dependencies are identified
- [ ] PRD folder structure is created correctly

## Examples

### Example 1: New Feature
```
/prd Create a dashboard showing real-time analytics with charts for 
user activity, revenue, and system health. Should refresh every 30 seconds.
```

### Example 2: Bug Fix / Enhancement
```
/prd Improve search performance. Currently taking 5+ seconds for large 
datasets. Need to reduce to under 1 second through indexing and optimization.
```

### Example 3: Infrastructure
```
/prd Set up automated deployment pipeline with staging and production 
environments, including automated testing and rollback capabilities.
```

