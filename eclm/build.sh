#!/bin/bash
echo $1

if test "$1" == "build"
then
  mvn -f ./eclm-dist/module-pom.xml clean package \
    -Declm.version=1.0.0-SNAPSHOT \
    -Dpackage.artifactId=rcf-base \
    -Dpackage.groupId=com.selectica.rcf.rcf-base \
    -Dpackage.version=0.2.5;
fi

if test "$1" == "run"
then
  docker build --tag=eclm/wildfly:rcfbase . && docker run -d -p 8081:8080 -p 9991:9990 -p 8788:8787 --name eclm-rcfbase --link oracle2:oracle eclm/wildfly:rcfbase
fi

if test "$1" == "system"
then
  mvn -f .//modules/rcf-system/pom.xml -Dserver.port=8081 -Dserver.hostname=localhost -P  run-system-integtation-tests verify;
fi

if test "$1" == "clean"
then
  docker stop eclm-rcfbase && docker rm eclm-rcfbase
fi
