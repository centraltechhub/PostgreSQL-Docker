docker build . -t centraltechhub/postgresql:v1
docker run --env DB_NAME=appdb -idt -p 5432:5432 --name postgresql centraltechhub/postgresql:v1
