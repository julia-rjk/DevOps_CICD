# TP n°1

## Questions 

## 1-1 **Document your database container essentials: commands and Dockerfile**
```bash
sudo docker volume create db_data
sudo docker build -t jrocpe/database .
sudo docker run -v /db_data:/var/lib/postgresql/data --network=my_net --name database jrocpe/database 
```

## 1-2 **Why do we need a multistage build ? And explain each steps of this dockerfile**
We need a multistage build to avoid having a too heavy docker image as well as to avoid transmitting unnecessary environments

```dockerfile
FROM maven:3.6.3-jdk-11 AS myapp-build # Use maven image
ENV MYAPP_HOME /opt/myapp # Setting environment variable
WORKDIR $MYAPP_HOME # Going in /opt/myapp folder
COPY pom.xml . # Copying pom.xml file into the container in ./
COPY src ./src # Copying src file into the container in ./src
RUN mvn package -DskipTests # Executing the command mvn package -DskipTests
# Run
FROM openjdk:11-jre # Use openjdk image
ENV MYAPP_HOME /opt/myapp # Setting environment variable
WORKDIR $MYAPP_HOME # Going in /opt/myapp folder
COPY --from=myapp-build $MYAPP_HOME/target/*.jar $MYAPP_HOME/myapp.jar # Copying jar files
ENTRYPOINT java -jar myapp.jar # Execution
```

## 1-3 **Document docker-compose most important commands**
```bash
sudo docker-compose build
sudo docker-compose up
sudo docker-compose ps
sudo docker-compose down
```

## 1-4 **Document your docker-compose file**
```dockerfile
version: '3.7'
services:
  backend: # Backend image 
    build: ./backend # Image location
    networks: # Using a defined network which is the same for the 3 services
      - app-network
    depends_on: # This image is requesting database
      - database

  database:
    build: ./database
    networks: # Using a defined network which is the same for the 3 services
      - app-network

  httpd:
    build: ./frontend # Image location
    ports:
      - "80:80" # Using local s port 80 and container s port 80 
    networks: # Using a defined network which is the same for the 3 services
      - app-network
    depends_on: # This image is requesting backend
      - backend
volumes:
  db_data: # Creating a volume
    driver: local

networks:
  app-network: # Defining network
```

## 1-5 **Document your publication commands and published images in dockerhub**
```bash
sudo docker login
docker tag my-database jrocpe/my-database:1.0
docker push jrocpe/my-database

```

------ 
# Commands
## Database
```bash
sudo docker volume create db_data
sudo docker build -t jrocpe/database .
sudo docker run -v /db_data:/var/lib/postgresql/data --network=my_net --name database jrocpe/database 
```

## Adminer
```bash
sudo docker pull adminer
sduo docker run --network=my_net -p 8081:8081 adminer
# Then go to : http://[::]:8080
``` 
## Springboot app

```bash
sudo docker build -t jrocpe/springapp .
sudo docker run --name springapp -p 8082:8082 --network=my_net jrocpe/springapp
```

## Backend API

```bash
sudo docker build -t jrocpe/backend .
sudo docker run --name backend -p 8080:8080 --network=my_net jrocpe/backend 
# Then go to : http://localhost:8080/departments/IRC/students
```


## Frontend 
```bash
sudo docker build -t jrocpe/frontend .
sudo docker run -p 80:80 --name frontend --network=my_net jrocpe/frontend
# Then go to : http://localhost
```

## Docker Compose
```bash
sudo docker-compose build
sudo docker-compose up
```