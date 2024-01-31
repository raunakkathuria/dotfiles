# ------------------------------------------------------------------------------------------------------------
#
# PERSONAL $HOME/.bash_profile
# By Raunak Kathuria
#
# This file is normally read by interactive shells only.
# Here is the place to define your aliases, functions and
# other interactive features like your prompt.
#
# ------------------------------------------------------------------------------------------------------------

#
# To __git_ps1 set we need to setup git-prompt.sh
# You can do this by
# curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
#
source ~/.git-prompt.sh

# Default interaction prompt
# 0 [06:22] root@debian-wheezy /home/git/organization/repo (branch) #
export PS1='$? \[\033[01;32m\][$(date +%H:%M)]\[\033[00m\] \[\033[01;31m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

# git grep for multiple repos
# go to parent directory where all repo are located then ggrep "search"
# you can also pass flags like ggrep -i "search" (for case insensitive search)
# -----------------------------------------
#
# go to /home/git then do ggrep "InvalidToken"
#
# Output:
#
# /home/git/org/repo1
# /home/git/org/repo2
# /home/git/org/repo3
# /home/git/org/repo3
# lib/v3/Utility.pm:59:            code              => 'InvalidToken',
# lib/v3/Utility.pm:142:            code              => "InvalidToken",
#
# -----------------------------------------
ggrep() {
    find . -type d -name .git | while read line; do
        (
        cd $line/..
        cwd=$(pwd)
        echo "$(tput setaf 2)$cwd$(tput sgr0)"
        git grep -n "$@"
        )
    done
}

# git replace for multiple repos
# go to parent directory where all repo are located then greplace <original_text> <new_text>
greplace() {
    if [ ! "$#" -eq 2 ]; then
      echo "Need <original_text> to replace and <new_text>";
      return 1;
    fi

    original_text=$1
    new_text=$2

    find . -type d -name .git | while read line; do
        (
        cd $line/..
        cwd=$(pwd)
        echo "$(tput setaf 2)$cwd$(tput sgr0)"
        git grep -l $original_text | xargs sed -i "s/"$original_text"/"$new_text"/g" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "replaced $original_text with $new_text"
        fi
        )
    done
}

# delete branches other than master
deletebranches() {
    git checkout master
    for i in $(git branch | sed -e s/\\*//g); do
        if [[ $i != "master" ]]; then
            git branch -D $i;
        fi
    done
}

# list branches of all repo in parent directory
listbranches() {
    find . -type d -name .git | while read line; do
        (
        cd $line
        cd ..
        cwd=$(pwd)
        echo "$(tput setaf 2)$cwd$(tput sgr0)"
        git branch
        )
    done
}

# list current active branch in all repos in parent directory
listactivebranches() {
    find . -type d -name .git | while read line; do
        (
        cd $line
        cd ..
        cwd=$(pwd)
        echo "$(tput setaf 2)$cwd$(tput sgr0)"
        git rev-parse --abbrev-ref HEAD
        )
    done
}

# only merge upstream, don't push changes to branch
mergeupstreammaster() {
    upstream=${1:-origin}
    branch=${2:-master}
    git fetch $upstream
    git merge $upstream/$branch
}

# addgitremote <remotename> <githubusername/forkname>
addgitremote() {
    REMOTES=`git remote -v`
    remotename=${1:-raunakkathuria}
    forkname=${1:-raunakkathuria}
    REMOTES=($REMOTES)

    UPSTREAM=$(echo "${REMOTES[1]}" | sed -E "s/:(\w+-?\w+)\//:${forkname}\//")

    git remote add $remotename ${UPSTREAM}
}

# need: sudo apt install xclip
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
