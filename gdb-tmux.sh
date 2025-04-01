# https://github.com/cyrus-and/gdb-dashboard/wiki/Use-multiple-terminals
gdb-tmux() {
    local id="$(tmux split-pane -hPF "#D" "tail -f /dev/null")"
    tmux last-pane
    local tty="$(tmux display-message -p -t "$id" '#{pane_tty}')"
    \gdb -ex "dashboard -output $tty" -ex "dashboard -style syntax_highlighting 'vs'" "$@"
    tmux kill-pane -t "$id"
}

gdb-main() {
    if [[ ${TERM_PROGRAM} == "tmux" ]]; then
        gdb-tmux $@
    else
        \gdb $@
    fi
}

gdb-main $@
