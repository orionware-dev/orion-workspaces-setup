#!/bin/bash
CurrentDirectory=`pwd`
OrionLibrariesRepoPath=/c/workspaces/orion/platform/orionware-libraries
echo Committing Orion Libraries
cd $OrionLibrariesRepoPath
read commitMessage
git add -A
git commit --all -m $commitMessage
git push