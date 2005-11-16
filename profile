##################  BEGIN HEADERS
# Filename	: $HOME/.profile
# Use		: configures default shell environment
# Author	: Will Maier <willmaier@ml1.net>
# Version	: $Revision: 1.67 $
# Updated	: $Date: 2005/11/16 17:14:35 $
# Vim		: :vim: set ft=sh:
# CVS		: $Id: profile,v 1.67 2005/11/16 17:14:35 will Exp $
# Copyright	: Copyright (c) 2005 Will Maier
# License	: Expat; see <http://www.opensource.org/licenses/mit-license.php>
##################  END HEADERS

# profile-ng:
#source $HOME/.profile-ng/environment	    # general environment variables
#source $HOME/.profile-ng/functions	    # general shell functions
#source $HOME/.profile-ng/aliases	    # general aliases
#source $HOME/.profile-ng/arch-specific	    # functions, aliases and variables assigned by
#					    # architecture
#source $HOME/.profile-ng/host-specific	    # functions, aliases and variables assigned by
					    # host

ARCH=`uname`
#ISSUE=`awk '{print $1}' /etc/issue || echo "unknown"`

# --[ CVS
    # Personal CVS
    CVSROOT=":ext:will@merk:/cvs"
    # CAE CVS
    # CVSROOT=/afs/engr.wisc.edu/common/repository
    CVS_RSH=ssh
export CVSROOT CVS_RSH
alias mycvs='export CVSROOT=":ext:will@phnx.ath.cx:/cvs"'
alias caecvs='export CVSROOT=/afs/engr.wisc.edu/common/repository'

# --[ PRINTING
    if [ -x /afs/engr.wisc.edu/common/scripts/default_printer ] ; then
	PRINTER=`/afs/engr.wisc.edu/common/scripts/default_printer`
    else
	PRINTER=ps
    fi
export PRINTER

# --[ ENVIRONMENT
    PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin:/opt/:/usr/games/"
    export PATH
# arch-specific stuff.
case $ARCH in
    SunOS* )
    # fix needed for solaris and BSD
    alias ls='gls --color=auto -F'
    alias zsh='/afs/engr.wisc.edu/oss/bin/zsh'
    alias tar='gtar'
    export SHELL='/afs/engr.wisc.edu/oss/bin/zsh'
    ;;
    *BSD )
    alias ls='gnuls --color=auto -F'
    alias tar='gtar'
    ;;
    * )
    alias ls='ls --color=auto -F'
    ;;
esac

# host-specific
    case $HOST in
	nacho* | bender* | anon* | mace* )
	# Set special vars for CAE machines
	TERM=ansi
	PATH="/opt/SUNWspro/bin:/usr/ccs/bin:/usr/bin:/usr/sbin:/sbin:/bin:/usr/local/bin:/usr/local/sbin:/opt/sfw/bin:/usr/sfw/bin:/usr/afsws/bin:/usr/afsws/sbin:/usr/openwin/bin:/usr/X11R6/bin:/afs/engr.wisc.edu/oss/bin:/afs/engr.wisc.edu/apps/bin:/afs/engr.wisc.edu/common/scripts:/afs/engr.wisc.edu/local/bin:/usr/ucb:/usr/dt/bin:$HOME/bin"
	OSS='/afs/engr.wisc.edu/oss'
	LD_LIBRARY_PATH='/opt/SUNWspro/bin:/usr/ccs/bin:/usr/bin:/bin:/usr/local/bin:/opt/sfw/bin:/usr/sfw/bin:/usr/afsws/bin:/usr/openwin/bin:/usr/X11R6/bin:/afs/engr.wisc.edu/oss/bin:/afs/engr.wisc.edu/apps/bin:/afs/engr.wisc.edu/common/scripts:/afs/engr.wisc.edu/local/bin:/usr/ucb:/usr/dt/bin'
	MANPATH='/usr/share/man:usr/local/man:/opt/sfw/man:/usr/openwin/man/usr/X11R6/man:/afs/engr.wisc.edu/oss/man:/afs/engr.wisc.edu/apps/man'
	PYTHONPATH="$OSS/lib/python:$OSS/lib/python/lib-dynload:$OSS/lib/python/site-packages"
	SENDMAIL='sendmail'
	alias python="/afs/engr.wisc.edu/oss/bin/python"
	alias dot='`/afs/engr.wisc.edu/common/scripts/dot`'
	alias klog='klog -setpag'
	export OSS PYTHONPATH LD_LIBRARY_PATH MANPATH TERM SENDMAIL
	;;
	merkur* )
	CVSROOT=/cvs
	alias agent='keychain --timeout 120 ~/.ssh/id_rsa; key'
	alias mail='screen -x mail'
	alias myc='screen -x comms'
	source $HOME/.functions
	export CVSROOT
	;;
	vger* )
	alias agent='keychain ~/.ssh/id_rsa; key'
	;;
	haya* )
	alias ls='ls -F'
	;;
    esac

