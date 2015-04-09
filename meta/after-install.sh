#!/bin/sh

USER=serf

# Add user
if ! id -u $USER > /dev/null 2>&1
then
  useradd -M $USER
fi
