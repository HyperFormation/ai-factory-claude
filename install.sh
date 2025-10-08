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

        # Create symlinks from loaded config
        SYMLINKS_TO_CREATE=false

        # Check if there are any symlinks to create
        if command -v jq &> /dev/null; then
            while IFS=$'\t' read -r repo_name symlink_target; do
                if [ "$symlink_target" != "null" ] && [ -n "$symlink_target" ]; then
                    SYMLINKS_TO_CREATE=true
                    break
                fi
            done < <(jq -r '.repositories as $repos | .repository_symlinks as $links | range(0; $repos | length) | "\($repos[.])	\($links[.])"' project.json)
        fi

        if [ "$SYMLINKS_TO_CREATE" = true ]; then
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "  CREATING SYMLINKS..."
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""

            mkdir -p "$REPO_DIR"

            while IFS=$'\t' read -r repo_name symlink_target; do
                if [ "$symlink_target" != "null" ] && [ -n "$symlink_target" ]; then
                    symlink_path="$REPO_DIR/$repo_name"

                    # Remove existing symlink if it exists
                    if [ -L "$symlink_path" ]; then
                        rm "$symlink_path"
                        echo "Removed existing symlink: $symlink_path"
                    elif [ -d "$symlink_path" ]; then
                        echo "Warning: Directory already exists at $symlink_path (not overwriting)"
                        continue
                    fi

                    # Create symlink
                    if ln -s "$symlink_target" "$symlink_path" 2>/dev/null; then
                        echo "✓ Created symlink: $repo_name -> $symlink_target"
                    else
                        echo "✗ Failed to create symlink: $repo_name -> $symlink_target"
                    fi
                fi
            done < <(jq -r '.repositories as $repos | .repository_symlinks as $links | range(0; $repos | length) | "\($repos[.])	\($links[.])"' project.json)
        fi

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

# Repository configuration with symlink support
REPOS=()
REPO_SYMLINKS=()

if [ "$IS_MULTI_REPO" = "true" ]; then
    echo ""
    echo "Enter repository information (empty repository name to finish):"
    while true; do
        echo ""
        read -p "Repository name: " repo_name
        [ -z "$repo_name" ] && break

        echo ""
        echo "How will you manage '$repo_name'?"
        echo "  1) Manually clone/create repository"
        echo "  2) Create symlink to existing repository"
        read -p "Choose [1/2]: " repo_option

        if [ "$repo_option" = "2" ]; then
            read -p "Path to existing repository: " symlink_path
            # Expand tilde and make absolute
            symlink_path="${symlink_path/#\~/$HOME}"
            symlink_path=$(cd "$(dirname "$symlink_path")" 2>/dev/null && pwd)/$(basename "$symlink_path") || symlink_path="$symlink_path"

            if [ ! -d "$symlink_path" ]; then
                echo "Warning: Path '$symlink_path' does not exist. Symlink will be created anyway."
            fi

            REPOS+=("$repo_name")
            REPO_SYMLINKS+=("$symlink_path")
        else
            REPOS+=("$repo_name")
            REPO_SYMLINKS+=("")
        fi
    done
else
    SINGLE_REPO=$(prompt_with_default "Repository/folder name in repositories/" "$PROJECT_NAME")

    echo ""
    echo "How will you manage '$SINGLE_REPO'?"
    echo "  1) Manually clone/create repository"
    echo "  2) Create symlink to existing repository"
    read -p "Choose [1/2]: " repo_option

    if [ "$repo_option" = "2" ]; then
        read -p "Path to existing repository: " symlink_path
        # Expand tilde and make absolute
        symlink_path="${symlink_path/#\~/$HOME}"
        symlink_path=$(cd "$(dirname "$symlink_path")" 2>/dev/null && pwd)/$(basename "$symlink_path") || symlink_path="$symlink_path"

        if [ ! -d "$symlink_path" ]; then
            echo "Warning: Path '$symlink_path' does not exist. Symlink will be created anyway."
        fi

        REPOS=("$SINGLE_REPO")
        REPO_SYMLINKS=("$symlink_path")
    else
        REPOS=("$SINGLE_REPO")
        REPO_SYMLINKS=("")
    fi
fi

# Build JSON arrays for repositories and symlinks
REPO_LIST="["
SYMLINK_LIST="["
for i in "${!REPOS[@]}"; do
    if [ $i -gt 0 ]; then
        REPO_LIST+=","
        SYMLINK_LIST+=","
    fi
    REPO_LIST+="\"${REPOS[$i]}\""
    if [ -n "${REPO_SYMLINKS[$i]}" ]; then
        SYMLINK_LIST+="\"${REPO_SYMLINKS[$i]}\""
    else
        SYMLINK_LIST+="null"
    fi
done
REPO_LIST+="]"
SYMLINK_LIST+="]"

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
  "repository_symlinks": $SYMLINK_LIST,
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

# Create symlinks if configured
SYMLINKS_CREATED=false
for i in "${!REPOS[@]}"; do
    if [ -n "${REPO_SYMLINKS[$i]}" ]; then
        if [ "$SYMLINKS_CREATED" = false ]; then
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "  CREATING SYMLINKS..."
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            SYMLINKS_CREATED=true
            mkdir -p "$REPO_DIR"
        fi

        repo_name="${REPOS[$i]}"
        symlink_target="${REPO_SYMLINKS[$i]}"
        symlink_path="$REPO_DIR/$repo_name"

        # Remove existing symlink or directory if it exists
        if [ -L "$symlink_path" ]; then
            rm "$symlink_path"
            echo "Removed existing symlink: $symlink_path"
        elif [ -d "$symlink_path" ]; then
            echo "Warning: Directory already exists at $symlink_path (not overwriting)"
            continue
        fi

        # Create symlink
        if ln -s "$symlink_target" "$symlink_path" 2>/dev/null; then
            echo "✓ Created symlink: $repo_name -> $symlink_target"
        else
            echo "✗ Failed to create symlink: $repo_name -> $symlink_target"
        fi
    fi
done

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

