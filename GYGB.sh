#!/bin/bash
set x
clear
echo "  ______________________________          ";
echo " /  _____/\_   _____/\__    ___/          ";
echo "/   \  ___ |    __)_   |    |             ";
echo "\    \_\  \|        \  |    |             ";
echo " \______  /_______  /  |____|             ";
echo "        \/        \/                      ";
echo "_____.___.________   ____ _____________   ";
echo "\__  |   |\_____  \ |    |   \______   \  ";
echo " /   |   | /   |   \|    |   /|       _/  ";
echo " \____   |/    |    \    |  / |    |   \  ";
echo " / ______|\_______  /______/  |____|_  /  ";
echo " \/               \/                 \/   ";
echo "  __________________ ____ _____________   ";
echo " /  _____/\______   \    |   \______   \  ";
echo "/   \  ___ |       _/    |   /|    |  _/  ";
echo "\    \_\  \|    |   \    |  / |    |   \  ";
echo " \______  /|____|_  /______/  |______  /  ";
echo "        \/        \/                 \/   ";
echo "__________    _____  _________  ____  __. ";
echo "\______   \  /  _  \ \_   ___ \|    |/ _| ";
echo " |    |  _/ /  /_\  \/    \  \/|      <   ";
echo " |    |   \/    |    \     \___|    |  \  ";
echo " |______  /\____|__  /\______  /____|__ \ ";
echo "        \/         \/        \/        \/ ";
echo "                                          ";
echo "                                          ";
echo "                                          ";
echo "                                          ";
echo "                                          ";
echo "                                          ";
echo "Hi, I can repair your GRUB by updating it and or installing it"
echo "Disclaimer: IT IS ONLY FOR LAPTOPs/PCs with EFI"
echo "Hope you like it"
echo Choose any option
echo "1) Repair my grub"
echo "2) Restart"
echo "4) Exit"
read option
case $option in
1)
	clear
	echo "Cha-Ching"
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
				clear
				echo "Go Restart, everything has been done"				
		;;
2)
	echo	Restarting
	restart
	;;
4)
	echo "Sure"
	exit
		;;
*) 
	echo "Invalid Input, looks like you dont want your grub to be repaired"
	echo "Press Enter to Exit"	
	read exit2
	exit
		;;	
esac
