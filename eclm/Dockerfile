FROM eclm/wildfly
ENV JDBCURL jdbc:oracle:thin:@oracle:1521:XE
#ADD eclm-war/target/eclm-jboss.war /opt/jboss/wildfly/standalone/deployments/eclm.war
ADD eclm-dist/target/*.war /opt/jboss/wildfly/standalone/deployments/eclm.war

EXPOSE 8787

CMD /opt/jboss/wildfly/bin/standalone.sh --debug 8787 --server-config standalone-full-ha.xml -b 0.0.0.0 -bmanagement 0.0.0.0