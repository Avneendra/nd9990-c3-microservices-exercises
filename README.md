# Udagram Image Filtering Application

Udagram is a simple cloud application developed alongside the Udacity Cloud Engineering Nanodegree. It allows users to register and log into a web client, post photos to the feed, and process photos using an image filtering microservice.

The project is split into two parts:
1. Frontend - Angular web application built with Ionic Framework
2. Backend RESTful API - Node-Express application

## Getting Started
> _tip_: it's recommended that you start with getting the backend API running since the frontend web application depends on the API.

### Prerequisite
1. The depends on the Node Package Manager (NPM). You will need to download and install Node from [https://nodejs.com/en/download](https://nodejs.org/en/download/). This will allow you to be able to run `npm` commands.
2. Environment variables will need to be set. These environment variables include database connection details that should not be hard-coded into the application code.
#### Steps to run project
1. Install Travis plugin to github
2. Build Images - 
```
docker-compose -f udagram-deploy/docker/docker-compose-build.yaml build --parallel
```
3. Verify Images - 
```
docker images
```
4. Run app and verify application works by opening http://localhost:8100 - 
``` 
cd udagram-deploy/docker/ && docker-compose up
```
5. Create Amazon EKS cluster:
```
eksctl create cluster \
--name <cluster name> --region <region name> --nodegroup-name node-workers
--node-type t3.micro --nodes <number of node groups> --ssh-access --ssh-public-key <aws_key.pub> \
--managed
```
6. Deploying application: 
```
./deploy.sh
```
7. Setup port forwarding :
```
kubectl port-forward services/reverseproxy 8080:8080 &
kubectl port-forward services/frontend 8100:8100 &
```
You can visit `http://localhost:8100` in your web browser to verify that the application is running. You should see a web interface similar to one attached in screenshot directory.

### Database
Create a PostgreSQL database either locally or on AWS RDS. Set the config values for environment variables prefixed with `POSTGRES_` in `set_env.sh`.

### S3
Create an AWS S3 bucket. Set the config values for environment variables prefixed with `AWS_` in `set_env.sh`.

### Backend API
* To download all the package dependencies, run the command from the directory `udagram-api/`:
    ```bash
    npm install .
    ```
* To run the application locally, run:
    ```bash
    npm run dev
    ```
* You can visit `http://localhost:8080/api/v0/feed` in your web browser to verify that the application is running. You should see a JSON payload. Feel free to play around with Postman to test the API's.

### Frontend App
* To download all the package dependencies, run the command from the directory `udagram-frontend/`:
    ```bash
    npm install .
    ```
* Install Ionic Framework's Command Line tools for us to build and run the application:
    ```bash
    npm install -g ionic
    ```
* Prepare your application by compiling them into static files.
    ```bash
    ionic build
    ```
* Run the application locally using files created from the `ionic build` command.
    ```bash
    ionic serve
    ```
* You can visit `http://localhost:8100` in your web browser to verify that the application is running. You should see a web interface.
