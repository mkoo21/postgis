Data is downloaded from https://download.geonames.org/export/dump/; it is ignored in this repo, because the files are large and update relatively often

This database (and its scripts) are intended to remain in sync with those data and contains scripts to sync data from Canada and the US

To replicate this project on a new node, download the data from that site, and fill in the missing data files in the respective country directories (e.g. "US/US.txt")
`setup.sh` will create the database, then `setup.sql` will seed it; both require the db to already be available so for the time being they should be run manually

```
./setup.sh
psql -U postgres -d db
\i /setup/setup.sql
```
