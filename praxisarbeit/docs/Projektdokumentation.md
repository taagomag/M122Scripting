# Projekt Dokumentation

Alwin Hauser, Max Gordon

## Lösungsdesign
Anhand der Analyse wurde folgendes Lösungsdesign entworfen.


### Aufruf der Skripte

Skript 1:
Das Skript muss manuell ausgeführt werden.
Parameter:
Via Inputfile - <username> <groupname> <vorname nachname>
Via Configfile - <defaultpassword> 
Skript 2:
Das Skript wird einmal täglich automatisch per Cronjob ausgeführt.
Parameter: 
Via Configfile - <groupnameX> (alle zu sicherenden Gruppen) - <maxBackupCount> <backupLocation> <backupName> <exludeFolders>


### Ablauf der Automation
Script 1:
\praxisarbeit\docs\Activity_CreateUser.drawio

### Konfigurationsdateien

Ein gemeinsames Configfile:
<defaultpasswort>
<groupname1>
<groupname2>
<groupname3>
<maxBackupCount>
<backupLocation>
<backupName>
<exludeFolders>

## Abgrenzungen zum Lösungsdesign

TODO: Nachdem das Programm verwirklicht wurde, hier die Unterschiede von der Implementation zum Lösungsdesign beschreiben (was wurde anders gemacht, was wurde nicht gemacht, was wurde zusaetzlich gemacht)