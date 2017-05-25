#
# Defines local aliases, functions, and paths.
#
# Authors:
#   Alexander Zhou <alex@haechi.me>
#

#
# Aliases
#

# Rsync
alias rpush="rsync --progress --stats --recursive --delete --times --iconv=utf-8-mac,utf-8 --include-from=/Users/Alexander/.rsync/include --exclude-from=/Users/Alexander/.rsync/exclude --password-file=/Users/Alexander/.pass /Users/Alexander/ 10.0.1.42::Tauri/"

alias rpull="rsync --progress --stats --recursive --delete --times --iconv=utf-8-mac,utf-8 --exclude 'Aspyr' --exclude '.*' --exclude '*eaDir' --password-file=/Users/Alexander/.pass 10.0.1.42::Tauri/Documents/ /Users/Alexander/Documents/"

# Ramdisk with 1024 MB
alias helios='ramdisk 1024'

# Network copy
alias ncp='rsync -avhz --progress'

# SSH shortcut
alias pandora='ssh -l Alexander Pandora.local'

# Quick way to rebuild the Launch Services database
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'




#
# Functions
#

function pp ()
{ ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function fp ()
{
  osascript -e 'tell application "Finder"'\
  -e "if (${1-1} <= (count Finder windows)) then"\
  -e "get POSIX path of (target of window ${1-1} as alias)"\
  -e 'else' -e 'get POSIX path of (desktop as alias)'\
  -e 'end if' -e 'end tell';
}

function ff ()
{ cd "`fp $@`"; }

function ramdisk ()
{ diskutil erasevolume HFS+ "Helios" `hdiutil attach -nomount ram://$((${1}*2048))`; }

function vault ()
{
  security find-generic-password -ga EncFS 2>&1 >/dev/null | \
  cut -d'"' -f2 | encfs "/Users/Alexander/Dropbox/.vault" -S "/Users/Alexander/Library/Vault" \
  -o fsname=Vault -o volname=Vault;
}

#
# Settings
#

# Textmate Fortran Bundle
export TM_FORTRAN=/usr/local/bin/gfortran

# Unison Host Name
export UNISONLOCALHOSTNAME=Goliath.local

# Brew Path Adjustment
export PATH=/usr/local/sbin:$PATH

# R Home Brew Installation
export RSTUDIO_WHICH_R=/usr/local/bin/R

# Load rbenv
eval "$(rbenv init -)"

# Fix problem with locals when logging into ubuntu
export LC_CTYPE="en_US.UTF-8"

# Fix missing /usr/sbin in PATH in 10.9
export PATH=/usr/sbin:$PATH
