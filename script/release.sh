#!/bin/bash

cd "$(dirname "$0")/.."

current_version=`lein pprint :version`
new_version=$1
release_branch=$2

# Update to release version.
git checkout master
lein set-version $new_version
sed -i '' "s/$current_version/$new_version/g" README.md

git commit -am "Release version $new_version."
git tag $new_version
git push origin $new_version
git push origin master

# Merge artifacts into release branch.
git checkout $release_branch
git merge master
git push origin $release_branch
