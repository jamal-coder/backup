#!/bin/bash
#--------------- Variables -------------------------
greenbold="\033[1;32m"
flashred="\033[5;31m"
normal="\033[0m"
myFile=Backup-$(date +%d%m%Y%N)
drives=()
folders=()
x=0
z=0

#---------------- Functions ------------------------
function Input {
	read -p "$1" val
	echo $val
}

function Heading {
	clear
	echo -en $greenbold"\nB A C K U P   P R O G R A M M E\n\n"$normal
}

#--------------- Main Programme --------------------
Heading

x=0
for i in $(ls -1 /media/$USER/); do
	drives[x]=$i
	((x++))
done

if [[ $x -eq 0 ]]; then
	echo -e $flashred"First Connect Your USB With The System\n"$normal
else
	z=0
	while [[ $choice -gt $x || $choice -lt 1 ]]; do
		Heading
		echo "List of Drives"
		echo -e "=============="
		while [[ $z -lt $x ]]; do
			echo "[$((z+1))] ${drives[z]}"
			((z++))
		done
		echo
		choice=$(Input "Target Drive Numer : ")
		z=0
	done
	((choice--))
	target="/media/$USER/${drives[choice]}"

	
	y=0
	for a in $(ls -1 $HOME); do
		folders[y]=$a
		((y++))
	done
	
	folders[y]="Home"
	((y++))
	c=0
	while [[ $choice -gt $y || $choice -lt 1 ]]; do
		Heading
		echo "List of Directories"
		echo -e "==================="
		while [[ $c -lt $y ]]; do
			echo "[$((c+1))] ${folders[c]}"
			((c++))
		done
		echo
		choice=$(Input "Source Direcotry : ")
		c=0
	done
	((choice--))

	echo $choice
	if [[ $choice -eq 9 ]]; then
		source="$HOME"
	else
		source="$HOME/${folders[choice]}"
	fi

	Heading
	echo "Source : $source"
	echo "Target : $target"
	echo
	choice=$(Input "Are you sure [yN] : ")

	if [[ $choice = [Yy] ]]; then
		echo -e "\nPlease wait backup has started..."
		tar cafP $myFile.tar.gz $source
		mv $myFile.tar.gz $target
		echo -e "\nYour backup has successfully done"
	else
		echo -e "\nGoodbye try again\n"
	fi
fi
