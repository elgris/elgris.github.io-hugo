#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

chmod 600 $SSH_KEY
eval `ssh-agent -s`
ssh-add $SSH_KEY


# Generate codebase
cd public
git checkout -f master
cd ..
hugo
cd public

# set up git
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"
git remote set-url --push origin git@github.com:"$GIT_NAME"/"$GIT_NAME".github.io.git

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back
cd ..