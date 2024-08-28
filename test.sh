#!/bin/bash

echo "below output is from environment variable"
echo $GITHUB_WORKSPACE
echo $accountUsername



#variables to pass to script
#$1 = variablesFile = absolute path to variables file
#This script expects 4 folders to be present in ${GITHUB_WORKSPACE} like:
#1. Artifact-JAR - Contains all the jar files generated from maven build
#2. Artifact-WorkflowFiles - Contains all rendered workflow files to be deployed
#3. TBD
#4. TBD

function abort_on_failure() {
    echo $1
    exit 1
}

function prepareVariableFile () {
    variablesFile=$1
    pathToVariablesFile=$(dirname "$variablesFile")
    cd $pathToVariablesFile
    jq --arg accountUsername "$accountUsername" --arg accountPwd "$accountPwd" '.account_username = $accountUsername | .account_password = $accountPwd' < $variablesFile > temp.json
    cp -f temp.json $variablesFile
}

prepareVariableFile $GITHUB_WORKSPACE/properties.json
cat $GITHUB_WORKSPACE/properties.json
