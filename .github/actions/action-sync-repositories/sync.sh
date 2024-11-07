#!/bin/bash

function checkAndPush() {
    cd "$1" || exit
    echo "Checking for changes in $1"
    echo "$(ls)"
    git add .
    git diff-index --quiet HEAD || (git commit -m "ci: Sync workflows" && git push origin ci/sync)
    cd ../
    echo "back"
    echo "$(ls)"
}

function cloneRepo() {
    git clone "https://$PAT@github.com/naudvard/$1.git"
}

function sync() {
    jq -c '.[]' "$source/$syncJsonPath" | while read -r repo; do
      repo_name=$(echo "$repo" | jq -r '.repository')
      cloneRepo "$repo_name" # clone the destination repository

      echo "cloning $repo_name"
      echo "$(ls)"

      echo "$repo" | jq -r '.sync' | while read -r sync; do
        from=$(echo "$sync" | jq -r '.from')
        to=$(echo "$sync" | jq -r '.to')

        # Copy the files from the source to the destination
        cp -rf "$source/$from" "$repo_name/$to"
      done

      # Push the changes to ci/sync branch
      checkAndPush "$repo_name"
      # Remove the repository folder
      rm -rf "$repo_name"
    done
}

source="$1"
syncJsonPath="$2"
cd ../ || exit
sync