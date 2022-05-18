#!/bin/sh

echo "Setting up gem credentials..."
set +x
mkdir -p ~/.gem

cat << EOF > ~/.gem/credentials
---
:github: Bearer ${GITHUB_TOKEN}
:rubygems_api_key: ${RUBYGEMS_API_KEY}
EOF

chmod 0600 ~/.gem/credentials
set -x

echo "Installing dependencies..."
bundle install > /dev/null

user_command="${USER_COMMAND}"
eval $user_command

echo "Running gem release task..."
release_command="${RELEASE_COMMAND:-rake release}"
exec $release_command
