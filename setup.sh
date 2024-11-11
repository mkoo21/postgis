#!/bin/sh

if [ ! -f /setup/setup_complete ]; then
  echo "First time startup; seeding db..."
  createdb -U postgres db; psql -U postgres -d db -f /setup/setup.sql && touch /setup/setup_complete
else
  echo "Restart detected. Skipping db setup..."
fi

exec "$@"
