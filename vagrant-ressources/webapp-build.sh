function buildFrontEnd {
    cd /vagrant/project/webapp/hit-erx-tool/hit-base-web/client
    npm install
    bower install
    grunt build
}

function buildJars {
    cd /vagrant/project/webapp/hit-core
    #git pull
    mvn clean install -DskipTests
    cd /vagrant/project/webapp/hit-core-erx
    #git pull
    mvn clean install -DskipTests
    cd /vagrant/project/webapp/erx-resource-bundle
    #git pull
    mvn clean install -DskipTests
    cd /vagrant/project/webapp/hit-erx-tool
    #git pull
    mvn clean install -DskipTests
}

function deployWar {
    sudo rm /var/lib/tomcat7/webapps/hit-erx-tool.war
    sudo rm -r /var/lib/tomcat7/webapps/hit-erx-tool
    sudo cp /vagrant/project/webapp/hit-erx-tool/hit-base-web/target/hit-erx-tool.war /var/lib/tomcat7/webapps/
    cd /var/lib/tomcat7/webapps/
    sudo chmod +r hit-erx-tool.war
    sudo service tomcat7 restart
}

if [ $# == 1 ]; then
    case "$1" in
        '-onlyFrontend')
            buildFrontEnd
            ;;
        '-onlyJars')
            buildJars
            ;;
        '-onlyDeploy')
            deployWar
            ;;
        '-noFrontend')
            buildJars
            deployWar
            ;;
        '-help')
            echo 'Help - Webapp build options (use bash webapp-build -[option]) :'
            echo 'Option -onlyFrontend to build only the AngularJS part of the webapp'
            echo 'Option -onlyJars to build only the jars and the war'
            echo 'Option -onlyDeploy to only deploy the war'
            echo 'Option -noFrontend to build the jars and the war, and then deploy the war'
            echo 'Option -help to display the help'
            ;;
        *)
            echo 'Invalid parameter. use the option -help to display the help (bash webapp-build -help)'
            ;;
    esac
else
    #build everything
    buildFrontEnd
    buildJars
    deployWar
fi