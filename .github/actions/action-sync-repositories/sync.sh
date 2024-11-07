#!/bin/bash

function checkAndPush() {
    cd "$1" || exit
    git add .
    git diff-index --quiet HEAD || (git commit -m "ci: Sync workflows" && git push origin ci/sync)
    cd ../
}

function cloneRepo() {
    git clone "https://$PAT@github.com/naudvard/$1.git"
}

function sync() {
    jq -c '.[]' "$source/$syncJsonPath" | while read -r repo; do
      repo_name=$(echo "$repo" | jq -r '.repository')
      cloneRepo "$repo_name" # clone the destination repository

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
echo "$PWD"
echo "$(ls)"
cd ../ || exit
echo "$PWD"
echo "$(ls)"

sync