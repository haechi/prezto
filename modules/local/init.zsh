#
# Defines local aliases, functions, and paths.
#
# Authors:
#   Alexander Zhou <alex@haechi.me>
#

#
# Aliases
#

# Ramdisk with 1024 MB
alias helios='ramdisk 1024'

# Network copy
alias ncp='rsync -avhz --progress'

# SSH shortcut
alias pandora='ssh -l Lina -p 22022 haechi.link'
alias goliath='ssh -l Alexander -p 21022 haechi.link' 

#
# Functions
#

function pp ()
{ ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command; }

function fp ()
{ osascript -e 'tell application "Finder"'\
  -e "if (${1-1} <= (count Finder windows)) then"\
  -e "get POSIX path of (target of window ${1-1} as alias)"\
  -e 'else' -e 'get POSIX path of (desktop as alias)'\
  -e 'end if' -e 'end tell'; }

function ff ()
{ cd "`fp $@`"; }

function ramdisk ()
{ diskutil erasevolume HFS+ "Helios" `hdiutil attach -nomount ram://$((${1}*2048))`; }

function rpush ()
{ rsync --itemize-changes --stats --human-readable --recursive --delete --times \
		--iconv=utf-8-mac,utf-8 --perms --links\
		--include-from=/Users/Alexander/.rsync/include \
		--exclude-from=/Users/Alexander/.rsync/exclude \
		--password-file=/Users/Alexander/.pass \
		/Users/Alexander/ 10.0.1.42::Homestead/ | \
		grep --color=never -E '^[^.]|^$' | \
		GREP_COLOR='01;36' grep --color=always -E '^...........[\+\.]|$' | \
		GREP_COLOR='01;31' grep --color=always -E '^\*deleting|$'; }

function rpull ()
{ rsync --itemize-changes --stats --human-readable --recursive --delete --times \
	    --iconv=utf-8-mac,utf-8 --chmod=o-rwx,g-w,Fa-x --links\
	    --include-from=/Users/Alexander/.rsync/include \
		--exclude-from=/Users/Alexander/.rsync/exclude \
		--exclude 'Music/' \
		--password-file=/Users/Alexander/.pass \
		10.0.1.42::Homestead/ /Users/Alexander/ | \
		grep --color=never -E '^[^.]|^$' | \
		GREP_COLOR='01;36' grep --color=always -E '^...........[\+\.]|$' | \
		GREP_COLOR='01;31' grep --color=always -E '^\*deleting|$'; }

#
# Settings
#

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

# sqlite-3.20 PATH from Home Brew installation
export PATH=/usr/local/opt/sqlite/bin:$PATH

# zsh syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
