#!/bin/bash

#Autor: n1c3bug( theIrishBug)


#Colors
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"
interRed="\e[5;31m\033[1m"

trap ctrl_c INT



function checkDep(){
	#Desaparece cursor
	tput civis
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


#Pages
#NOD32
p1=https://scrapywar.com/licencias-eset-nod32/
p2=https://www.intarcesoft.com.ve/es/activadores/licencias-eset-smart-security-y-nod32-antivirus-9-septiembre-2016-actualizado.html
p3=https://www.luis2019.com/p/licencias.html

#ESET INTERNET SECURITY
p4=https://scrapywar.com/licencias-eset-internet-security/
p5=$p2
p6=$p3

#ESET SMART SECURITY
p7=https://scrapywar.com/licencias-smart-security-premium/
p8=$p2
p9=https://www.luis2019.com/2022/08/licencias-eset-smart-security-premium.html

#FUNCTIONS
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
	echo -e "\t${blue}[2]${end}-${yellow}Lic. Nod32 saves.${end}"
	echo -e "\t${blue}[3]${end}-${yellow}Search Eset Internet Security Lic.${end}"
	echo -e "\t${blue}[4]${end}-${yellow}Lic. Eset Internet Security saves.${end}"
	echo -e "\t${blue}[5]${end}-${yellow}Search Eset Smart Security Lic.${end}"
	echo -e "\t${blue}[6]${end}-${yellow}Lic. Eset Smart Security saves.${end}"
	echo -e "\t${blue}[7]${end}-${yellow}All Lic. saves.${end}"
	echo -e "\t${red}[8]-Exit${end}"
	
	echo -ne "\n${interRed}>${end}";read opt
}

function panel2(){
	echo -e "\n${blue}[1]${end}-${yellow}Back${end}\t\t${blue}[2]${end}-${yellow}Exit${end}"
	echo -ne "${interRed}>${end}";read opt2
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
		cat $1
		panel2
	else
		echo -e "\n${red}[!] File not found!!!${end}"
		sleep 2
		clear
		continue
	fi
}

function error(){
	if [ $(echo "$?") != "0" ]
	then
		echo -e "${red}\nThe page $1 is not working!!!${end}\n"
	else
		echo -ne "$2"
	fi
}





checkDep


while [ true ]
do
	panel

	#NOD32DATA
	case $opt in
		1)  echo -n 'Searching..'
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
	    3)	echo -n 'Searching..'
	    	callData $p4
	    	error "1" '..'
	    	html2text DirtyNod32Lic | grep 'License Key' -A 23 | tail -n 23 | awk '{print $1}' > AllNod32Lic
	    	callData $p5
	    	error "2" '..'
	   		html2text DirtyNod32Lic | grep "ESET_Internet_Security" -A 6 | tail -n 5 >> AllNod32Lic
			callData $p3
			error "3" '\n\n\n'
	   		grep "tts-zoomOut" DirtyNod32Lic | sed 's/.*\">//' | cut -d "<" -f 1 >> AllNod32Lic
	   		sort AllNod32Lic | uniq  > EIS.txt
	   		cat EIS.txt
	   		panel2;;
	   	4)	testReadTxt "EIS.txt";;
	    5)	echo -n 'Searching..'
	    	callData $p7
	    	error "1" '..'
	    	html2text DirtyNod32Lic | grep 'License Key' -A 23 | tail -n 23 | awk '{print $1}' > AllNod32Lic
	    	callData $p8
	    	error "2" '..'
	   		html2text DirtyNod32Lic | grep "ESET_Smart_Security" -A 5 | awk '{print $1}' | head -n 6 | tail -n 5 >> AllNod32Lic
			callData $p9
			error "3" '\n\n\n'
			grep "tts-zoomOut" DirtyNod32Lic | sed 's/.*\">//' | cut -d "<" -f 1 >> AllNod32Lic
	   		sort AllNod32Lic | uniq  > ESS.txt
	   		cat ESS.txt
	   		panel2;;
	   	6)	testReadTxt "ESS.txt";;
	   	7)	cat *.txt > all 2>/dev/null 
	   		if [ -s './all' ]
	   		then
	   			cat all | sort | uniq
	   			panel2
	   		else
	   			echo -e "\n${red}[!] Files not found\nYou must search first!!!${end}"
	   			sleep 3
	   		fi
	   		;;
	   	8)  rm AllNod32Lic.txt DirtyNod32Lic.txt 2> /dev/null
	   		ctrl_c;;
		*)  echo -e "\n${red}[!] Invalid option!!!${end}"
			sleep 2
			;;
	esac
done
