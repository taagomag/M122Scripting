#!/bin/bash
cwd=`pwd`		# current working directory
cd `dirname $0`	# change to the directory where the script is located
BINDIR=`pwd`	# BINDIR: the directory where the script is located
cd $cwd		# return to the working directory
BASENAME=`basename $0`	# Set the script name (without path to it)
TMPDIR=/tmp/$BASENAME.$$	# Set a temporary directory if needed
ETCDIR=$BINDIR/../etc		# ETCDIR is the config directory
VARDIR=$BINDIR/../var       # VARDIR is the directory where you can edit inputfiles

. $ETCDIR/config.env	# run config file “Scriptname”.env


echo "CreateUser Script started"

echo "$DEFAULT_PASSWORD"

usersToAdd=$VARDIR/usersToAdd.txt
echo "$usersToAdd"

groupsToBackup=$VARDIR/groupsToBackup.txt
echo "$groupsToBackup"


cat $usersToAdd |grep -v '^$'| grep -v '^#' | while read user vorname name usergroup; do
echo User: $user
echo Vorname: $vorname
echo Name: $name
echo Usergroup: $usergroup
done

#useradd

: << 'COMMENT'
usage() {
  echo “$BASENAME <inputfile> [<maximumentries>]” >&2
  echo “inputfile: dieses file enthaelt...” >&2
  echo “maximumentries: maximale Anzahl..(default:100)” >&2
  exit 2
}


while getopts s:d:n:oN optvar ; do
   case $optvar in
 	d) DEST_SID="${OPTARG}" ;;
 	s) SOURCE_SID="${OPTARG}" ;;
 	o) OFFLINE=YES;;
 	n) NIDCONNECT="${OPTARG}" ;;
 	N) NIDONLY=true ;;
 	*) usage ;;
   esac
done
COMMENT
