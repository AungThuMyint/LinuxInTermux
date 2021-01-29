#!/data/data/com.termux/files/usr/bin/bash

pkg update -y && pkg install curl proot tar -y
pkg install wget -y 
folder=kali-cli
if [ -d "$folder" ]; then
	first=1
	echo -e "\e[92mSkipping Downloading ..."
fi
tarball="kali-rootfs.tar.xz"
if [ "$first" != 1 ];then
	if [ ! -f $tarball ]; then
		clear
		echo -e "\e[96mDownloading ... While Base On Your Internet Speed."
		case `dpkg --print-architecture` in
		aarch64)
			archurl="arm64" ;;
		arm)
			archurl="armhf" ;;
		amd64)
			archurl="amd64" ;;
		x86_64)
			archurl="amd64" ;;	
		i*86)
			archurl="i386" ;;
		x86)
			archurl="i386" ;;
		*)
			echo -e "\e[91mUnknown Architecture ... !"; exit 1 ;;
		esac
		wget "https://github.com/AungThuMyint/TermuxLinuxFiles/blob/main/kali-rootfs-${archurl}.tar.xz?raw=true" -O $tarball
	fi
	cur=`pwd`
	mkdir -p "$folder"
	cd "$folder"
	proot --link2symlink tar -xJf ${cur}/${tarball}||:
	cd "$cur"
fi
mkdir -p kali-tmp
bin=kali-cli.sh
echo -e "\e[34mWriting Launch Script ..."
cat > $bin <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A kali-tmp)" ]; then
    for f in kali-tmp/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b kali-cli/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## uncomment the following line to mount /sdcard directly to / 
#command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

wget --tries=20 https://raw.githubusercontent.com/AungThuMyint/TermuxLinuxFiles/main/Sudo.sh -O $folder/root/Sudo.sh
chmod +x $folder/root/Sudo.sh
termux-fix-shebang $bin
chmod +x $bin
rm $tarball
clear
echo -e "\e[92mInstallation Finished."
clear
echo -e "\n\e[92mWelcome | Kali@LocalHost\n"
echo -e "\e[93mIf You Want To [sudo su] | run bash Sudo.sh\n"
bash $bin
