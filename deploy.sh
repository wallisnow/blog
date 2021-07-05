#!/bin/sh
# If a command fails then the deploy stops
set -e
printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"
# Build the project.
hugo -D # if using a theme, replace with `hugo -t <YOURTHEME>`
cd public
# Commit changes.
git add .
msg="rebuilding my blog site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"
git pull
# Push source and build repos.
git push