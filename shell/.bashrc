. /etc/profile
export MANPATH=$MANPATH:/usr/local/share/man
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PATH=$PATH:~/android-sdk-linux_x86/tools:~/android-sdk-linux_x86/platform-tools:/home/tyg/android-ndk-r6:~/hadoop-1.0.3/bin
export LESS="-erX"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

alias ll='/bin/ls $LS_OPTIONS -l'
alias la='/bin/ls $LS_OPTIONS -a'

source ~/.git-completion.bash

PROMPT_COMMAND='PS1="\u@\h:\w$(__git_ps1 " [%s]")\$ "' 