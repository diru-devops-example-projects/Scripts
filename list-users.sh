#!/bin/bash

################
# Author: Hadiru
# Description: This scripts lists all users in a github organization.
# Version: 1
# Date: 20/05/2024
# Arguments: username and token
################

# Github api url
API_URL="https://api.github.com"

# Github username and personal access token
USERNAME=$username
TOKEN=$token

# Github repo owner and repo
REPO_OWNER=$1
REPO_NAME=$2

# Function to make api request to Github
function github_api_get {
 	local endpoint=$1
	local url="${API_URL}/${endpoint}"

	# send a request to github api
 	return curl -s -u "${USERNAME}:${TOKEN}" "${url}:"
 }

 function list_users_with_pull_access {
	local endpoint="/repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

	# fetch the list of collaborators
	collaborators="$(github_api_get "$endpoint" | jq '.[] | select(.permissions.pull == true) | .login')"
	
	# display the list collaborators with pull access
	if [[ -z $collaborators ]]; then
		echo "No user with pull access for ${REPO_OWNER}/${REPO_NAME}"
	else
		echo "Users with pull access to ${REPO_OWNER}/${REPO_NAME}:"
        	echo "$collaborators"
	fi
}

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_pull_access

