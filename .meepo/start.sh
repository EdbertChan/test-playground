#!/bin/bash
set -e

echo '=== Running Claude with prompt ==='
echo ''
echo 'Prompt:'
echo 'Update hello.txt to contain a formal business greeting: '\''Good day, esteemed user. Welcome to our application.'\''

After making changes, commit and push:
```bash
git add -A
git commit -m '\''Formal greeting experiment'\''
git push -u origin HEAD
```'
echo ''
echo '=== Claude Output ==='
claude --dangerously-skip-permissions --print 'Update hello.txt to contain a formal business greeting: '\''Good day, esteemed user. Welcome to our application.'\''

After making changes, commit and push:
```bash
git add -A
git commit -m '\''Formal greeting experiment'\''
git push -u origin HEAD
```'
echo ''
echo '=== Pushing experiment branch to remote ==='
CURRENT_BRANCH=$(git branch --show-current)
if [ -n "$CURRENT_BRANCH" ] && [ "$CURRENT_BRANCH" != "feature/claude-test-20260112-230435/formal" ]; then
  git push -u origin "$CURRENT_BRANCH" 2>&1 || echo 'Push failed (may not have changes)'
  echo "✓ Pushed $CURRENT_BRANCH to remote"
fi
