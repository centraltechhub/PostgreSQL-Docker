#!/bin/sh
postgres -D /home/postgres/data >/home/postgres/dbstart.log 2>&1 &
echo "DB started successfullty"
sleep 10
createdb $DB_NAME > /home/postgres/dbcreate.log
echo $DB_NAME + " DB created successfullty"
psql -h localhost -p 5432 -U postgres $DB_NAME -c 'CREATE SCHEMA IF NOT EXISTS "OMS" AUTHORIZATION "postgres";'
echo "SCHEMA postgres created successfully"
tail -f /home/postgres/dbstart.log
