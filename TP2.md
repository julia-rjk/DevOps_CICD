# TP n°2

### 2-1 What are testcontainers?
They simply are java libraries that allow you to run a bunch of docker containers while testing.

## 2-2 Document your Github Actions configurations
```yaml
name: CI devops 2022 CPE
on:
  #to begin you want to launch this job in main and develop
  push:
    branches: 
      - main # The workflow runs when pushing in main's branch
      - develop
  pull_request:

jobs:
  test-backend:
    runs-on: ubuntu-18.04
    steps:
      #checkout your github code using actions/checkout@v2.3.3
      - uses: actions/checkout@v2.3.3
      #do the same with another action (actions/setup-java@v2) that enable to setup jdk 11
      - name: Set up JDK 11
        uses: actions/setup-java@v2
        with: # Using zulu distribition with java 11
          distribution: 'zulu' # See 'Supported distributions' for available options
          java-version: '11'
      #TODO
      #finally build your app with the latest command
      - name: Build and test with Maven
        run: mvn clean verify --file ./backend/pom.xml
```

## 2-3 Document your quality gate configuration

```yaml
name: CI devops 2022 CPE
on:
  #to begin you want to launch this job in main and develop
  push:
    branches: 
      - main
      - develop
  pull_request:

jobs:
  test-backend:
    runs-on: ubuntu-latest
    steps:
      #checkout your github code using actions/checkout@v2.3.3
      - uses: actions/checkout@v2.3.3
      #do the same with another action (actions/setup-java@v2) that enable to setup jdk 11
      - name: Set up JDK 11
        uses: actions/setup-java@v2
        with:
          distribution: 'zulu' # See 'Supported distributions' for available options
          java-version: '11'
      #TODO
      #finally build your app with the latest command
      - name: Build and test with Maven
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}  # Needed to get PR information, if any
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
        run: mvn -B verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=julia-rjk_DevOps_CICD --file ./backend/pom.xml

  # define job to build and publish docker image
  build-and-push-docker-image:
    needs: test-backend
    
    # run only when code is compiling and tests are passing
    runs-on: ubuntu-latest
    
    # steps to perform in job
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Login to DockerHub
        run: docker login -u ${{secrets.DOCKERHUB_USERNAME }} -p ${{secrets.DOCKERHUB_TOKEN }}

      - name: Build image and push backend
        uses: docker/build-push-action@v2
        with:
          # relative path to the place where source code with Dockerfile is located
          context: ./backend
          # Note: tags has to be all lower-case
          tags: ${{secrets.DOCKERHUB_USERNAME}}/tp-devops-cpe:backend
          # build on feature branches, push only on main branch
          push: ${{ github.ref == 'refs/heads/main' }}

      # DO the same for database
      - name: Build image and push database
        uses: docker/build-push-action@v2
        with:
          context: ./database
          tags: ${{secrets.DOCKERHUB_USERNAME}}/tp-devops-cpe:database
          # build on feature branches, push only on main branch
          push: ${{ github.ref == 'refs/heads/main' }}

      - name: Build image and push httpd
      # DO the same for httpd
        uses: docker/build-push-action@v2
        with:
          context: ./frontend
          tags: ${{secrets.DOCKERHUB_USERNAME}}/tp-devops-cpe:frontend
          # build on feature branches, push only on main branch
          push: ${{ github.ref == 'refs/heads/main' }}

```

## Split pipeline (Optional)
See .github/workflows/.main.yml && .github/workflows/.production.yml
