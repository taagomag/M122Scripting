#!/usr/bin/env python

# install GitPython, pip install GitPython

import os
import time
import csv
from git import Repo
from os import path
import git
import sys

curDir = os.getcwd()
running = True  
baseDirectory = sys.argv[1]
outputFileName = sys.argv[2]

#Checking if both arguments have been passed
def checkArgs(): 
  if len(sys.argv) == 3:
    return True
  else:
    print("Please pass both arguments")
    sys.exit(1)

# Check if given Base Directory exists
def checkBaseDirectoryExists(): 
  if (os.path.exists(baseDirectory)):
    print ("Base directory exists: ", os.path.exists(baseDirectory))
    return True
  else:
    print("base directory does not exist")
    sys.exit(1)

# Getting all git commits of each Repository
def getGitCommits(): 
  for repoName in os.listdir(baseDirectory):
      bare_repo = git.Repo(os.path.join(baseDirectory, repoName))
      print("fourth")
      for commit in bare_repo.iter_commits():
        print("%s %s %s %s" % (commit.author, commit.hexsha, commit.message, commit.committed_datetime))

#def writeToCSV():


# Main program function
def main(): 
  if(checkArgs() and checkBaseDirectoryExists()):
    getGitCommits()

if __name__== "__main__":
  # open the file in the write mode
    f = open(os.path.join(baseDirectory, '..', 'tmp/commit'), 'w')

    # create the csv writer
    writer = csv.writer(f)

    # write a row to the csv file
    writer.writerow("asdf")

    # close the file
    f.close()
    main()
else:
  print("base directory does not exist")
  os._exit(0)


#read the name of base dir with $1
#throw error if no base dir was specified or no base dir existierendes
#read outputfile name 
#read what in config file was defined in config
#loop through base dir and check each if there is any data in git logs, if not skip repo
#write each log collection to output file with defined name
