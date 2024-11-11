Data is downloaded from https://download.geonames.org/export/dump/; it is ignored in this repo, because the files are large and update relatively often
This database (and its scripts) are intended to remain in sync with those data and contains scripts to sync data from Canada and the US

To replicate this project on a new node, download the data from that site, and fill in the missing data files in the respective country directories (e.g. "US/US.txt")
For the time being, `setup.sql` depends on the DB being available, and needs to be run manually on the first startup. `setup.sh` does not work due to the aforementioned requirement; ignore it. 
