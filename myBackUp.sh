#!/bin/bash

########################################################################
# Script : myBackup.sh
# Version: 1.00
# Author : Jamal Khan
# Purpose: It backups your files/directories in USB
########################################################################

clear
########## Variables -------------------------------------------------------------------------------------
fspinner=('>>>          ' ' >>>         ' '  >>>        ' '   >>>       ' '    >>>      ' '     >>>     ' '      >>>    ' '       >>>   ' '        >>>  ' '         >>> ' '          >>>')
bspinner=('<<<          ' ' <<<         ' '  <<<        ' '   <<<       ' '    <<<      ' '     <<<     ' '      <<<    ' '       <<<   ' '        <<<  ' '         <<< ' '          <<<')

boldgreen="\033[1;32m"
normal="\033[0m"

######### Functions --------------------------------------------------------------------------------------
function backup {
	echo -e $boldgreen"Backing up your system...\n"$normal
	spin &
	pid=$!

	for i in seq{1..10}; do
		sleep 1
	done

	kill $pid > /dev/null 2>&1
	echo -e "\rBackup Completed..\n"
}

function spin {
	while true; do
		for i in "${fspinner[@]}"; do
			echo -ne $boldgreen"\r$i"$normal
			sleep 0.2
		done
		for ((x=9; x>=0; x--)); do
		  	echo -ne $boldgreen"\r${bspinner[x]}"$normal
			sleep 0.2
		done
	done
}

function usage {
	echo -e "\nUsage: backup <Source File/Directory> <Target File>\n\nGive a file or folder with path as an argument to backup.\n"
}
########## Main Program ---------------------------------------------------------------------------------
if [[ $# -eq 2 ]]; then
	
	if [ -f $1 ]; then
		echo -e "\nYour file $1 will be archieved and backed up\n"
	fi
	
	if [ -d $1 ]; then
		echo -e "\nYour directory $1 will be archieved and backed up\n"
	fi
	
	if [ -e /media/$USER/* ]; then
		tar caf "$2.tar.bz2" $1 > /dev/null 2>&1
		cd /media/$USER/*/ > /dev/null 2>&1
		for files in `ls`
		do
			if [[ "$2.tar.bz2" = "$files" ]]; then
				rm $files
			fi
		done
		cd - > /dev/null 2>&1
		mv "$2.tar.bz2" /media/$USER/*/
		backup
	else
		clear
		echo -e "\nPlease attach a usb first, then try again.\n"
	fi

elif [[ $# -eq 2 && ! -e $1 ]]; then
	usage
else
	usage
fi
