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

# update branch with latest changes from remote branch
# pass remote name or it will default to upstream
branchupdate() {
    upstream=${1:-upstream}
    branch=${2:-master}
    git fetch $upstream
    git fetch -p && git rebase -p @{u}
    git merge $upstream/$branch
    git push origin HEAD
}

# only merge upstream, don't push changes to branch
mergeupstreammaster() {
    upstream=${1:-upstream}
    branch=${2:-master}
    git fetch $upstream
    git merge $upstream/$branch
}

# addgitremote <remotename> <githubusername/forkname>
addgitremote() {
    REMOTES=`git remote -v`
    REMOTES=($REMOTES)

    UPSTREAM=$(echo "${REMOTES[1]}" | sed -E "s/:(\w+-?\w+)\//:${2}\//")

    git remote add $1 ${UPSTREAM}
}
