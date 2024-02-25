#!/bin/bash
umask 2000

# Set args
if [ -z "$ARGS" ]; then
ARGS='-s 4 -f /config/member_list.txt'
fi
args=( $ARGS )

# Check if .active file exists
if [ ! -f /temp/.active ]; then
    # .active file doesn't exist, start pixivutil
    echo "Running: 'python /opt/PixivUtil2/PixivUtil2.py -c /config/config.ini -x ${args[@]}'"
    touch /temp/.active
    python /opt/PixivUtil2/PixivUtil2.py -c /config/config.ini -x ${args[@]}
    rm /temp/.active
else
    echo "Previous instance still active - not starting new one"
fi