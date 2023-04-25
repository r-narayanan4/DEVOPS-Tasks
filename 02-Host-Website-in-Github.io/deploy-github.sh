#!/bin/bash

# Set the repository URL
REPO_URL="URL"

# Set the branch to update
BRANCH="main"

# Set the commit message
COMMIT_MESSAGE="Update index.html and styles.css"

# Clone the repository to a temporary directory
TEMP_DIR="$HOME/github"
mkdir -p $TEMP_DIR
git clone -b $BRANCH $REPO_URL $TEMP_DIR

# Copy the updated files to the temporary directory
cp index.html $TEMP_DIR/
cp styles.css $TEMP_DIR/

# Commit and push the changes
cd $TEMP_DIR
git add index.html styles.css
git commit -m "$COMMIT_MESSAGE"
git push origin $BRANCH

# Cleanup
rm -rf $TEMP_DIR
