# /install Command

Configure the AI Factory for your specific project using data collected from `install.sh`.

## Usage

```
/install
```

**Prerequisites**: Run `./install.sh` first to create `project.json` with your project information.

**Note**: After running `install.sh`, this command will be copied to your clipboard and Claude Code will open automatically. Just paste and run!

## What This Command Does

This command customizes the AI Factory template for your specific project by:

1. **Reading Configuration**: Loads project data from `project.json`
2. **Updating Project Files**: Customizes `.claude/project/` files:
   - `overview.md` - Project vision, goals, and context
   - `architecture.md` - Tech stack, standards, and conventions
   - `status.json` - Initial project status
3. **Updating Settings**: Updates `.claude/settings.json` with project name
4. **Importing Documentation**: Optionally imports existing README and docs
5. **Cleanup**: Deletes `project.json` after successful installation

## Installation Workflow

### Step 1: Run Install Script

```bash
./install.sh
```

This interactively collects:
- Project name and description
- Project type
- Repository structure (single/multi-repo, existing/new)

### Step 2: Run Install Command

In Claude Code:
```
/install
```

This processes the configuration and sets up the AI Factory.

## What Gets Updated

### `.claude/project/overview.md`

Generated content includes:
- Project name and description
- Project type and context
- Repository structure
- Current phase (new vs existing project)
- Placeholder sections for goals and success criteria (to be filled in)

### `.claude/project/architecture.md`

Generated content includes:
- Project type and context
- Repository structure
- File organization conventions
- Design principles
- Placeholder for tech stack (to be filled in as you work)

### `.claude/project/status.json`

Initialized with:
```json
{
  "project_name": "Your Project",
  "last_updated": "2025-10-04T...",
  "current_phase": "initialization",
  "active_prds": [],
  "completed_prds": [],
  "active_tasks": [],
  "recent_changes": [
    {
      "date": "2025-10-04",
      "description": "AI Factory installed and configured",
      "type": "initialization"
    }
  ],
  "statistics": {
    "total_prds": 0,
    "total_tasks": 0,
    "completed_tasks": 0,
    "in_progress_tasks": 0
  }
}
```

### `.claude/settings.json`

Updates:
- Project name
- Project description

## Output

Creates/Updates:
- `.claude/project/overview.md` - Customized for your project
- `.claude/project/architecture.md` - Customized for your project
- `.claude/project/status.json` - Initialized for your project
- `.claude/settings.json` - Updated with project info

Deletes:
- `project.json` - Temporary configuration file

Console Output:
```
✓ Reading project configuration...
✓ Updating overview.md...
✓ Updating architecture.md...
✓ Updating status.json...
✓ Updating settings.json...
✓ Importing existing documentation...
✓ Cleaning up temporary files...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  AI FACTORY INSTALLATION COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Project: Your Project Name
Type: web-app
Repositories: 1
Phase: initialization

The AI Factory is now configured for your project!

Next Steps:
1. Review .claude/project/ files
2. Create your first PRD: /prd [description]
3. Generate a plan: /plan PRD-001
4. Start building: /build PRD-001 TASK-001

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Error Handling

### No project.json Found
```
ERROR: project.json not found.
Please run ./install.sh first to generate the configuration file.
```

### Invalid project.json Format
```
ERROR: project.json is invalid or corrupted.
Please run ./install.sh again to regenerate the configuration.
```

### Missing Required Fields
```
ERROR: Required field 'project_name' missing in project.json.
Please run ./install.sh again.
```

## Verification

After installation, verify:

```bash
# Check that files were updated
cat .claude/project/overview.md | head -20
cat .claude/project/architecture.md | head -20
cat .claude/project/status.json

# Verify project.json was deleted
ls project.json  # Should not exist
```

## Agents Involved

- **System/Claude**: Reads configuration and updates files
- **Git Manager**: Can be invoked to commit the initialized configuration

## Re-installation

If you need to reconfigure the AI Factory:

1. Run `./install.sh` again to create new `project.json`
2. Run `/install` to apply the new configuration

**Note**: This will overwrite existing `.claude/project/` files. Existing PRDs and tasks are not affected.

## Template Preservation

Before installation, the AI Factory contains template/example content in `.claude/project/` files. This command replaces that template content with your project-specific information while preserving:

- The overall AI Factory structure
- Agent definitions
- Command definitions
- PRD structure
- Repository organization

## Multi-Project Usage

For managing multiple projects:

### Option 1: Separate AI Factory per Project
- Clone AI Factory to each project directory
- Run installation in each project
- Each has its own PRDs and configuration

### Option 2: Single AI Factory, Multiple Repos
- Single AI Factory installation
- Multiple repositories in `repositories/` folder
- Shared PRDs across repositories
- Common standards and practices

### Option 3: Separate Branches
- Use git branches for different projects
- Each branch configured for a specific project
- Switch branches to switch contexts

## Best Practices

1. **Run installation immediately** after cloning AI Factory
2. **Review generated files** in `.claude/project/` after installation
3. **Commit the configuration** so team members have the same setup
4. **Update architecture.md** as project evolves
5. **Keep status.json updated** via Git Manager agent

## Tips

- Be thorough when running `install.sh` - good input = good configuration
- For existing projects, provide paths to current documentation
- Review and refine generated files after installation
- Update coding standards in `architecture.md` as needed
- Use descriptive project goals for better PRD generation

## Example Installation Flow

```bash
# Clone AI Factory template
git clone https://github.com/yourorg/ai-factory.git my-project-factory
cd my-project-factory

# Run installation script
./install.sh
# ... answer prompts ...

# Open in Claude Code and run:
# /install

# Verify installation
cat .claude/project/overview.md

# Start using
# /prd Create user authentication system
```

## Troubleshooting

### Script fails to create project.json
- Check file permissions in current directory
- Ensure bash is available

### Install command doesn't find project.json
- Ensure you're in the correct directory
- Check that `install.sh` completed successfully
- Look for error messages in the terminal

### Generated files look wrong
- Check `project.json` content before running `/install`
- Re-run `install.sh` if data is incorrect
- Manually edit `.claude/project/` files if needed

