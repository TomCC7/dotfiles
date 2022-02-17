#!/bin/bash
function deskopen() {
  $(grep '^Exec' $1 | tail -1 | sed 's/^Exec=//' | sed 's/%.//' \
  | sed 's/^"//g' | sed 's/" *$//g') &
}
AUTOSTART_DIR=$HOME/.config/autostart
for FILE in $(ls $AUTOSTART_DIR);
do
  if [[ $FILE != autostart.sh ]];
  then
    deskopen $AUTOSTART_DIR/$FILE
  fi
done
