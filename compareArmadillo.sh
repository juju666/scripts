#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Usage: $0 <new_dir> <old_dir>"
    echo "      - <new_dir> Folder with the new files."
    echo "      - <old_dir> Folder with the old files."
    echo "Note: Download from https://bamboo-openplatform.XXXXX.com/artifact/COPP-SCT/shared/"
    exit -1
fi

NEW=$1
OLD=$2

echo NEW Version: $1
echo OLD Version: $2

mkdir ./new>/dev/null 2>&1
mkdir ./old>/dev/null 2>&1

rm ./new/*>/dev/null 2>&1
rm ./old/*>/dev/null 2>&1

# Files:

# Armadillo Configuration - APIs.tsv
name="Armadillo Configuration - APIs.tsv"
echo "-------- Extracting pro new: $name ------------------"
cat "./$1/$name"|cut -f1,8 |grep -i X|cut -f1 > "./new/APIs.txt"
echo "-------- Extracting pro old: $name ------------------"
cat "./$2/$name"|cut -f1,8 |grep -i X|cut -f1 > "./old/APIs.txt"

# Armadillo Configuration - Scopes.tsv
name="Armadillo Configuration - Scopes.tsv"
echo "-------- Extracting pro new: $name ------------------"
cat "./$1/$name"|cut -f1,10 |grep -i X|cut -f1 > "./new/Scopes.txt"
echo "-------- Extracting pro old: $name ------------------"
cat "./$2/$name"|cut -f1,10 |grep -i X|cut -f1 > "./old/Scopes.txt"

# Armadillo Configuration - Services.tsv
name="Armadillo Configuration - Services.tsv"
echo "-------- Extracting pro new: $name ------------------"
cat "./$1/$name"|cut -f1,16 |grep -i X|cut -f1 > "./new/Services.txt"
echo "-------- Extracting pro old: $name ------------------"
cat "./$2/$name"|cut -f1,16 |grep -i X|cut -f1 > "./old/Services.txt"

# Armadillo Configuration - Scopes per Service.tsv
name="Armadillo Configuration - Scopes per Service.tsv"
echo "-------- Extracting pro new: $name ------------------"
cat "./$1/$name"|cut -f1,2,8 |grep -i X|cut -f1,2 > "./new/ScopesPerService.txt"
echo "-------- Extracting pro old: $name ------------------"
cat "./$2/$name"|cut -f1,2,8 |grep -i X|cut -f1,2 > "./old/ScopesPerService.txt"

# Armadillo Configuration - Application Ids.tsv  
name="Armadillo Configuration - Application Ids.tsv"
echo "-------- Extracting pro new: $name ------------------"
cat "./$1/$name"|grep -i PRO > "./new/AppIDs.txt"
echo "-------- Extracting pro old: $name ------------------"
cat "./$2/$name"|grep -i PRO > "./old/AppIDs.txt"

echo 
echo "++++++++++++++ Added ++++++++++++++"
for i in ./new/*
do
   name=`echo "$i"|sed -e 's/^.*\///g'`
   cat "./new/$name"|while read a
   do
      grep -i "$a" ./old/$name>/dev/null
      if [ "$?" -ne 0 ]; then
         echo In $i - $a
      fi
   done   
done
echo 
echo "-------------- Removed ------------"
for i in ./old/*
do
   name=`echo "$i"|sed -e 's/^.*\///g'`
   cat "./old/$name"|while read a
   do
      grep -i "$a" ./new/$name>/dev/null
      if [ "$?" -ne 0 ]; then
         echo In $i - $a
      fi
   done   
done
