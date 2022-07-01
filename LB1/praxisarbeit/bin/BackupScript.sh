#!/bin/bash
cwd=`pwd`		# current working directory
cd `dirname $0`	# change to the directory where the script is located
BINDIR=`pwd`	# BINDIR: the directory where the script is located
cd $cwd		# return to the working directory
BASENAME=`basename $0`	# Set the script name (without path to it)
TMPDIR=/tmp/$BASENAME.$$	# Set a temporary directory if needed
ETCDIR=$BINDIR/../etc/config.env		# ETCDIR is the config directory
GROUPS_TO_BACKUP=$BINDIR/../var/groupsToBackup.txt
TMPFILE=../tmp/tmpfile.txt
BACKUP_DIR=backups
BACKUPLIST=../var/backuplist.txt #Backuplist were all home directories are saved
. $ETCDIR # run config file “Scriptname”.env

echo "Running"

function groupNameNotExists {
  echo $1
  grep -v $1 $GROUPS_TO_BACKUP > tmpfile && mv tmpfile $GROUPS_TO_BACKUP
  : > $TMPFILE
  echo "Group name $1 does not exist"
}

function loopUsersForHomeDirectory {
    users=$(getent group $1 | cut -d ':' -f 4)
    Backup_of_internal_field_separator=$IFS
    IFS=,
    for user in $users
        do
            homeDirectory=$(getent passwd $user | cut -d ':' -f 6)
            echo $user ":" $homeDirectory >> $BACKUPLIST
        done
    IFS=$Backup_of_internal_field_separator
}

function createBackup {
    day=$(date +%m%d%Y)
    name=$1
    archiveFile="$name-$day.tgz"
    echo $archiveFile
    echo "Backing up $BACKUPLIST to $BACKUP_DIR/$archiveFile"
    date
    echo
    tar czf $BACKUP_DIR/$archiveFile $BACKUPLIST
    echo
    echo "Backup finished"
    date
    ls -lh $BACKUP_DIR
    find backups -atime +10 -exec rm {} \;
}

while read -r groupName;
do
    echo groupName: $groupName
    if [ $(getent group $groupName) ]; then
        echo "$groupName exists."
    else
        groupNameNotExists $groupName
    fi
done < $GROUPS_TO_BACKUP


while read -r groupName;
do
    loopUsersForHomeDirectory $groupName
done < $GROUPS_TO_BACKUP


while true; do
    read -p "Please enter a backup file name: " backupFileName
    read -p "The the backup file name is $backupFileName (y/n) ?" yn
    case $yn in
        [Yy]* ) createBackup $backupFileName; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "backup complete"