#!/bin/bash 

# Die if we fail to do anything
set -e

# Check dependencies
if ! tmux -V | grep -qE '^tmux ([3-9]\.|[3-9][0-9]+|[3-9]\.[0-9]+[a-z])'; then
  echo "Tmux must be installed and at least v3.1"
  exit 1
fi

if command -v nvim &>/dev/null; then
  echo "nvim must be installed"
  exit 1
fi

# Set the GitHub repository and folder details
repo_owner="dobs97"
repo_name="config"
folder_path=".config"

# Set the API endpoint URL
api_url="https://api.github.com/repos/$repo_owner/$repo_name/contents/$folder_path"

# Send a GET request to the API and retrieve the response
response=$(curl -s "$api_url")

# Check if the request was successful
if [ $? -eq 0 ]; then
	# Parse the response to extract the file names
	file_names=$(echo "$response" | jq -r '.[].name')
else
	echo "Failed to retrieve folder contents from GitHub"
	exit 1
fi

# Create directories
config_dir="$HOME/.config"

if [ ! -d "$config_dir" ]; then
    mkdir -p "$config_dir"
    echo ".config doesn't already exist, creating"
else
    echo ".config already exists!"
fi

# Don't blat any existing config incase this has been run by mistake
for file_name in $file_names; do
  if [ -d "$file_name" ]; then
    echo ".config/$file_name already exists, please delete to continue"
    exit 1
  fi
done
