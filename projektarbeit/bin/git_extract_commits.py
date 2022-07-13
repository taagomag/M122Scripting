import os
import time
import csv

curDir = os.getcwd()
running = True  

#get name of base Directory
inputDir = str(input("Which base directory would like to search: "))
baseDirectory = os.path.join(curDir, '..', 'var', inputDir)
print(inputDir)

while running:
  if os.path.isdir(baseDirectory):
    print("folder exists")
    # requesting a name for the output file
    outputFileName = str(input("What should the output file name be called: "))
    # checking if base directory is empty
    dir = os.listdir(baseDirectory)
  if len(dir) == 0:
    print("base directory is empty")

  else:
    print("base directory has repositories")
    for repoName in dir:
      print(repoName)
else:
  print("folder does not exist")


time.sleep(2)
print(curDir)
print(baseDirectory)
time.sleep(2)
print("finished")
#read the name of base dir with $1
#throw error if no base dir was specified or no base dir existierendes
#read outputfile name 
#read what in config file was defined in config
#loop through base dir and check each if there is any data in git logs, if not skip repo
#write each log collection to output file with defined name
