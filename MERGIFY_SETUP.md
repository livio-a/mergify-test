# Mergify Setup Documentation

## Prerequisites

1. **Install Mergify App**: The Mergify GitHub App must be installed on your repository
   - Visit https://github.com/apps/mergify
   - Install and configure for your repository

2. **Create Maintenance Branches**: 
   ```bash
   # Create and push maintenance branches
   git checkout main
   git checkout -b release-1.0
   git push origin release-1.0
   
   git checkout main
   git checkout -b release-2.0
   git push origin release-2.0
   ```

3. **Branch Protection** (Recommended):
   - Protect main and release branches
   - Require PR reviews
   - Require status checks to pass

## Configuration Details

### `.mergify.yml` Rules

1. **Backport Rules**: Triggered by labels on merged PRs
   - `backport-to-release-1.0`
   - `backport-to-release-2.0` 
   - `backport-to-all`

2. **Auto-merge**: Backport PRs are automatically merged when:
   - Created by mergify[bot]
   - At least 1 approval
   - No change requests
   - CI checks pass

3. **Conflict Handling**: Automatic comments when backports fail

### Workflow

1. **Developer**: Creates PR with backport labels
2. **Mergify**: Automatically creates backport PRs after merge
3. **Maintainer**: Reviews and approves backport PRs
4. **Mergify**: Auto-merges approved backport PRs

## Testing

Use the provided helper script:
```bash
./mergify-helper.sh validate    # Check configuration
./mergify-helper.sh status      # Show repository status
./mergify-helper.sh help        # Show all commands
```

## Troubleshooting

### Common Issues

1. **Mergify not creating backports**:
   - Check that Mergify app is installed
   - Verify labels are correct
   - Ensure target branches exist

2. **Backport conflicts**:
   - Mergify will comment on the original PR
   - Manual cherry-pick required
   - Create manual backport PR

3. **Auto-merge not working**:
   - Check branch protection rules
   - Verify CI status check name matches config
   - Ensure proper approvals

### Debug Commands

```bash
# Check Mergify status
curl -H "Authorization: token YOUR_TOKEN" \
     https://api.github.com/repos/OWNER/REPO/commits/SHA/status

# View Mergify queue
# Available in Mergify dashboard
```

## Best Practices

1. **Label Early**: Add backport labels before merging
2. **Small PRs**: Easier to backport without conflicts  
3. **Clean History**: Use squash merging for cleaner backports
4. **Test Backports**: Run CI on maintenance branches
5. **Document**: Note which releases include which changes