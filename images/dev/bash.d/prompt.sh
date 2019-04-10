#!/bin/bash

RED="\e[0;31m"
LTRED="\e[1;31m"
GREEN="\e[0;32m"
LTGREEN="\e[1;32m"
BROWN="\e[0;33m"
YELLOW="\e[1;33m"
NOCOLOR="\e[00m"

# Little cheatsheet:
# \W only name of current directory
# \w path to current directory
# \u username
# \h hostname

# colorized
PS1="\[$BROWN\]$(hostname -f):\[$YELLOW\]\w\[$NOCOLOR\] \$ "
