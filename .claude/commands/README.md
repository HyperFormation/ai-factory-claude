# Slash Commands

This directory contains the definitions for all slash commands available in the AI Factory.

## Available Commands

### Setup Command

- **`/install`** - Configure AI Factory for your project (one-time setup)

### Workflow Commands

- **`/prd`** - Create a Product Requirements Document
- **`/plan`** - Generate implementation plans from PRDs
- **`/build`** - Implement tasks end-to-end with automated testing

## Command Format

Each command is defined in a Markdown file that includes:

- **Description** - What the command does
- **Usage** - How to invoke the command
- **Examples** - Sample usage scenarios
- **Workflow** - Step-by-step process
- **Output** - What files are created/updated
- **Agents Involved** - Which sub-agents participate
- **Error Handling** - Common issues and solutions

## Usage

Commands are invoked in Claude Code by typing `/` followed by the command name:

```
/install
/prd Create user authentication system
/plan PRD-001
/build PRD-001 TASK-001
```

## Adding New Commands

To add a new command:

1. Create a new `.md` file in this directory
2. Follow the format of existing commands
3. Document usage, workflow, and outputs
4. Specify which agents are involved
5. Add examples and error handling

Example structure:

```markdown
# /mycommand Command

Brief description of what it does.

## Usage

\`\`\`
/mycommand [arguments]
\`\`\`

## What This Command Does

Detailed explanation...

## Examples

...

## Agents Involved

...
```

## Command Discovery

Claude Code automatically discovers commands in this directory. No additional configuration needed.

## Best Practices

- Keep commands focused on specific tasks
- Provide clear usage examples
- Document all parameters
- Include error handling guidance
- Specify expected outputs
- List agent dependencies

