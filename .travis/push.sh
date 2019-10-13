#!/bin/sh

TRAVIS_USERNAME="Travis CI"
LAST_COMMITTER=`git log -1 --pretty=format:'%an'`

echo "Checking if '$LAST_COMMITTER' is '$TRAVIS_USERNAME'"
if [ "$LAST_COMMITTER" = "$TRAVIS_USERNAME" ]; then
	echo Travis user did last commit. Not pushing.
	exit
fi

git config --global user.email "travis@travis-ci.org"
git config --global user.name "$TRAVIS_USERNAME"

git checkout -b travis-temp
git add *.pdf
git commit --message "Travis build"
git checkout master
git merge travis-temp

git remote add origin-temp https://${GH_TOKEN}@github.com/jczaja/test-task-management.git
git push --set-upstream origin-temp
