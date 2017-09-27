#!/bin/bash
set x
trap "remind" 2



#Making Functions Here
remind(){
	clear
	echo -e "\e[1;97;101mYou Should Not Exit like this, to exit enter 99 on the next screen\e[1;92;49m"
	echo ""
	echo ""
	echo "Press Enter"
	read j
	main-menu
}
ubuntu(){
	echo "Enter the partition name where your distro has been installed"
	echo "Eg. sda5"
	echo ""
	echo ""
	ls -l /dev/disk/by-label/
	read XXX
	clear
	sudo grub-install /dev/$XXX

}

debian(){
	echo "Enter the partition name where your distro has been installed"
	echo "Eg. sda5"
	echo ""
	echo ""
	ls -l /dev/disk/by-label/
	read XXX
	grub-mkdevicemap
	grub-install /dev/$XXX
	update-grub

}



header() {

	echo "		   _______  ____________ ";
	echo "		  / ____\ \/ / ____/ __ )";
	echo "		 / / __  \  / / __/ __  |";
	echo "		/ /_/ /  / / /_/ / /_/ / ";
	echo "		\____/  /_/\____/_____/  ";
	echo "		                         ";
}
classic(){
	lsblk -o NAME,FSTYPE,MOUNTPOINT,LABEL
	echo "Enter the drive name containg your OS in the format sdXY replacing XY with the last two letters"
	echo "(Most of the times its type is ext4)";
	echo "eg sda8";
	read linuxpart;
	clear
	lsblk -o NAME,FSTYPE,MOUNTPOINT,LABEL;
	echo "Enter the drive name where EFI is located/mounted in the format sdXY";
	echo "Most of the times its type is vfat";
	echo "eg sda1"
	read efipart
	clear
	echo "Your OS is located on $linuxpart and EFI partitoin is on $efipart Right ?"
	echo "If something is wrong then exit the script and run it again, else press enter"
	read what
	echo "The process is starting.."
	sudo mount /dev/$linuxpart /mnt
	for i in /sys /proc /run /dev; do sudo mount --bind "$i" "/mnt$i"; done
	sudo mount /dev/$efipart /mnt/boot/efi
	sudo chroot /mnt
	sudo update-grub
	sudo grub-install /dev/sda
	sudo update-grub
}



main-menu(){
clear
header

echo -e "\e[1;92;49mHi, I can repair your grub"
echo "Hope you like it"
echo "Choose an option"
echo -e "1) The Classic Way (FOR EFI SYSTEMS ONLY)"
echo -e "2) The Ubuntu Way  \e[1;97;44mFor Ubuntu Distros \e[1;92;49m "
echo -e "3) The Debian Way  (For Debian Distros)"
echo -e ""





echo -e "98) Restart"
echo -e "99) Exit"
read option
case $option in

1)
				clear
				classic
				clear
				echo "All Changes have been applied"
				echo "Now Select the restart option after pressing Enter"
				read nothing
				clear
				main-menu

		;;
2)			clear
				ubuntu
				echo "All Changes have been applied"
				echo "Now Select the restart option after pressing Enter"
				read nothing
				clear
				main-menu
		;;

3)		clear
			debian
			echo "All Changes have been applied"
			echo "Now Select the restart option after pressing Enter"
			read nothing
			clear
			main-menu
		;;
98)
	echo	Restarting
	restart
	;;
99)
	clear
	exit
		;;
*)
			clear
			echo "Invalid Input, looks like you dont want your grub to be repaired"
			echo ""
			echo ""
	  	main-menu
		;;
esac
}






#Checking Root Permission here

clear
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


clear

#Start of Program
main-menu
