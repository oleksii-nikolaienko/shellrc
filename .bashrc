# https://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
# 0: Black, 1: Red, 2: Green, 3: Yellow, 4: Blue, 5: Magenta, 6: Cyan, 7: White
hostcolor=$( hostname | sum | awk 'BEGIN {c["10511"]="1"; c["12823"]="3"} {if (c[$1]!="") {print c[$1]} else {print "2"} }' )
#hostcolor=$(( $(hostname | sum | awk '{print $1}') % 5 + 1 ))

# https://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt/1862762
function timer_start {
  timer=${timer:-$SECONDS}
}
function timer_stop {
  timer_seconds=$(($SECONDS - $timer))
  #printf '%02d:%02d:%02d' $((SECONDS/3600)) $((SECONDS%3600/60)) $((SECONDS%60))
  unset timer
}
trap 'timer_start' DEBUG
EOL="\xE2\x86\xAF"
#EOL="\\u21af"
PROMPT_COMMAND='printf "$EOL%$((COLUMNS-1))s\\r" ; timer_stop'
PS1='[\t/$(printf "%04d" $timer_seconds)s] \[$(tput setaf $hostcolor)\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[$(tput sgr0)\]'

uname | grep -iq linux && LSCOL="--color=auto"
alias l='ls -alGFh $LSCOL'
alias ls='ls -GFh $LSCOL'
alias ..="cd .."
alias c="clear"
alias grep='grep --color=auto'
export GREP_COLORS='mt=0;38;5;255;48;5;196'
#http://bitmote.com/public/8-bit_color_table.png
alias less='less -R'
alias mc='LANG=en_EN.UTF-8 mc'

function git_status_all {
  find ./ -maxdepth 1 -mindepth 1 -type d | xargs -n1 -I{} sh -c "cd '{}' ; if [ -d .git ] ; then tput setaf 4 ; echo '{}' ; tput sgr0 ; git remote update ; git status ; fi ; cd .."
}

