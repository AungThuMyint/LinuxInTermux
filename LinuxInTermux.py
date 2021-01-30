import os
from colorama import Fore, Back, Style

banner = """
  _    _              ___    _____                      
 | |  (_)_ _ _  ___ _|_ _|_ |_   _|__ _ _ _ __ _  ___ __
 | |__| | ' \ || \ \ /| || ' \| |/ -_) '_| '  \ || \ \ /
 |____|_|_||_\_,_/_\_\___|_||_|_|\___|_| |_|_|_\_,_/_\_\
"""

date = """
     Author : AungThuMyint  [30-1-2021] [Sat]"""                                                        
print(Fore.GREEN + banner)
print(Fore.CYAN + date)

choose = """
    [1] Installation Kali

    [2] Removing Kali

    [3] Exit
"""

print(Fore.YELLOW + choose)

def run(runfile):
	with open(runfile,"r") as rnf:
		exec(rnf.read())

try:
	method = int(input("Choose Your Input Options : "))
	print("\n")

	if method==1:
		print(Fore.YELLOW + "	[*] Installation Kali\n")
		os.system("bash Kali.sh")
		print(Style.RESET_ALL)
	elif method==2:
		print(Fore.MAGENTA + "[*] Removing Kali\n")
		os.system("bash RemoveKali.sh")
		run('LinuxInTermux.py')
		print(Style.RESET_ALL)
	elif method==3:
		print(Fore.RED + """
	############################
	* Exit The Program Bye Bye *
	############################
	""")
		quit()
	else:
		os.system("clear")
		print(Fore.RED + """
	###################################
	*   Invalid Options ! Try Again   *
	###################################
	""")
		run('LinuxInTermux.py')
		print(Style.RESET_ALL)

except ValueError:
	os.system("clear")
	print(Fore.RED + """
	##################################
	*   Invalid Options Choose 1:3   *
	##################################
""")
	run('LinuxInTermux.py')
	print(Style.RESET_ALL)
