FROM maven:3.5.2-jdk-8-alpine AS MAVEN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN  mvn clean package
 
FROM tomcat:9.0-jre8-alpine
COPY --from=MAVEN /tmp/target/my-app-1.0-SNAPSHOT.jar $CATALINA_HOME/webapps/my-app-1.0-SNAPSHOT.jar
#HEALTHCHECK --interval=1m --timeout=3s CMD wget --quiet --tries=1 --spider http://192.168.1.50:3333/wizard/ || exit 1
