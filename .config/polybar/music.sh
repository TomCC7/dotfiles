#!/usr/bin/env bash

# NOTE: You need the "playerctl" pachage in order for this to work!!!

exec 2>/dev/null

title=`exec playerctl metadata xesam:title`
artist=`exec playerctl metadata xesam:artist`
echo "[$artist] $title"
