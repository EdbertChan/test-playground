#!/bin/bash
set -e

# Configure SSH for git
if [ -d /home/node/.ssh ]; then
  chmod 700 /home/node/.ssh 2>/dev/null || true
  chmod 600 /home/node/.ssh/* 2>/dev/null || true
  ssh-keyscan github.com >> /home/node/.ssh/known_hosts 2>/dev/null || true
  # Fix SSH agent socket permissions
  if [ -S /ssh-agent ]; then
    sudo chmod 666 /ssh-agent 2>/dev/null || true
  fi
  echo 'SSH keys configured'
fi

# Convert HTTPS remote to SSH
if [ -d .git ]; then
  REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo '')
  if [[ $REMOTE_URL == https://github.com/* ]]; then
    SSH_URL=$(echo $REMOTE_URL | sed 's|https://github.com/|git@github.com:|')
    git remote set-url origin $SSH_URL
    echo "Converted remote to SSH: $SSH_URL"
  fi
fi

# Configure git user
git config --global user.name 'Edbert Chan' || true
git config --global user.email 'edbert@uber.com' || true

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
if [ -z "$CURRENT_BRANCH" ]; then
  echo "ERROR: No current branch found"
  exit 1
fi
echo "Pushing branch: $CURRENT_BRANCH"
git push -u origin "$CURRENT_BRANCH" 2>&1
echo "✓ Pushed $CURRENT_BRANCH to remote"
