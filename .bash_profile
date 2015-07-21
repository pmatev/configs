export TERM=xterm-256color
alias ls="ls -G"
alias cp="cp -nv"
export CLICOLOR=1
alias fixairplay="sudo kill `ps -ax | grep 'coreaudiod' | grep 'sbin' |awk '{print $1}'`"

alias a="cd ../";
alias l="ls -a";
alias ll="ls -lh";

# Reset
Color_Off='\[\033[0m\]'       # Text Reset

# # Regular Colors
# Black='\[\033[0;30m\]'        # Black
# Red='\[\033[0;31m\]'          # Red
# Green='\[\033[0;32m\]'        # Green
# Yellow='\[\033[0;33m\]'       # Yellow
# Blue='\[\033[0;34m\]'         # Blue
# Purple='\[\033[0;35m\]'       # Purple
# Cyan='\[\033[0;36m\]'         # Cyan
# White='\[\033[0;37m\]'        # White

# User='\u'
# Host='\h'
# WkDir='\w'

# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWSTASHSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1
# # Explicitly unset color (default anyhow). Use 1 to set it.
# GIT_PS1_SHOWCOLORHINTS=
# GIT_PS1_DESCRIBE_STYLE="branch"
# GIT_PS1_SHOWUPSTREAM="auto git"
# GIT_PS1_SHOWCOLORHINTS=true

# source ~/.git-prompt.sh
source ~/.git-completion.sh
# Everyone needs a little color in their lives
RED='\[\033[31m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
BLUE='\[\033[34m\]'
PURPLE='\[\033[35m\]'
CYAN='\[\033[36m\]'
WHITE='\[\033[37m\]'
NIL='\[\033[00m\]'

# Hostname styles
FULL='\H'
SHORT='\h'

# System => color/hostname map:
# UC: username color
# LC: location/cwd color
# HD: hostname display (\h vs \H)
# Defaults:
UC=$GREEN
LC=$YELLOW
HD=$FULL

# Prompt function because PROMPT_COMMAND is awesome
function set_prompt() {
    # show the host only and be done with it.
    host="${UC}${HD}${NIL}"

    # Special vim-tab-like shortpath (~/folder/directory/foo => ~/f/d/foo)
    _pwd=`pwd | sed "s#$HOME#~#"`
    if [[ $_pwd == "~" ]]; then
        _dirname=$_pwd
    else
        _dirname=`dirname "$_pwd" `
        if [[ $_dirname == "/" ]]; then
            _dirname=""
        fi
        _dirname="$_dirname/`basename "$_pwd"`"
    fi
    path="${LC}${_dirname}${NIL}"
    myuser="${UC}\u${NIL}"

    # Dirtiness from:
    # http://henrik.nyh.se/2008/12/git-dirty-prompt#comment-8325834
    if git update-index -q --refresh 2>/dev/null; git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null && git diff-files --quiet --ignore-submodules 2>/dev/null
        then dirty="${GREEN}"
    else
        dirty="${RED}"
    fi
    _branch=$(git symbolic-ref HEAD 2>/dev/null)
    _branch=${_branch#refs/heads/} # apparently faster than sed
    branch="" # need this to clear it when we leave a repo
    if [[ -n $_branch ]]; then
        branch=" ${NIL}${dirty}${_branch}${NIL}"
    fi

    # Dollar/pound sign
    end="${NIL}\$${NIL} "

    # Virtual Env
    if [[ $VIRTUAL_ENV != "" ]]; then
        # ShortPath with venv (~/folder/directory/foo => ~/f/d/foo)
        _venv_path=`tail $VIRTUAL_ENV/.project`
        _pwd=`pwd | sed "s#${_venv_path}#PROJ#"`
        if [[ $_pwd == "PROJ" ]]; then
            _dirname=$_pwd
        else
            _dirname=`dirname "$_pwd" `
            if [[ $_dirname == "/" ]]; then
                _dirname=""
            fi
            _dirname="$_dirname/`basename "$_pwd"`"
        fi
        path="${LC}${_dirname}${NIL}"
        venv=" ${CYAN}(${VIRTUAL_ENV##*/})${NIL} "
    else
        venv=''
    fi


    export PS1="${myuser}${venv}${path}${branch} "
}

export PROMPT_COMMAND=set_prompt

# MacPorts Installer addition on 2013-01-25_at_07:16:45: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin
export NODE_PATH=$NODE_PATH:./

source ~/.complete-hosts.sh


## Virtual Env Wrapper
export WORKON_HOME=$HOME/virtual_envs
export PROJECT_HOME=$HOME/Documents/webdev
source /usr/local/bin/virtualenvwrapper.sh
