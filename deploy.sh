#!/bin/sh
# If a command fails then the deploy stops
set -e

push_all_code="${1}"

if [ "$push_all_code" = "all"  ]; then
  git add .
  git commit -m "update my blog articles $(date)"
  git pull
  git push
fi

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"
# Build the project.
hugo -D # if using a theme, replace with `hugo -t <YOURTHEME>`
cd public
# This step to avoid conflict when switch machine to commit code
git pull
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