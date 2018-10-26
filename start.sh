#!/bin/bash

export MIX_ENV=prod
export PORT=4795

echo "Stopping old copy of app, if any..."

_build/prod/rel/task_tracker/bin/task_tracker stop || true

echo "Starting app..."

# TODO: You want start.

_build/prod/rel/task_tracker/bin/task_tracker start

# TODO: Add a cron rule or systemd service file
#       to start your app on system boot.