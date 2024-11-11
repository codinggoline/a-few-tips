#!/bin/bash

message=$1
branch=$2

git add .

git status

git commit -m "$message"

git status

git push push origin "$branch"

# ========================= OR ===========================
#update_and_push() {
#	git stash save "I am the one who stashes"
#	git checkout master
#	git pull origin master
#	git stash apply
#	git add .
#	git commit -m "Pushed on $(date)"
#	git push origin master
#	git checkout $(git rev-parse --abbrev-ref HEAD)
#	echo "Pushed on $(date)"
#}

#while true; do {
#	update_and_push()
#	sleep 300 # 5 minutes
#}
