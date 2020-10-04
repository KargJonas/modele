#!/bin/bash

TEMPLATES_DIR=$(dirname "$0")/templates

if [ -z "$1" ]; then
  echo "No template specified."
else
  if [ -d "$TEMPLATES_DIR/$1" ]; then
    cp -r $TEMPLATES_DIR/$1/* $PWD
    echo "Successfully created project from template."
  else
    echo "No such template."
  fi
fi
