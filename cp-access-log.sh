wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# Unzip the file to extract the .txt file.
gunzip -f web-server-access-log.txt.gz

# Filter only: timestamp, latitude, longitude, visitorid fields
cut -d"#" -f1-4 web-server-access-log.txt > extracted-log-data.txt

# Replace hash marks with commas and save as csv
tr "#" "," < extracted-log-data.txt > transformed-log-data.csv

# Load phase
echo "Loading data"

# Send the instructions to connect to 'template1' and
# copy the file to the table 'access_log' through command pipeline.

export PGPASSWORD=BQ7eCGF8GtkukRqJK6dDWcft;

echo "\c template1;\COPY access_log  FROM '/home/project/log_pipeline/transformed-log-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=postgres

echo "SELECT * FROM access_log;" | psql --username=postgres --host=postgres template1
