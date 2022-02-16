#!/bin/bash

TEMPLATES_DIR=$(dirname "$0")/templates

# Check if the name parameter is provided.
function check_parameter() {
  if [ -z "$1" ]; then
    echo "You need to specify a name."
    exit 1
  fi
}

# Check if template exists.
function check_template() {
  if [ ! -d $TEMPLATES_DIR/$1 ]; then
    echo "No such template."
    exit 1
  fi
}

# Create template from current folder.
function create_template() {
  mkdir $TEMPLATES_DIR/$1
  cp $PWD/* $TEMPLATES_DIR/$1
  echo "Successfully $2 template \"$1\" from the current folder."
}

# Wait for user confirmation.
function confirm() {
  read -p "Continue? [y/N] "

  if [[ ! $REPLY =~ [yY] ]]; then
    echo "Aborting."
    exit 1
  fi
}

# Print modele option
function print_option() {
  echo -e "\tmodele $1\t$2"
}

if [ -z "$1" ]; then
  echo "No template specified."
  exit 1
fi

if [ ! -z $3 ]; then
  echo "Too many parameters."
  exit 1
fi

# Create new template
if [ $1 == "new" ]; then
  check_parameter $2

  # Check if template already exists.
  if [ -d $TEMPLATES_DIR/$2 ]; then
    echo "The template \"$2\" already exists. Remove it first using \"modele remove $2\" or update it using \"modele update $2\"."
    exit 1
  fi

  # Create new template from current foder.
  create_template $2 created
  exit 0
fi

# Update template
if [ $1 == "update" ]; then
  check_parameter $2
  check_template $2

  # Ask for confirmation.
  if [ ! -z "$(ls -A $PWD)" ]; then
    echo "You are about to overwrite a template."
    confirm
  fi

  rm -rf $TEMPLATES_DIR/$2
  create_template $2 updated
  exit 0
fi

# Delete template
if [ $1 == "remove" ]; then
  check_parameter $2
  check_template $2

  # Ask for confirmation.
  if [ ! -z "$(ls -A $PWD)" ]; then
    echo "You are about to remove a template."
    confirm
  fi

  rm -rf $TEMPLATES_DIR/$2
  echo "Successfully removed \"$2\"."
  exit 0
fi

# Create project from template
if [ $1 == "create" ]; then
  check_template $2

  # Ask for confirmation if folder not empty.
  if [ ! -z "$(ls -A $PWD)" ]; then
    echo "This folder is not empty."
    confirm
  fi

  # Create project from template
  cp -r $TEMPLATES_DIR/$2/* $PWD
  echo "Successfully created project from template."
  exit 0
fi

# List all templates
if [ $1 == "list" ]; then
  echo "Your templates:"
  ls -t -1 $TEMPLATES_DIR
  exit 0
fi

# Create project from template
if [ $1 == "help" ]; then
  check_template $2

  echo -e "Modele options:\n"
  print_option "new    <template>" "Create new template from current folder."
  print_option "update <template>" "Update an existing template."
  print_option "remove <template>" "Delete a template."
  print_option "create <template>" "Generate a new project from a template."
  print_option "list             " "List all templates."
  echo -e "\nIf no template is specified, modele will default to the current folder."
  echo -e "Modele will ask you for confirmation before deleting, modifying or overwriting projects or templates."
  echo "Templates are stored under \"$TEMPLATES_DIR\"."
fi