# os-specific
#    case $ISSUE in
#	*Ubuntu* )
#	alias upgrade='sudo apt-get update; sudo apt-get dist-upgrade'
#	;;
#	*BSD* )
#	PKG_PATH='ftp://openbsd.mirrors.tds.net/pub/OpenBSD/3.7/packages/i386/'
#    esac

    alias key='source $HOME/.keychain/$HOST-sh'
    alias agent='keychain ~/.ssh/id_rsa'
    alias pource='source $HOME/.profile'
    alias zource='source $HOME/.zshrc'
    alias todo='grep -v DONE $HOME/TODO'
    alias etodo='vim $HOME/TODO'
    alias mtr='mtr -t'
    alias xterm='rxvt'
    alias grep='grep -IHn'

    TODO=$HOME/TODO
    LANG='C'
    MAIL=''
    SHELL=`which zsh`
    CLUSTER=$HOME/.dsh/config
    RCMD_CMD=ssh
    EDITOR=`which vim`
    CVSEDITOR=$EDITOR
export LANG PATH SHELL EDITOR CVSEDITOR MAIL PKG_PATH TODO CLUSTER RCMD_CMD

# functions
lookup () {
    grep $1 /usr/share/dict/words
}
net () {
    lsof -Pni
}
mdc () {
    if [ "${HOST}" != "merkur" ]; then
	ssh merk "source .profile && $0 $1"
	return 0
    fi
    if [ ! -d "$HOME/Maildir" ]; then
	return 0
    fi

    echo "Checking mail at $(date)."

    local FINDCMD="find $HOME/Maildir -regex '.*/[a-zA-Z-]+/new/.*' -type f" 
    local SORTCMD="uniq -c"
    for i in $*; do
	case $i in
	    -n)
	    FINDCMD="${FINDCMD} -newer $HOME/Maildir/.marker"
	    ;;
	    -s)
	    SORTCMD="${SORTCMD} | sort -rn"
	esac
    done

    local NUMBER=0
    eval ${FINDCMD} |\
	 sed 's/.*Maildir\/\([^/]\+\)\/new\/.*/\1/' |\
	 sort |\
	 eval ${SORTCMD} |\
	while read i; do
	    echo "      $i"
	    local NEW=$(echo $i | awk '{print $1}')
	    local NUMBER=$((NUMBER + NEW))
	done

    echo "===>  $NUMBER new mails."

    touch $HOME/Maildir/.marker
}
alias mdcs='mdc -s'
alias mnt='mdc -n'
alias mnts='mdc -n -s'
# tdl (todo list) functions
TDL_DATABASE=$HOME/.tdldb
export TDL_DATABASE

cae () { 
    if [ $# -eq 0 ]; then 
	echo "CAE todo for $(date)"
	tdl ls '/[cae]' 
    else 
	tdl $* 
    fi 
}
hep () { 
    if [ $# -eq 0 ]; then 
	echo "HEP todo for $(date)"
	tdl ls '/[hep]' 
    else 
	tdl $* 
    fi 
}
hepa () {
    tdl add "[HEP] $*"
}
caea () {
    tdl add "[CAE] $*"
}
mus () { 
    if [ $# -eq 0 ]; then 
	echo "Music todo for $(date)"
	tdl ls '/[mus]' 
    else 
	tdl $* 
    fi 
}
musa () {
    tdl add "[MUS] $*"
}
notes () {
    # Determine date/time; used to guess the appropriate class
    DATE=$(date "+%Y.%m.%d") 
    DAY=$(date "+%A") 
    HOUR=$(date "+%H") 
    NOTEPATH=$HOME/School

    case ${DAY} in
	Tuesday|Thursday)
	    case ${HOUR} in
		11|12)
		    CLASS=HS323
		;;
		14|15)
		    CLASS=HS561
		;;
	    esac
	;;
	Monday|Wednesday|Friday)
	    case ${HOUR} in
		08|09)
		    CLASS=HS322
		;;
	    esac
	;;
    esac
    if [ -z ${CLASS} ]; then
	echo "Could not determine class."
	return 1
    fi
    NOTEPATH=${NOTEPATH}/${CLASS}/${DATE}
    vim ${NOTEPATH}
}
alias wiki='ruby $HOME/bin/instiki/instiki.rb --storage $HOME/bin/instiki/storage'
alias portmanager='portmanager --log'
alias elinks="DISPLAY='' elinks"
alias vim="DISPLAY='' vim"
alias calendar="calendar -f /home/will/.calendar"
