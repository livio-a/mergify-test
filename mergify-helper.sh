#!/bin/bash

# Mergify Backport Helper Script
# This script helps maintainers work with backports and maintenance branches

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cd "$SCRIPT_DIR"

show_help() {
    cat << EOF
Mergify Backport Helper

Usage: $0 [COMMAND]

Commands:
    status       Show status of maintenance branches
    create-branches    Create maintenance branches (release-1.0, release-2.0)
    validate     Validate Mergify configuration
    help         Show this help message

Examples:
    $0 status              # Show branch status
    $0 create-branches     # Create maintenance branches
    $0 validate           # Check Mergify config

EOF
}

show_status() {
    echo "🔍 Checking repository status..."
    echo
    
    echo "📋 Current branch:"
    git branch --show-current
    echo
    
    echo "📋 All branches:"
    git branch -a
    echo
    
    echo "📋 Recent commits:"
    git log --oneline -5
    echo
    
    echo "📋 Mergify configuration:"
    if [ -f ".mergify.yml" ]; then
        echo "✅ .mergify.yml exists"
        echo "📊 Configuration summary:"
        grep -E "^  - name:" .mergify.yml | sed 's/^  - name: /  • /'
    else
        echo "❌ .mergify.yml not found"
    fi
}

create_branches() {
    echo "🌿 Creating maintenance branches..."
    
    # Ensure we're on main branch
    if ! git rev-parse --verify main >/dev/null 2>&1; then
        echo "❌ Main branch not found. Cannot create maintenance branches."
        exit 1
    fi
    
    git checkout main
    
    # Create release-1.0 if it doesn't exist
    if ! git rev-parse --verify release-1.0 >/dev/null 2>&1; then
        echo "Creating release-1.0 branch..."
        git checkout -b release-1.0
        echo "✅ Created release-1.0 branch"
        git checkout main
    else
        echo "ℹ️  release-1.0 already exists"
    fi
    
    # Create release-2.0 if it doesn't exist
    if ! git rev-parse --verify release-2.0 >/dev/null 2>&1; then
        echo "Creating release-2.0 branch..."
        git checkout -b release-2.0
        echo "✅ Created release-2.0 branch"
        git checkout main
    else
        echo "ℹ️  release-2.0 already exists"
    fi
    
    echo "🎉 Maintenance branches ready!"
    echo "Note: Push branches to remote when ready: git push origin release-1.0 release-2.0"
}

validate_config() {
    echo "🔍 Validating Mergify configuration..."
    
    if [ ! -f ".mergify.yml" ]; then
        echo "❌ .mergify.yml not found"
        exit 1
    fi
    
    # Check if Python and PyYAML are available for validation
    if command -v python3 >/dev/null 2>&1; then
        if python3 -c "import yaml" 2>/dev/null; then
            python3 -c "import yaml; yaml.safe_load(open('.mergify.yml'))"
            echo "✅ Mergify YAML syntax is valid"
        else
            echo "⚠️  PyYAML not available, skipping syntax validation"
        fi
    else
        echo "⚠️  Python not available, skipping syntax validation"
    fi
    
    # Check for required sections
    echo "🔍 Checking configuration structure..."
    
    if grep -q "pull_request_rules:" .mergify.yml; then
        echo "✅ Found pull_request_rules section"
    else
        echo "❌ Missing pull_request_rules section"
    fi
    
    if grep -q "backport:" .mergify.yml; then
        echo "✅ Found backport actions"
    else
        echo "❌ Missing backport actions"
    fi
    
    echo "✅ Configuration validation complete"
}

# Main script logic
case "${1:-help}" in
    status)
        show_status
        ;;
    create-branches)
        create_branches
        ;;
    validate)
        validate_config
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        echo
        show_help
        exit 1
        ;;
esac