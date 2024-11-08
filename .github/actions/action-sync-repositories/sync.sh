#!/bin/bash
set -e

function checkout() {
  if [ "$(git branch -a | grep -c 'ci/sync')" -ge 1 ] ; then
    echo "Branch ci/sync already exists, deleting"
    git branch -dr origin/ci/sync
    git remote prune origin
  fi
  echo "Creating branch ci/sync"
  git checkout -b ci/sync
}

function push() {
  echo "Pushing changes to the repository"
  git commit -m "ci: Sync workflows"
  git push origin ci/sync
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
      cloneRepo "$repo_name"

      echo "$repo" | jq -c '.sync[]' | while read -r sync; do
        from=$(echo "$sync" | jq -r '.from')
        to=$(echo "$sync" | jq -r '.to')

        copyFile "$source/$from" "$repo_name/$to"
      done

      checkoutAndPush "$repo_name"
      rm -rf "$repo_name"
    done
}

source="$1"
syncJsonPath="$2"

cd ../ || exit
sync