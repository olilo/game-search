#!/bin/sh

OLD_PWD="$PWD"
SCRIPT_DIR=$(dirname $0)
SOLR_DIR="$(dirname $SCRIPT_DIR)/ext/solr-4.5.0/"

# log file and pid file are relative to SOLR_DIR
LOG_FILE="logs/console.log"
PID_FILE="run.pid"


JAVA_OPTIONS="-Dsolr.solr.home=./solr -server -DSTOP.PORT=8079 -DSTOP.KEY=stopkey -Xmx2048M -Xms512M"
JAVA="/usr/bin/java"
if [ -n "$JAVA_HOME" ]; then
    JAVA="$JAVA_HOME/bin/java"
fi

# main switch: has start/stop/status/restart
case $1 in
start)
    if [ ! -f "$SOLR_DIR/$PID_FILE" ]; then
        echo "Starting Solr"
        cd "$SOLR_DIR"
        nohup "$JAVA" $JAVA_OPTIONS -jar start.jar > "$LOG_FILE" 2>&1 &
        echo $! > "$PID_FILE"
        cd "$OLD_PWD"
        echo "ok - remember it may take a minute or two before Solr responds on requests"
        exit 0
    else
        echo "Solr already running!"
        exit 1
    fi
;;
status)
    if [ -f "$SOLR_DIR/$PID_FILE" ]; then
        echo "Running"
    else
        echo "Stopped"
    fi
;;
stop)
    echo "Stopping Solr"
    cd "$SOLR_DIR"
    "$JAVA" $JAVA_OPTIONS -jar start.jar --stop
    rm -f "$PID_FILE"
    cd "$OLD_PWD"
    echo "ok"
;;
restart)
    $0 stop
    sleep 3
    $0 start
;;
*)
    echo "Usage: $0 {start|stop|restart|status}" 2>&1
;;
esac