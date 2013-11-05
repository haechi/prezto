#
# Defines local aliases, functions, and paths.
#
# Authors:
#   Alexander Zhou <alex@haechi.me>
#


#
# Aliases
#

# Update the usb repro, exclude misc dir
alias lsync="rsync --verbose --progress --stats --recursive --delete --times --omit-dir-times --size-only --exclude-from=/Users/Alexander/.rsync /Users/Alexander/Sogang/ /Volumes/iamaKey"

# SSH Stuff
alias hostname='ssh -l login host.local.com'

alias helios='ramdisk 1024'		   # RAMdisk with 1024 MB 
alias unison='unison -auto'        # Unison conflict resolver (date) 

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
