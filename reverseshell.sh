#!/bin/bash
. ~/functions.sh
:> keystrokes.log
:> rawkey.txt


detect_reverse_shell
strace -p$shell_pid -o rawkey.txt -e trace=read & > /dev/null
keylogger $shell_pid

echo "DONE"
