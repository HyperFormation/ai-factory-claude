# Project Overview

## Vision

This project serves as an AI Factory - a standardized framework for building software using Claude Code and sub-agents. The factory coordinates planning, coding, testing, and documentation through a structured workflow.

## Goals

- **Systematic Development**: Track PRDs, tasks, and implementation status in a structured way
- **Persistent Context**: Maintain project scope, architecture, and goals across sessions
- **Quality Assurance**: Use sub-agents to coordinate planning → coding → testing → documentation loops
- **Repeatability**: Create a template that can be reused for any software project

## Core Components

1. **Sub-Agents**: Specialized agents for PRD writing, planning, coding, design consistency, testing, and git management
2. **Slash Commands**: Streamlined workflows (`/prd`, `/plan`, `/build`) for common operations
3. **PRD Management**: Structured tracking of Product Requirements Documents and their associated tasks
4. **Repository Management**: Isolated workspace for actual implementation code

## Success Criteria

- Clear separation between factory infrastructure and project code
- Traceable lineage from PRD → Plan → Tasks → Implementation
- Consistent quality through automated testing and review loops
- Comprehensive documentation of all changes and decisions

