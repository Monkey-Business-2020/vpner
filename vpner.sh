#! /bin/bash
clear;
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
nc='\033[0m'

if [[ $EUID -ne 0 ]]; then
        echo -e "\n\n\n\n\nRUN ME AS ${RED}ROOT${nc}!!!!!\n\n\n\n"
        exit 1
fi

echo -e "\nOPTIONS: \t\t\t\t DESCRIPTION:"
echo -e "${GREEN}1 - Connect HackTheBox${nc} \t\t\t - HackTheBox vpn connection"
echo -e "${GREEN}2 - Connect TryHackMe${nc} \t\t\t - TryHackMe vpn connection"
echo -e "${GREEN}3 - Find OpenVPN${nc} \t\t\t - Check if OpenVPN is already connected"
echo -e "${GREEN}4 - Hunt for the OVPN files${nc} \t\t - Start a quick search for the ovpn file within /root and /home"
printf "\n"

read -p "Please Choose from one of the options by entering the number: " option

echo -e "\nYou selected option:" $option

#Make sure to add your ovpn paths to the below, and add others if you have more.
vpnhunt="find /root /home -name *.ovpn"
hackthebox="openvpn /root/../filename.ovpn"
tryhackme="openvpn /root/../Norseman2018THM.ovpn"

if [[ $option == 1 ]];
then
        echo -e "\n [+]${CYAN} Connecting to HackTheBox VPN ${nc}[+] \n"
        sleep 1;
        $hackthebox &

elif [[ $option == 2 ]];
then
        echo -e "\n [+]${CYAN} Connecting to TryHackMe VPN ${nc}[+] \n"
        sleep 1;
        $tryhackme &

elif [[ $option == 3 ]];
then
        echo -e "\n [+]${CYAN} Checking active VPN connections ${nc}[+]\n"
        sleep 0.5;
        ps aux | grep "openvpn"
        echo -e "\nKill a process, type the PID:"
        read -t 20 pronum
        if [[ $pronum == "" ]];
        then
                echo -e "Exiting..."
                sleep 0.5;
                exit 1
        else
                echo -e "\nKilling PID-$pronum..."
                sleep 2;
                kill -9 $pronum
        fi

elif [[ $option == 4 ]];
then
        echo -e "\n${CYAN}Your VPN files lord: ${nc}\n"
        sleep 0.5;
        $vpnhunt
        printf "\n"

else
        echo -e "\nYou went full retard and didnt choose a valid option! \n"
fi
