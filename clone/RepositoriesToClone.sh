#!/bin/bash
CurrentDirectory=`pwd`
. $CurrentDirectory/RepositoriesToClone.prop
. $CurrentDirectory/GitHubCredentials.prop
OrionEclipseWorkspacesDir=$orion_eclipse_workspaces_dir
OrionDevDir=$orion_dev_dir
OrionLibrariesDir=$orion_libraries_dir
GitHub=github.com
GitHubUsername=$github_username:$github_password@$GitHub


function cloneOrionEclipseWorkspaceRepository()
{
    OrionEclipseWorkspaceRepository=orion_eclipse_workspace_repository_$1
    OrionEclipseWorkspaceRepositoryTemp=${!OrionEclipseWorkspaceRepository}
    OrionEclipseWorkspaceRepositoryWithGitHubCredentials=${OrionEclipseWorkspaceRepositoryTemp/$GitHub/$GitHubUsername}
    OrionEclipseWorkspaceRepositoryDir=orion_eclipse_workspace_repository_dir_$1
    OrionEclipseWorkspaceRepositoryDirToCloneIn="$OrionEclipseWorkspacesDir/${!OrionEclipseWorkspaceRepositoryDir}"
    git clone $OrionEclipseWorkspaceRepositoryWithGitHubCredentials $OrionEclipseWorkspaceRepositoryDirToCloneIn
}


function cloneOrionDevRepository()
{
    OrionDevRepository=orion_dev_repository_$1
    OrionDevRepositoryTemp=${!OrionDevRepository}
    OrionDevRepositoryWithGitHubCredentials=${OrionDevRepositoryTemp/$GitHub/$GitHubUsername}
    OrionDevRepositoryDir=orion_dev_repository_dir_$1
    OrionDevRepositoryDirToCloneIn="$OrionDevDir/${!OrionDevRepositoryDir}"
    git clone $OrionDevRepositoryWithGitHubCredentials $OrionDevRepositoryDirToCloneIn
}


function cloneOrionLibrariesRepository()
{
    OrionLibrariesRepository=orion_libraries_repository_$1
    OrionLibrariesRepositoryTemp=${!OrionLibrariesRepository}
    OrionLibrariesRepositoryWithGitHubCredentials=${OrionLibrariesRepositoryTemp/$GitHub/$GitHubUsername}
    OrionLibrariesRepositoryDir=orion_libraries_repository_dir_$1
    OrionLibrariesRepositoryDirToCloneIn="$OrionLibrariesDir/${!OrionLibrariesRepositoryDir}"
    git clone $OrionLibrariesRepositoryWithGitHubCredentials $OrionLibrariesRepositoryDirToCloneIn
}


for i in $(seq 1 $number_of_orion_eclipse_workspaces_repositories)
do
    (cloneOrionEclipseWorkspaceRepository $i &)
done


for j in $(seq 1 $number_of_orion_dev_repositories)
do
    (cloneOrionDevRepository $j &)
done

for k in $(seq 1 $number_of_orion_libraries_repositories)
do
    (cloneOrionLibrariesRepository $k &)
done