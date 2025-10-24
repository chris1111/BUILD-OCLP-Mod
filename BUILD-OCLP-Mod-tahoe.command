# Build OCLP-Mod-tahoe-test
# By chris1111
# Copyright (c) 2025, chris1111. All Right Reserved
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# Vars

PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"
printf '\e[8;45;80t'


nameh=`users`
function echob() {
  echo "`tput bold`$1`tput sgr0`"
}

function head
{
clear
echo "       ****************************************************************"                      
echo "       *******************`tput setaf 7``tput sgr0``tput bold``tput setaf 26` Build-OCLP-Mod-tahoe-test`tput sgr0` `tput setaf 7``tput sgr0`******************"
echo "       ****************************************************************"
}

function menu
{
echo "                                Welcome `tput bold`$nameh`tput sgr0` "  
echo " "                                                            
echo "              Prerequisite: Command Line Tools (CLT) for Xcode 
     (from '\033[1mxcode-select --install\033[0m' or Developer Apple Command Line Tools
                If you have '\033[1mXcode installed\033[0m' that's also good"
echo " "
echo "                        Type `tput setaf 7``tput sgr0``tput bold``tput setaf 2`A`tput sgr0` `tput setaf 7``tput sgr0`➣  to Build OCLP-Mod "
echo "                        Type `tput setaf 7``tput sgr0``tput bold``tput setaf 2`B`tput sgr0` `tput setaf 7``tput sgr0`➣  to Check Update OCLP-Mod "
echo "                        Type `tput setaf 7``tput sgr0``tput bold``tput setaf 2`C`tput sgr0` `tput setaf 7``tput sgr0`➣  to Update OCLP-Mod "
echo "                        Type `tput setaf 7``tput sgr0``tput bold``tput setaf 2`D`tput sgr0` `tput setaf 7``tput sgr0`➣  to Build OCLP-Mod installer "
echo "                        Type `tput setaf 7``tput sgr0``tput bold``tput setaf 1`X`tput sgr0` `tput setaf 7``tput sgr0`➣  to quit command "                            
echo " "                                 

echo "       ****************************************************************"  
echo "                          `tput setaf 7``tput sgr0``tput bold``tput setaf 26` Thanks to OCLP-Mod Team`tput sgr0` `tput setaf 7``tput sgr0`"
echo "       ****************************************************************"  
read -n 1 option

}
function BUILD
{
head
echo " "
echo "———————————————————————————————————————————————————————————————————————————————"
Sleep 1
echo "[Build OCLP-Mod tahoe-test]"
if [ -f "/usr/local/bin/python3" ]; then
  echo "Python 3 exist."
else
  echo "Python 3 not exist! 
Download then install. Wait... "
curl -f -o /Private/tmp/python-3.11.5-macos11.pkg https://www.python.org/ftp/python/3.11.5/python-3.11.5-macos11.pkg
echo " "
# run the pkg
osascript -e 'do shell script "installer -allowUntrusted -verboseR -pkg /Private/tmp/python-3.11.5-macos11.pkg -target /" with administrator privileges'

echo "pip3 upgrade pip "
Sleep 2
pip3 install --upgrade pip

echo " "
cd "/Applications/Python 3.11/"
# Install Certificates
./"Install Certificates.command"
# remove the pkg
rm -rf /Private/tmp/python-3.11.5-macos11.pkg
fi
# Starting OCLP-Mod project
rm -rf ~/Developer/OCLP-Mod
# Create Dev’s Folder
mkdir -p ~/Developer
# Move into a directory to store the project
cd ~/Developer
# Clone main branch
git clone --branch tahoe-test https://github.com/laobamac/OCLP-Mod.git
# Move into Project directory
cd ~/Developer/OCLP-Mod
# Install Python dependacies used by the project
Sleep 2
pip3 install -r requirements.txt
cd ~/Developer/OCLP-Mod/ci_tooling/privileged_helper_tool
rm -rf com.laobamac.oclp-mod.privileged-helper
Sleep 1
make debug
echo "
Now you can Build installer `tput setaf 7``tput sgr0``tput bold``tput setaf 2`(Option D)`tput sgr0` `tput setaf 7``tput sgr0`"

echo "
Quit Build OCLP-Mod."

osascript -e 'tell app "terminal" to display dialog "Quit Build OCLP-Mod
Use (Option D) for building installer" with icon file "System:Library:CoreServices:loginwindow.app:Contents:Resources:ShutDown.tiff" buttons {"Logout"} default button 1 with title "Build OCLP-Mod" giving up after 10'

echo "
Use (Option D) for building installer"
echo "———————————————————————————————————————————————————————————————————————————————"
echo " "


}
function CHECK
{
head
echo " "
echo "———————————————————————————————————————————————————————————————————————————————"
# Check Update OCLP-Mod tahoe-test
Sleep 1
echo "[Check Update OCLP-Mod tahoe-test]"
Sleep 1
cd ~/Developer/OCLP-Mod/
if [[ -d .git ]]; then
  git fetch --all
  git pull origin main
echo "
If you see remote update files, now you can Update `tput setaf 7``tput sgr0``tput bold``tput setaf 2`(Option C)`tput sgr0` `tput setaf 7``tput sgr0`"
else
  echo "Error: This directory is not a Git. Unable to update!"
fi
echo "  "
echo "———————————————————————————————————————————————————————————————————————————————"
echo " "

}
function UPDATE
{
head
echo " "
echo "———————————————————————————————————————————————————————————————————————————————"
# Update OCLP-Mod tahoe-test
Sleep 1
echo "[Update OCLP-Mod tahoe-test]"
Sleep 1
cd ~/Developer/OCLP-Mod/
if [[ -d .git ]]; then
  git fetch --all
  git pull origin main
echo "
Update OCLP-Mod main Done"
git status

else
  echo "Error: This directory is not a Git. Unable to update!"
fi

cd ~/Developer/OCLP-Mod/
# Remove Binaries
rm -rf ./payloads.dmg
rm -rf ./Universal-Binaries.dmg
rm -rf ./build
rm -rf ./dist
# Create the pyinstaller based Application
python3 Build-Project.command
# Open build folder
open ./dist/
echo "  "
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 26`Update Complete Building --> OCLP-Mod.app Done!`tput sgr0` `tput setaf 7``tput sgr0`"
echo "———————————————————————————————————————————————————————————————————————————————"
echo " "

}
function APP
{
head
echo " "
echo "———————————————————————————————————————————————————————————————————————————————"
# OCLP-Mod Build App
echo "[OCLP-Mod Building Installer]"
cd ~/Developer/OCLP-Mod/
# Install PyInstaller
Sleep 2
pip3 install pyinstaller
# Create the pyinstaller based Application
Sleep 2
python3 Build-Project.command
# Open build folder
open ./dist/
echo "  "
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 26`Building --> All OCLP-Mod Main Done!`tput sgr0` `tput setaf 7``tput sgr0`"
echo "———————————————————————————————————————————————————————————————————————————————"
echo " "

}
function Quit
{
clear
echo " " 
echo "
Quit Build OCLP-Mod"

osascript -e 'tell app "terminal" to display dialog "Quit Build OCLP-Mod " with icon file "System:Library:CoreServices:loginwindow.app:Contents:Resources:ShutDown.tiff" buttons {"Logout"} default button 1 with title "Build OCLP"'
echo " " 
echob "`tput setaf 7``tput sgr0``tput bold``tput setaf 2`Good By`tput sgr0` `tput setaf 7``tput sgr0``tput setaf 7``tput sgr0``tput bold``tput setaf 26`$nameh`tput sgr0` `tput setaf 7``tput sgr0`"
echo " " 
exit 0
}
while [ 1 ]
do
head
menu
case $option in

a|A)
echo
BUILD ;;
b|B)
echo
CHECK ;;
c|C)
echo
UPDATE ;;
d|D)
echo
APP ;;
x|X)
echo
Quit ;;


*)
echo ""
esac
echo
echob "`tput setaf 7``tput sgr0``tput bold``tput setaf 2`You must type any key to return.`tput sgr0` `tput setaf 7``tput sgr0`"
echo
read -n 1 line
clear
done

exit
