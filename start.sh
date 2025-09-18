#!/bin/bash

LOG_FILE=/var/log/gui-startup.log
touch $LOG_FILE

echo "[INFO] Starting Xvfb..." | tee -a $LOG_FILE
Xvfb :1 -screen 0 1280x800x16 &
sleep 2

echo "[INFO] Starting Xfce desktop..." | tee -a $LOG_FILE
export DISPLAY=:1
xfce4-session &

echo "[INFO] Starting x11vnc..." | tee -a $LOG_FILE
x11vnc -display :1 -nopw -forever -shared &

echo "[INFO] Starting noVNC on port 6080..." | tee -a $LOG_FILE
websockify --web=/usr/share/novnc/ --index vnc_auto.html 6080 localhost:5900 >> /var/log/websockify.log 2>&1 &

echo "[INFO] GUI startup complete. Tailing log..." | tee -a $LOG_FILE
tail -f $LOG_FILE
