#!/bin/bash

# AI Factory Installation Script
# This script collects project information and prepares it for the AI Factory setup

set -e

CONFIG_FILE=".claude/configs/projects.json"
REPO_DIR="repositories"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║          AI Factory - Project Installation Setup            ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Function to check for uncommitted changes in repositories
check_uncommitted_code() {
    if [ ! -d "$REPO_DIR" ]; then
        return 0  # No repositories directory, nothing to check
    fi

    local has_uncommitted=false
    local repos_with_changes=()

    for repo_path in "$REPO_DIR"/*; do
        if [ -d "$repo_path/.git" ]; then
            repo_name=$(basename "$repo_path")
            cd "$repo_path"
            if ! git diff-index --quiet HEAD -- 2>/dev/null; then
                has_uncommitted=true
                repos_with_changes+=("$repo_name")
            fi
            cd - > /dev/null
        fi
    done

    if [ "$has_uncommitted" = true ]; then
        echo "ERROR: Cannot switch configurations - uncommitted changes detected!"
        echo ""
        echo "Repositories with uncommitted changes:"
        for repo in "${repos_with_changes[@]}"; do
            echo "  • $repo"
        done
        echo ""
        echo "Please commit or stash changes in all repositories before switching configs."
        exit 1
    fi
}

echo "This script will configure the AI Factory for your project."
echo "Please provide the following information:"
echo ""

# Function to prompt for input with default value
prompt_with_default() {
    local prompt="$1"
    local default="$2"
    local result
    
    if [ -n "$default" ]; then
        read -p "$prompt [$default]: " result
        echo "${result:-$default}"
    else
        read -p "$prompt: " result
        while [ -z "$result" ]; do
            echo "This field is required."
            read -p "$prompt: " result
        done
        echo "$result"
    fi
}

# Function to prompt for yes/no
prompt_yes_no() {
    local prompt="$1"
    local default="$2"
    local result
    
    if [ "$default" = "y" ]; then
        read -p "$prompt [Y/n]: " result
        result="${result:-y}"
    else
        read -p "$prompt [y/N]: " result
        result="${result:-n}"
    fi
    
    [[ "$result" =~ ^[Yy] ]] && echo "true" || echo "false"
}

# Collect project information
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  PROJECT INFORMATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

PROJECT_NAME=$(prompt_with_default "Project name" "")

# Check if config file exists and if this project is already configured
if [ -f "$CONFIG_FILE" ]; then
    # Check if project exists in config
    if command -v jq &> /dev/null && jq -e ".projects[\"$PROJECT_NAME\"]" "$CONFIG_FILE" > /dev/null 2>&1; then
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "  EXISTING CONFIGURATION FOUND"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "A configuration for '$PROJECT_NAME' already exists."
        echo ""

        # Check for uncommitted code before allowing switch
        check_uncommitted_code

        echo "Loading existing configuration..."

        # Extract this project's config and write to project.json
        jq ".projects[\"$PROJECT_NAME\"]" "$CONFIG_FILE" > project.json

        echo ""
        echo "✓ Configuration loaded for: $PROJECT_NAME"
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "  OPENING CLAUDE CODE..."
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""

        # Try to copy /install command to clipboard
        if command -v pbcopy &> /dev/null; then
            echo "/install" | pbcopy
            echo "✓ Command '/install' copied to clipboard (paste in Claude Code)"
        elif command -v xclip &> /dev/null; then
            echo "/install" | xclip -selection clipboard
            echo "✓ Command '/install' copied to clipboard (paste in Claude Code)"
        elif command -v clip &> /dev/null; then
            echo "/install" | clip
            echo "✓ Command '/install' copied to clipboard (paste in Claude Code)"
        fi

        echo ""
        echo "Once Claude Code opens, run: /install"
        echo ""
        echo "This will switch to the '$PROJECT_NAME' configuration."
        echo ""
        exit 0
    fi
fi
PROJECT_DESCRIPTION=$(prompt_with_default "Project description" "")
PROJECT_TYPE=$(prompt_with_default "Project type (web-app/api/mobile/library/other)" "web-app")

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  REPOSITORY STRUCTURE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

IS_EXISTING=$(prompt_yes_no "Is this an existing project?" "n")
IS_MULTI_REPO=$(prompt_yes_no "Does this project use multiple repositories?" "n")

if [ "$IS_MULTI_REPO" = "true" ]; then
    echo ""
    echo "Enter repository names (one per line, empty line to finish):"
    REPOS=()
    while true; do
        read -p "Repository name: " repo_name
        [ -z "$repo_name" ] && break
        REPOS+=("$repo_name")
    done
    REPO_LIST=$(printf ',"%s"' "${REPOS[@]}")
    REPO_LIST="[${REPO_LIST:1}]"
else
    SINGLE_REPO=$(prompt_with_default "Repository/folder name in repositories/" "$PROJECT_NAME")
    REPO_LIST="[\"$SINGLE_REPO\"]"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  GENERATING CONFIGURATION..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create project configuration JSON
PROJECT_CONFIG=$(cat << EOF
{
  "project_name": "$PROJECT_NAME",
  "project_description": "$PROJECT_DESCRIPTION",
  "project_type": "$PROJECT_TYPE",
  "is_existing_project": $IS_EXISTING,
  "is_multi_repo": $IS_MULTI_REPO,
  "repositories": $REPO_LIST,
  "installation_date": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF
)

# Save to project.json (temporary, for /install command)
echo "$PROJECT_CONFIG" > project.json

# Update or create the master config file
mkdir -p "$(dirname "$CONFIG_FILE")"

if [ -f "$CONFIG_FILE" ]; then
    # Config file exists - add/update this project
    if command -v jq &> /dev/null; then
        # Use jq to merge
        TEMP_FILE=$(mktemp)
        jq ".projects[\"$PROJECT_NAME\"] = $PROJECT_CONFIG" "$CONFIG_FILE" > "$TEMP_FILE"
        mv "$TEMP_FILE" "$CONFIG_FILE"
    else
        echo "Warning: jq not found. Cannot update existing config file."
        echo "Please install jq or manually update $CONFIG_FILE"
    fi
else
    # Create new config file
    cat > "$CONFIG_FILE" << EOF
{
  "projects": {
    "$PROJECT_NAME": $PROJECT_CONFIG
  }
}
EOF
fi

echo "✓ Configuration saved to project.json"
echo "✓ Configuration stored in $CONFIG_FILE"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  OPENING CLAUDE CODE..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Try to copy /install command to clipboard
if command -v pbcopy &> /dev/null; then
    echo "/install" | pbcopy
    echo "✓ Command '/install' copied to clipboard (paste in Claude Code)"
elif command -v xclip &> /dev/null; then
    echo "/install" | xclip -selection clipboard
    echo "✓ Command '/install' copied to clipboard (paste in Claude Code)"
elif command -v clip &> /dev/null; then
    echo "/install" | clip
    echo "✓ Command '/install' copied to clipboard (paste in Claude Code)"
fi

# Try to open in Claude Code
OPENED=false

# Try using 'cursor' command (Cursor/Claude Code CLI)
if command -v cursor &> /dev/null; then
    cursor . &> /dev/null &
    OPENED=true
    echo "✓ Opening project in Claude Code..."
# Try using 'code' command if cursor not available
elif command -v code &> /dev/null; then
    code . &> /dev/null &
    OPENED=true
    echo "✓ Opening project in VS Code/Cursor..."
# Try macOS 'open' command
elif [[ "$OSTYPE" == "darwin"* ]] && [ -d "/Applications/Cursor.app" ]; then
    open -a "Cursor" . &> /dev/null &
    OPENED=true
    echo "✓ Opening project in Cursor..."
fi

echo ""

if [ "$OPENED" = true ]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  FINAL STEP"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Claude Code should open shortly."
    echo ""
    echo "Once Claude Code opens, run this command:"
    echo ""
    echo "  /install"
    echo ""
    echo "(Command is already in your clipboard - just paste it!)"
else
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  NEXT STEP"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Please open this folder in Claude Code and run:"
    echo ""
    echo "  /install"
    echo ""
fi

echo ""
echo "This will:"
echo "  • Update .claude/project/ files with your project information"
echo "  • Configure the AI Factory for your specific project"
echo "  • Clean up temporary files"
echo ""
echo "After installation, you can start using:"
echo "  /prd [description]  - Create a Product Requirements Document"
echo "  /plan PRD-XXX       - Generate implementation plan"
echo "  /build PRD-XXX TASK-XXX - Implement a task"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

