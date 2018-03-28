#!/usr/bin/env bash

WORKING_DIRECTORY=$(realpath $0 | xargs dirname)
PUBLIC_WWW='/var/www/website'
WEBSITE='https://www.whyrl.fr'

sudo hugo -s $WORKING_DIRECTORY -d $PUBLIC_WWW -b $WEBSITE
sudo chown www-data:www-data -R $PUBLIC_WWW
