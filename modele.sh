#!/bin/bash

TEMPLATES_DIR=$(dirname "$0")/templates

if [ -z "$1" ]; then
  echo "No template specified."
  exit 1
fi

# Create new template
if [ $1 == "new" ]; then
  # Check if the name parameter is provided.
  if [ -z "$2" ]; then
    echo "You need to specify a name."
    exit 1
  fi

  # Check if template already exists.
  if [ -d $TEMPLATES_DIR/$2 ]; then
    echo "The template \"$2\" already exists. Remove it first using \"modele remove $2\" or update it using \"modele update $2\"."
    exit 1
  fi

  # Create new template from current foder.
  mkdir $TEMPLATES_DIR/$2
  cp $PWD/* $TEMPLATES_DIR/$2
  echo "Successfully created template \"$2\" from the current folder."
  exit 0
fi

# Update template
if [ $1 == "new" ]; then
  # Check if the name parameter is provided.
  if [ -z "$2" ]; then
    echo "You need to specify a name."
    exit 1
  fi

  # Check if template exists.
  if [ ! -d $TEMPLATES_DIR/$2 ]; then
    echo "No such template."
    exit 1
  fi

  # Create new template from current foder.
  rm -rf $TEMPLATES_DIR/$2
  mkdir $TEMPLATES_DIR/$2
  cp $PWD/* $TEMPLATES_DIR/$2
  echo "Successfully updated template \"$2\" from the current folder."
  exit 0
fi

# Check if template exists.
if [ ! -d "$TEMPLATES_DIR/$1" ]; then
  echo "No such template."
  exit 1
fi

# Ask for confirmation if folder not empty.
if [ ! -z "$(ls -A $PWD)" ]; then
  read -p "This folder is not empty. Continue? [Y/n] "

  if [ ! $REPLY == ^[Yy]$ ]; then
    echo "Abort. No changes were made."
    exit 1
  fi
fi

cp -r $TEMPLATES_DIR/$1/* $PWD
echo "Successfully created project from template."
exit 0
