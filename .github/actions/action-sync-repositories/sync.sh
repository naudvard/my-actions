#!/bin/bash
set -e

function checkout() {
  git branch -a | grep "ci/sync" && git checkout ci/sync || git checkout -b ci/sync
}

function push() {
    git commit -m "ci: Sync workflows" && git push origin ci/sync
}

function checkoutAndPush() {
    cd "$1" || exit

    checkout
    git add .
    git diff-index --quiet HEAD || push
    cd ../
}

function cloneRepo() {
    git clone "https://$PAT@github.com/naudvard/$1.git"
}

function copyFile() {
  mkdir -p "$(dirname "$2")"
  cp -rf "$1" "$2"
}

function sync() {
    jq -c '.[]' "$source/$syncJsonPath" | while read -r repo; do
      repo_name=$(echo "$repo" | jq -r '.repository')
      cloneRepo "$repo_name" # clone the destination repository

      echo "$repo" | jq -c '.sync[]' | while read -r sync; do
        from=$(echo "$sync" | jq -r '.from')
        to=$(echo "$sync" | jq -r '.to')

        copyFile "$source/$from" "$repo_name/$to"
      done

      # Push the changes to ci/sync branch
      checkoutAndPush "$repo_name"
      # Remove the repository folder
      rm -rf "$repo_name"
    done
}

source="$1"
syncJsonPath="$2"

cd ../ || exit
sync