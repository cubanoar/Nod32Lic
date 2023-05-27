#!/bin/bash

#Autor: n1c3bug( theIrishBug )

#Colors
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

trap ctrl_c INT
#Desaparece cursor
tput civis

#PAGES
#NOD32
p1="$(echo 'aHR0cHM6Ly9zY3JhcHl3YXIuY29tL2xpY2VuY2lhcy1lc2V0LW5vZDMyLwo=' | base64 -d)"
p2="$(echo 'aHR0cHM6Ly93d3cuaW50YXJjZXNvZnQuY29tLnZlL2VzL2FjdGl2YWRvcmVzL2xpY2VuY2lhcy1l
c2V0LXNtYXJ0LXNlY3VyaXR5LXktbm9kMzItYW50aXZpcnVzLTktc2VwdGllbWJyZS0yMDE2LWFj
dHVhbGl6YWRvLmh0bWwK' | base64 -d)"
p3="$(echo "aHR0cHM6Ly93d3cubHVpczIwMTkuY29tL3AvbGljZW5jaWFzLmh0bWwK" | base64 -d)"

#ESET INTERNET SECURITY
p4="$(echo "aHR0cHM6Ly9zY3JhcHl3YXIuY29tL2xpY2VuY2lhcy1lc2V0LWludGVybmV0LXNlY3VyaXR5Lwo=" | base64 -d)"
p5=$p2
p6=$p3

#ESET SMART SECURITY
p7="$(echo "aHR0cHM6Ly9zY3JhcHl3YXIuY29tL2xpY2VuY2lhcy1zbWFydC1zZWN1cml0eS1wcmVtaXVtLwo=" | base64 -d)"
p8=$p2
p9="$(echo "aHR0cHM6Ly93d3cubHVpczIwMTkuY29tLzIwMjIvMDgvbGljZW5jaWFzLWVzZXQtc21hcnQtc2Vj
dXJpdHktcHJlbWl1bS5odG1sCg==" | base64 -d)"

#FUNCTIONS
function checkDep(){
	clear
	echo -e "${red}[!]${end}Checking dependencies...\n"
	dependencies=(figlet html2text)
	for dep in "${dependencies[@]}";
	do
		which $dep > /dev/null
		if [ "$(echo $?)" == "0" ]; then
			echo -e "$dep...${green}check${end}\n"
			sleep 2
		else
			echo -e "$dep...${red}not found${end}"
			echo -e "${gray}[*]Installing${end} ${blue}$dep${end}...wait!!!\n"
			sudo apt install -y $dep > /dev/null 2>&1
		fi
	done
	
}

function ctrl_c(){
	echo -e "\n${red}[*] Finishing...${end}"
	#Aparece cursor
	tput cnorm
	rm AllNod32Lic DirtyNod32Lic 2>/dev/null
	exit 0
}

function callData(){
	curl -s $1 > DirtyNod32Lic
}

function panel(){
	
	clear
	echo -e "${green}"
	 figlet -f slant Nod32lic; figlet -f digital -c "by n1c3bug"
	echo -e "${end}"
	echo -e "\n${red}[i] v1.0${end}\n"
	echo -e "\n${yellow}Select an option:${end}"
	echo -e "\t${blue}[1]${end}-${yellow}Search Nod32 Lic.${end}"
	echo -e "\t${blue}[2]${end}-${yellow}Lic. Nod32 saved.${end}"
	echo -e "\t${blue}[3]${end}-${yellow}Search Eset Internet Security Lic.${end}"
	echo -e "\t${blue}[4]${end}-${yellow}Lic. Eset Internet Security saved.${end}"
	echo -e "\t${blue}[5]${end}-${yellow}Search Eset Smart Security Lic.${end}"
	echo -e "\t${blue}[6]${end}-${yellow}Lic. Eset Smart Security saved.${end}"
	echo -e "\t${blue}[7]${end}-${yellow}All Lic. saved.${end}"
	echo -e "\t${red}[8]-Exit${end}"
	
	echo -ne "\n${turquoise}>${end}";read -n1 opt
}

