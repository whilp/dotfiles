# ~/.profile
# Will Maier <willmaier@ml1.net>
# 2005.06.11

ARCH=`uname`



# --[ ENVIRONMENT
# host-specific
    case $HOST in
	nacho* | bender* | anon* )
	# Set special vars for CAE machines
	TERM=ansi
	PATH="/opt/SUNWspro/bin:/usr/ccs/bin:/usr/bin:/bin:/usr/local/bin:/opt/sfw/bin:/usr/sfw/bin:/usr/afsws/bin:/usr/openwin/bin:/usr/X11R6/bin:/afs/engr.wisc.edu/oss/bin:/afs/engr.wisc.edu/apps/bin:/afs/engr.wisc.edu/common/scripts:/afs/engr.wisc.edu/local/bin:/usr/ucb:/usr/dt/bin:$HOME/bin"
	OSS='/afs/engr.wisc.edu/oss'
	LD_LIBRARY_PATH='/opt/SUNWspro/bin:/usr/ccs/bin:/usr/bin:/bin:/usr/local/bin:/opt/sfw/bin:/usr/sfw/bin:/usr/afsws/bin:/usr/openwin/bin:/usr/X11R6/bin:/afs/engr.wisc.edu/oss/bin:/afs/engr.wisc.edu/apps/bin:/afs/engr.wisc.edu/common/scripts:/afs/engr.wisc.edu/local/bin:/usr/ucb:/usr/dt/bin'
	MANPATH='/usr/share/man:usr/local/man:/opt/sfw/man:/usr/openwin/man/usr/X11R6/man:/afs/engr.wisc.edu/oss/man:/afs/engr.wisc.edu/apps/man'
	PYTHONPATH="$OSS/lib/python:$OSS/lib/python/lib-dynload:$OSS/lib/python/site-packages"
	alias python="/afs/engr.wisc.edu/oss/bin/python"
	alias dot='`/afs/engr.wisc.edu/common/scripts/dot`'
	alias klog='klog -setpag'
	export OSS PYTHONPATH LD_LIBRARY_PATH MANPATH TERM
	;;
	vger* )
	PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin:/opt/:/usr/games/"
	;;

	* )
# Standard vars
	PKG_PATH='ftp://openbsd.mirrors.tds.net/pub/openBSD/3.7/packages/i386/'
	;;
    esac

    LANG='C'
    SHELL=`which zsh`
    EDITOR=`which vim`
    CVSEDITOR=$EDITOR
export LANG PATH SHELL EDITOR CVSEDITOR


# arch-specific stuff.
case $ARCH in
    SunOS* )
    # fix needed for solaris and BSD
    alias ls='gls --color=auto'
    alias zsh='/afs/engr.wisc.edu/oss/bin/zsh'
    alias tar='gtar'
    export SHELL='/afs/engr.wisc.edu/oss/bin/zsh'
    ;;
    * )
    alias ls='ls --color=auto'
    ;;
esac

# --[ ALIASES
alias xlockb='xlock -mode blank'
alias zsource='source ~/.zshrc'
alias psource='source ~/.profile'
alias ogg123='ogg123 -d oss'
alias tv='DISPLAY=:0.1'
alias mpdserv='mpd 6600 $HOME/Music $HOME/Music $HOME/Music/log $HOME/Music/error'

# --[ CVS
    # Personal CVS
    CVSROOT=":ext:will@phnx.ath.cx:/cvs"
    # CAE CVS
    # CVSROOT=/afs/engr.wisc.edu/common/repository
export CVSROOT
alias mycvs='export CVSROOT=":ext:will@phnx.ath.cx:/cvs"'
alias caecvs='export CVSROOT=/afs/engr.wisc.edu/common/repository'

# --[ PRINTING
    if [ -x /afs/engr.wisc.edu/common/scripts/default_printer ] ; then
	PRINTER=`/afs/engr.wisc.edu/common/scripts/default_printer`
    else
	PRINTER=ps
    fi
export PRINTER
