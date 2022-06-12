#!/bin/sh
# Exit on fail
set -e

composer install --no-scripts
composer dumpautoload

# Run crontab
crond start

php-fpm
# Finally call command issued to the docker service
exec "$@"
