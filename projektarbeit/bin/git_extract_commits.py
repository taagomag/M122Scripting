#!/usr/bin/env python

# install GitPython, pip install GitPython

import os
import csv
from git import Repo
from os import path
import git
import sys

curDir = os.getcwd()
running = True  
baseDirectory = sys.argv[1]
outputFileName = sys.argv[2]
outputDirectory = os.path.join(curDir, '..', 'tmp', outputFileName + '.csv')
csvHeaderRow = ['Zielverzeichnis','Datum','Commit-Hash','Author']

#Checking if both arguments have been passed
def checkArgs(): 
  if len(sys.argv) == 3:
    return True
  else:
    print("Please pass 2 arguments")
    sys.exit(1)

# Check if given Base Directory exists
def checkBaseDirectoryExists(): 
  if (os.path.exists(baseDirectory)):
    print ("Base directory exists: ", os.path.exists(baseDirectory))
    return True
  else:
    print("base directory does not exist")
    sys.exit(1)

# Getting all git commits of each Repository and writing them to a csv file


def getAndWriteToCSV():
  with open(outputDirectory, 'w', newline='\n') as csvfile:
    CSV_WRITER = csv.writer(csvfile, delimiter=',')
    CSV_WRITER.writerow(csvHeaderRow) # Here I'm setting the heading of the new csv file
    for repoName in os.listdir(baseDirectory): # Looping through the basedirectory with all repos
      bare_repo = git.Repo(os.path.join(baseDirectory, repoName)) #with git.Repo i can create the repo path for the extraction of the commits
      for commit in bare_repo.iter_commits(): # To write the commits to the csv file I used the csv writer
        csvfile.write("%s %s %s %s" % (repoName, commit.committed_date, commit.hexsha, commit.author))
        csvfile.write(';\n')

# Main program function
def main(): 
  if(checkArgs() and checkBaseDirectoryExists()):
    getAndWriteToCSV()
    print("writing commits to csv was succeful!")
    sys.exit(0)
if __name__== "__main__":
    main()
else:
  print("base directory does not exist")
  os._exit(0)
