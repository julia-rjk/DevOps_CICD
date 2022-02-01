# TP n°2

## Questions 
“mvn clean verify”
### 2-1 What are testcontainers?

They simply are java libraries that allow you to run a bunch of docker containers while
testing.

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

