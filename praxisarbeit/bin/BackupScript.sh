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
BACKUP_DIR=../
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
    archive_file="$name-$day.tgz"
    echo $archiveFile
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


echo "script finished"

# $ getent group wheel # get group, returns non-zero exit code if not found

# > wheel:x:10:test,user1

# $ getent group wheel | cut -d ':' -f 4 # get user names

# > test,user1

# $ getent passwd test # get user info

# > test:x:1000:1000:test:/home/test:/bin/bash

# $ getent passwd test | cut -d ':' -f 6 # get user home dir

# > /home/test


# cat $1 | while read user name vorname; do
# 	echo User: $user
# 	echo Vorname: $vorname
# 	echo Name: $name
# done

# usage() {
#   echo “$BASENAME <inputfile> [<maximumentries>]” >&2
#   echo “inputfile: dieses file enthaelt...” >&2
#   echo “maximumentries: maximale Anzahl..(default:100)” >&2
#   exit 2
# }
# while getopts s:d:n:oN optvar ; do
#    case $optvar in
#  	d) DEST_SID="${OPTARG}" ;;
#  	s) SOURCE_SID="${OPTARG}" ;;
#  	o) OFFLINE=YES;;
#  	n) NIDCONNECT="${OPTARG}" ;;
#  	N) NIDONLY=true ;;
#  	*) usage ;;
#    esac
# done
# $ getent group wheel # get group, returns non-zero exit code if not found
# > wheel:x:10:test,user1
# $ getent group wheel | cut -d ':' -f 4 # get user names
# > test,user1
# $ getent passwd test # get user info
# > test:x:1000:1000:test:/home/test:/bin/bash
# $ getent passwd test | cut -d ':' -f 6 # get user home dir
# > /home/test
# Read a file line by line:
# while IFS= read -r group; do
# # user var group here
# done < $INPUT_FILE

# //Condition check if group from BackupGroupName.txt file exists on system
# //else remove from txt file and throw error
# //exit while loop if all entries are checked

# //while loop which gets all users from each groupname and get its home directory
# //and add it to Backuplist.txt file
# //exit if all groups are looped