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
    # if status returns exit code > 0 it means solr is stopped ("failed"), so we can start safely
    $0 status > /dev/null 2>&1
    if [ $? -gt 0 ]; then
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
        PID=$(cat "$SOLR_DIR/$PID_FILE")
        ps -p "$PID" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "Running"
            exit 0
        else
            echo "Stopped, but has stale pid file"
            rm "$SOLR_DIR/$PID_FILE"
            echo "Removed stale pid file"
            exit 1
        fi
    else
        echo "Stopped"
        exit 1
    fi
;;
stop)
    echo "Stopping Solr"
    cd "$SOLR_DIR"
    "$JAVA" $JAVA_OPTIONS -jar start.jar --stop
    rm -f "$PID_FILE"
    cd "$OLD_PWD"
    echo "ok"
    exit 0
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
