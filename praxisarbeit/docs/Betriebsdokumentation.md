# Betriebsdokumentation
[[_TOC_]]
## Einführungstext 

TODO: In 2-3 Sätzen beschreiben was die Skripte grundsaetzlich tun.
### Script 2
Das Backupscript ermöglicht dem Nutzer mit einer Liste an Groupen, alle dazugehörigen user zu finden und deren Home Directories zu speichern. Dies macht es indem es zum Schluss eine liste aller Home Directories in ein archiev komprimiert und in den Backup ordner speichert

## Installationsanleitung für Administratoren

### Installation

TODO: Wie ist das Skript zu installieren. (z.B. apt-get install ... oder tar xvf .... oder ...)
### Script 2
Um das Script zu installieren kann man es ganz einfach von github mit 'git clone https://github.com/taagomag/M122Scripting.git' clonen.

### Konfiguration

TODO: Beschreibung der Konfigurationsfiles (Beispiel-Files erstellen im Repo)
### Script 2
Im Ordner etc befindet sich ein config.env file welche noch zwei Variablen beinhaltet und zwar wie viele Backups sollten gebackupt werden und wohin die daten gebackupt werden sollen.

TODO: Wie ist ein allfaelliger Cronjob einzurichten
### Script 2
Anbei finden sie eine ausführliche anleitung um einen CronJob einzurichten. https://www.stetic.com/developer/cronjob-linux-tutorial-und-crontab-syntax/

TODO: Wie sind User-Home-Templates einzurichten

....

## Bediensanleitung Benutzer

TODO: Erzeugen der Input-Files beschreiben, falls noetig
### Script 2
Das Backupinput file muss im Ordner var als groupsToBackup.txt gespeichert werden

TODO: beschreiben des Scriptaufruf
### Script 2
Das aufrufen des Scripts gelingt im bin Ordner mit dem Syntax ./BackupScript.sh

TODO: beschreiben der erzeugt files (falls solche erzeugt werden)
### Script 2
Beim erzeugen des Backup files muss man einen file namen setzen und mit y=yes oder n=no bestätigen

TODO: Lokation von logfiles und bekannte Fehlermeldungen beschreiben.
### Script 2
Ich habe keine Logfiles für das BackupScript erstellt.


### Script 2 kurze Reflexion
Ich habe mit dieser Aufgabe einen sehr guten einstieg in das Bash scripten gemacht. Im vergleich zu meinem Activity Diagram konnte ich fast alle meine plannungen umsetzten. Leider hat das Löschen von den Scripts schlussendlich nicht so wie ich wollte funktioniert, ansonsten wurde alles so wie ursprünglich geplannt umgesetzt.