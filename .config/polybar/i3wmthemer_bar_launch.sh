#!/bin/sh

pkill polybar

sleep 1;

echo aba > /home/cc/aba
polybar i3wmthemer_bar &