function panel2(){
	echo -e "\n${blue}[1]${end}-${yellow}Back${end}\t${blue}[2]${end}-${yellow}Exit${end}"
	echo -ne "${turquoise}>${end}";read -n1 opt2
	if [ $opt2 == "1" ]
	then
		clear
		continue
	else
		if [ $opt2 == "2" ]
		then
			rm AllNod32Lic DirtyNod32Lic 2>/dev/null
			ctrl_c
		else
			echo -e "\n${red}[!] Invalid option!!!${end}"
			sleep 2
		fi
	fi
}

function testReadTxt(){
	test -f "./${1}"
	if [ $(echo "$?") -eq "0" ]
	then
		echo -e '\n'
		cat $1
		panel2
	else
		echo -e "\n${purple}[!] Files not found\nYou must search first!!!${end}"
		sleep 1
		clear
		continue
	fi
}

function error(){
	if [ "$(echo $?)" != "0" ]
	then
		echo -e "${purple}\nThe page $1 is not working!!!${end}\n"
	else
		echo -ne "$2"
	fi
}

function readAll(){
	cat *.txt > all 2>/dev/null 
	if [ -s './all' ];then
		echo -e '\n'
		cat all | sort | uniq
		panel2
	else
		echo -e "\n${red}[!] Files not found\nYou must search first!!!${end}"
		sleep 1
	fi
}

#MAIN
which figlet && which html2text || checkDep

while [ true ]
do
	panel
	#NOD32DATA
	case $opt in
		1)  echo -ne '\nSearching..'
			callData $p1
			error "1" '..'
	   		html2text DirtyNod32Lic | grep 'License Key' -A 23 | tail -n 23 | awk '{print $1}' > AllNod32Lic
	   		callData $p2
	   		error "2" '..'
	   		html2text DirtyNod32Lic | grep "ESET_NOD32" -A 4 | head -n 5 | tail -n 4 | awk '{print $2}' >> AllNod32Lic
	   		callData $p3
	   		error "3" '\n\n\n'
	   		grep "tts-zoomOut" DirtyNod32Lic | sed 's/.*\">//' | cut -d "<" -f 1 >> AllNod32Lic
	   		sort AllNod32Lic | uniq  > Nod32.txt
	   		cat Nod32.txt
	   		panel2;;
	    2)	testReadTxt "Nod32.txt";;
	    3)	echo -ne '\nSearching..'
	    	callData $p4
	    	error "4" '..'
	    	html2text DirtyNod32Lic | grep 'License Key' -A 23 | tail -n 23 | awk '{print $1}' > AllNod32Lic
	    	callData $p5
	    	error "5" '..'
	   		html2text DirtyNod32Lic | grep "ESET_Internet_Security" -A 6 | tail -n 5 >> AllNod32Lic
			callData $p6
			error "6" '\n\n\n'
	   		grep "tts-zoomOut" DirtyNod32Lic | sed 's/.*\">//' | cut -d "<" -f 1 >> AllNod32Lic
	   		sort AllNod32Lic | uniq  > EIS.txt
	   		cat EIS.txt
	   		panel2;;
	   	4)	testReadTxt "EIS.txt";;
	    5)	echo -ne '\nSearching..'
	    	callData $p7
	    	error "7" '..'
	    	html2text DirtyNod32Lic | grep 'License Key' -A 23 | tail -n 23 | awk '{print $1}' > AllNod32Lic
	    	callData $p8
	    	error "8" '..'
	   		html2text DirtyNod32Lic | grep "ESET_Smart_Security" -A 5 | awk '{print $1}' | head -n 6 | tail -n 5 >> AllNod32Lic
			callData $p9
			error "9" '\n\n\n'
			grep "tts-zoomOut" DirtyNod32Lic | sed 's/.*\">//' | cut -d "<" -f 1 >> AllNod32Lic
	   		sort AllNod32Lic | uniq  > ESS.txt
	   		cat ESS.txt
	   		panel2;;
	   	6)	testReadTxt "ESS.txt";;
	   	7)	readAll;;
	   	8)  rm AllNod32Lic.txt DirtyNod32Lic.txt 2> /dev/null
	   		ctrl_c;;
		*)  echo -e "\n${red}[!] Invalid option!!!${end}"
			sleep 2
			;;
	esac
done
