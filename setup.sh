clear
printf "This process will install and configure 2 programs-
termux-api : command-line interface of termux-api app and
openssh : a SSH program

press enter to install.."
read x

if pkg update -y && pkg install -y termux-api openssh; then
	clear
	printf "\nBoth programs were installed.\n"
else
	printf "\nCould not install program, run this setup again"
	exit
fi


printf "\nRequest sms and contacts permission-
termux-api needs sms and contacts permissions to view sms content and sender name.
press enter to see permission prompt.."
read x

termux-sms-list | grep -oP '"error": "Please grant the following permissions to use this command: [\w\W]+' > /dev/null
while [ $? -eq 0 ]
do
	clear
	printf "\nRequired permission missing.\n"
	printf "Without these permissions termux cannot access SMS.\n"
	sleep 5
	termux-sms-list | grep -oP '"error": "Please grant the following permissions to use this command: [\w\W]+' > /dev/null
done

clear
printf "Required permission granted\n"
printf "\nSSH password setup-"
printf "\nPlease do not share this password with anyone.\n"


passwd
while [ $? -ne 0 ]
do
	printf "\n"
	passwd
done

clear
printf "\nPassword setup complete"
printf "\nAdding finishing touches.."
echo 'alias sshs="pkill sshd; sshd; printf '\''SSH server started. Hostname is '\''; ip -br -f inet address | grep -oP '\''192[\d.]+'\''"' >> ~/.bashrc

echo 'alias sshk="pkill sshd; printf '\''SSH server was killed.\\n'\''"' >> ~/.bashrc

echo "\nsetup completed."
printf "\nUse sshs command to start SSH server,\nand sshk to kill the server.\n"




