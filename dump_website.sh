#!/usr/bin/env bash

UPSTREAM="origin/master"
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

WORKING_DIRECTORY=$(realpath $0 | xargs dirname)
PUBLIC_WWW='/var/www/website'
WEBSITE='https://www.whyrl.fr'

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
    git pull --prune
elif [ $REMOTE = $BASE ]; then
    echo ""
    echo "!!! Need to push"
    echo ""
else
    echo ""
    echo '/!\ Diverged'
    echo ""
    exit 1
fi

sudo hugo -s $WORKING_DIRECTORY -d $PUBLIC_WWW -b $WEBSITE
sudo chown www-data:www-data -R $PUBLIC_WWW

rsync -apv ${PUBLIC_WWW}/* mutu:~/mutu/
