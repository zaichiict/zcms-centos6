#!/bin/bash
ZCMS_MAIN_DIR="/opt/zcms"
PWD="`pwd`"
PROJECT_NAME="$2"
PROJECT_PATH="$PWD/$2"
BG_BLUE="\e[44m\e[97m"
BG_RED="\e[41m\e[97m"
BG_GREEN="\e[42m\e[97m"
BG_NC="\e[0m\n"
#Change link github project master
ZCMS_LINK="https://github.com/zaichiict/zcms/archive/master.zip"

usage()
{
    clear
    echo "--------------------------------------------------"
    echo "-             )             *      (             -";
    echo "-          ( /(     (     (  \`     )\ )          -";
    echo "-          )\())    )\    )\))(   (()/(          -";
    echo "-         ((_)\   (((_)  ((_)()\   /(_))         -";
    echo "-          _((_)  )\___  (_()((_) (_))           -";
    echo "-         |_  /  ((/ __| |  \/  | / __|          -";
    echo "-          / /    | (__  | |\/| | \__ \          -";
    echo "-         /___|    \___| |_|  |_| |___/          -";
    echo "-                                                -";
    echo "--------------------------------------------------"
    echo "-       ZCMS - Power by Phalcon Framework 2      -"
    echo "--------------------------------------------------"
    echo "- Usage:create, new, stop, start, restart,update -"
    echo "- Example: zcms create zcms-demo                 -"
    echo "--------------------------------------------------"
}

update_phalcon_version(){
    if [ -d "/opt/zcms_update/" ]
    then
        rm -fr /opt/zcms_update/*
    else
        mkdir /opt/zcms_update
    fi

    cd /opt/zcms_update
    wget "https://github.com/phalcon/cphalcon/archive/phalcon-v${PROJECT_NAME}.tar.gz"
    tar -xvf "phalcon-v${PROJECT_NAME}.tar.gz"
    rm -fr "phalcon-v${PROJECT_NAME}.tar.gz"
    cd "cphalcon-phalcon-v${PROJECT_NAME}/build/"
    ./install
}

remove_old_version(){
    rm -fr /opt/zcms/master.zip
    rm -fr /opt/zcms/zcms-master/
}

zcms_update_command(){
    rm -fr /usr/bin/zcms
    cd /usr/bin/
    wget -O zcms https://raw.githubusercontent.com/zaichiict/zcms-centos6/master/src/zcms.sh
    chmod +x /usr/bin/zcms
    printf "${BG_BLUE}Update \"ZCMS Command Line\" successfully!${BG_NC}"
}

service_update(){
    #Remove old version
    remove_old_version

    #Update command line
    zcms_update_command

    if [ -d "$ZCMS_MAIN_DIR" ]
    then
        cd "$ZCMS_MAIN_DIR"
        wget "$ZCMS_LINK"
        unzip master.zip
        rm -fr "$ZCMS_MAIN_DIR/master.zip"
    else
        mkdir "$ZCMS_MAIN_DIR"
        cd /opt/zcms
        wget "$ZCMS_LINK"
        unzip master.zip
        rm -fr "$ZCMS_MAIN_DIR/master.zip"
    fi
    printf "${BG_BLUE}Update ZCMS successfully!${BG_NC}"
}

service_create_project(){
    if [ -d "$PROJECT_PATH" ];then
        printf "${BG_RED}Project \"${PROJECT_NAME}\" is exits!${BG_NC}"
    else
        if [ -z "$2" ];then
            cp -R /opt/zcms/zcms-master $PROJECT_PATH
            #chmod -R a+w "$PROJECT_PATH/cache/"
            #chmod -R a+w "$PROJECT_PATH/app/config/config.php"
            chmod -R a+w "$PROJECT_PATH"
            printf "${BG_BLUE}Create project \"$PROJECT_NAME\" successfully!${BG_NC}"
        else
            printf "${BG_RED}Please enter your project name!${BG_NC}"
        fi
    fi    
    
}

service_start(){
    service redis start
    service nginx start
    service postgresql-9.4 start
    service mysqld start
    service php-fpm start
    printf "${BG_GREEN}Start service successfully${BG_NC}"
}

service_stop(){
    service redis stop
    service nginx stop
    service postgresql-9.4 stop
    service mysqld stop
    service php-fpm stop
    printf "${BG_GREEN}Stop service successfully${BG_NC}"
}

service_restart(){
    service_stop
    service_start
}

case $1 in
    stop)
        service_stop
    ;;
    start)
        service_start
    ;;
    restart)
        service_restart
    ;;
    update)
        service_update
    ;;
    update_phalcon)
        update_phalcon_version
    ;;
    install)
        service_update
    ;;
    create)
        service_create_project
    ;;
    new)
        service_create_project
    ;;
    update_command)
        zcms_update_command
    ;;
    *)
    usage
esac
exit 0
