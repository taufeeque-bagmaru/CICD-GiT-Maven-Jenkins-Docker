# Pull base image 
From tomcat:9-jre9

# Maintainer 
MAINTAINER "khalid.kifayat@gmail.com" 
COPY webapp/target/webapp.war /usr/local/tomcat/webapps
