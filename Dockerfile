# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER "reddy@gmail.com" 
COPY webapp/target/webapp.war /usr/local/tomcat/webapps
# RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
