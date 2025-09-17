# mergify-test

A repository to test Mergify's automatic backporting capabilities for merged PRs to maintenance branches.

## Overview

This repository demonstrates how to use [Mergify](https://mergify.io/) to automatically backport merged pull requests to maintenance branches. This is particularly useful for maintaining multiple release versions where bug fixes and features need to be applied to older versions.

## How It Works

### Automatic Backporting

When a PR is merged to the main branch, Mergify can automatically create backport PRs to specified maintenance branches based on labels:

- **`backport-to-release-1.0`** - Creates a backport PR to the `release-1.0` branch
- **`backport-to-release-2.0`** - Creates a backport PR to the `release-2.0` branch  
- **`backport-to-all`** - Creates backport PRs to all maintenance branches

### Configuration

The Mergify configuration is defined in [`.mergify.yml`](.mergify.yml) and includes:

1. **Backport Rules**: Automatically create backport PRs when specific labels are present
2. **Auto-merge**: Automatically merge approved backport PRs that pass CI
3. **Conflict Handling**: Notify maintainers when backports fail due to conflicts
4. **Helper Comments**: Guide contributors on how to request backports

## Usage

### For Contributors

1. **Create your PR** as usual targeting the main branch
2. **Add backport labels** to request backporting:
   ```
   # In the PR description or as labels
   backport-to-release-1.0
   backport-to-release-2.0
   # or
   backport-to-all
   ```
3. **Merge the PR** - Mergify will automatically create backport PRs

### For Maintainers

1. **Review backport PRs** created by Mergify bot
2. **Approve and merge** if the backport is clean
3. **Handle conflicts** manually if automatic backporting fails

## Maintenance Branches

- `release-1.0` - Maintenance branch for version 1.0.x releases
- `release-2.0` - Maintenance branch for version 2.0.x releases

## Example Workflow

1. Developer creates a bug fix PR for main branch
2. PR is labeled with `backport-to-release-1.0`
3. PR gets reviewed and merged
4. Mergify automatically creates a backport PR to `release-1.0`
5. Maintainer reviews and approves the backport PR
6. Mergify automatically merges the approved backport PR

## Testing the Setup

You can test the backporting functionality by:

1. Modifying the Go calculator files (`calculator.go` or `main.go`)
2. Creating a PR with backport labels
3. Merging the PR
4. Observing the automatic backport PRs created by Mergify

## Files

- `.mergify.yml` - Mergify configuration for automatic backporting
- `calculator.go` - Calculator library implementation in Go
- `main.go` - Main application entry point for the calculator demo
- `go.mod` - Go module configuration
- `README.md` - This documentation

## Benefits

- **Automated Workflow**: Reduces manual cherry-picking efforts
- **Consistency**: Ensures all requested backports are created
- **Conflict Detection**: Automatically detects and reports merge conflicts
- **Audit Trail**: Clear history of which changes were backported where
- **Time Saving**: Maintainers focus on reviewing rather than manual backporting