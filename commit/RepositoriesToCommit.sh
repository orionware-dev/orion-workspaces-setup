#!/bin/bash
CurrentDirectory=`pwd`
NumberOfRepositoriesToCommit=`cat $CurrentDirectory/RepositoriesToCommit.prop | wc -l`

echo $NumberOfRepositoriesToCommit total repos
. $CurrentDirectory/RepositoriesToCommit.prop


function commitRepository()
{
    CurrentRepositoryDirectory=repository_$1
    cd ${!CurrentRepositoryDirectory}
    git add -A
    git commit -a -m "1"
    git push
}


for i in $(seq 1 $NumberOfRepositoriesToCommit)
do
    (commitRepository $i &)
done