#!/bin/bash
M_OLDPWD=$OLDPWD
M_PWD=$PWD
DIR='<YOUR MINECRAFT DIR HERE, NO "/">'
LOGDIR=$DIR/srvlog/launcher.log
cd "$DIR"
echo "$(date)[Info]Launching.">>$LOGDIR
MCSTAT=0
false
while [[ "$?" != "0" ]]; do
    if [[ "$MCSTAT" == "0" ]]; then
        echo "$(date)[Info]Start Server.">>$LOGDIR
        MCSTAT=1
    else
        echo "$(date)[Warn]Crashed. Restart Server.">>$LOGDIR
        sleep 10
    fi
    java -Xmx880M -Xms32M -server -Djava.awt.headless=true -XX:PermSize=255m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+UseStringCache -jar -Dfml.queryResult=confirm "$DIR/cauldron.jar"
done
echo "$(date)[Info]Exit.">>$LOGDIR
cd "$M_PWD"
OLDPWD=$M_OLDPWD
