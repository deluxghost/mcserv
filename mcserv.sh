#!/bin/bash
M_OLDPWD=$OLDPWD
M_PWD=$PWD
# Modify the 3 lines first
DIR=$HOME/mc # Minecraft Directory
LOGDIR=$DIR/srvlog # Log Directory
LOG=$LOGDIR/launcher.log # Log File
[[ -d "$LOGDIR" ]] || ( mkdir "$LOGDIR" ; echo "$(date)[Info]Created log directory.">>$LOG )
cd "$DIR"
echo "$(date)[Info]Launching.">>$LOG
MCSTAT=0
false
while [[ "$?" != "0" || -f "$DIR/restart.lck" ]]; do
    if [[ "$MCSTAT" == "0" ]]; then
        echo "$(date)[Info]Start server.">>$LOG
        MCSTAT=1
    elif [[ -f "$DIR/restart.lck" ]]; then
        echo "$(date)[Info]Restart server.">>$LOG
        sleep 2
    else
        echo "$(date)[Warn]Crashed. Restart server.">>$LOG
        sleep 10
    fi
    if [[ -f "$DIR/restart.lck" ]]; then
        rm "$DIR/restart.lck"
    fi
    # Commands here will execute before launch
    java -server -Xmx1024M -Djava.awt.headless=true -jar $DIR/craftbukkit.jar
done
echo "$(date)[Info]Exit.">>$LOG
cd "$M_PWD"
OLDPWD=$M_OLDPWD
