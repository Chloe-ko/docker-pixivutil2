#!/bin/bash
umask 000

# Set args
if [ -z "$ARGS" ]; then
ARGS='-s 4 -f /config/member_list.txt'
fi
args=( $ARGS )

# Check if PID file exists
if [ -f /.pid ]; then
    # PID file exists - check if previous pixivutil process is still active
    PID=$(</config/.pid)
    if ps -p $PID > /dev/null
    then
        # Programm is still running, don't start a new instance
        echo "Previous instance is still running - skipping this run."
        exit
    fi
fi

echo "Running: 'python /opt/PixivUtil2/PixivUtil2.py -c /config/config.ini -x \"${args[@]}'\""
python /opt/PixivUtil2/PixivUtil2.py -c /config/config.ini -x "${args[@]}" &
PROGRAM_PID=$!
echo $PROGRAM_PID > /config/.pid