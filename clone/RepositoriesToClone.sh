#!/bin/bash
CurrentDirectory=`pwd`
. $CurrentDirectory/DirectoriesToSetup.prop
. $CurrentDirectory/DevRepositories.prop
. $CurrentDirectory/PlatformRepositories.prop
. $CurrentDirectory/GitHubCredentials.prop
OrionDir=$orion_dir
OrionDevDir=$orion_dev_dir
OrionPlatformDir=$orion_platform_dir
GitHub=github.com
GitHubUsername=$github_username:$github_password@$GitHub
mkdir -p $OrionDir


function cloneOrionDevRepository()
{
    OrionDevRepository=orion_dev_repository_$1
    OrionDevRepositoryTemp=${!OrionDevRepository}
    OrionDevRepositoryWithGitHubCredentials=${OrionDevRepositoryTemp/$GitHub/$GitHubUsername}
    OrionDevRepositoryDir=orion_dev_repository_dir_$1
    OrionDevRepositoryDirToCloneIn=${!OrionDevRepositoryDir}
    git clone $OrionDevRepositoryWithGitHubCredentials $OrionDevRepositoryDirToCloneIn
}


function cloneOrionPlatformRepository()
{
    OrionLibrariesRepository=orion_libraries_repository_$1
    OrionLibrariesRepositoryTemp=${!OrionLibrariesRepository}
    OrionLibrariesRepositoryWithGitHubCredentials=${OrionLibrariesRepositoryTemp/$GitHub/$GitHubUsername}
    OrionLibrariesRepositoryDir=orion_libraries_repository_dir_$1
    OrionLibrariesRepositoryDirToCloneIn=${!OrionLibrariesRepositoryDir}
    git clone $OrionLibrariesRepositoryWithGitHubCredentials $OrionLibrariesRepositoryDirToCloneIn
}


for i in $(seq 1 $number_of_orion_dev_repositories)
do
    (cloneOrionDevRepository $i &)
done

for j in $(seq 1 $number_of_orion_libraries_repositories)
do
    (cloneOrionPlatformRepository $j &)
done