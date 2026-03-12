#!/bin/bash

notify() {
    local ci_str="$1"

    local pr_title="$2"

    local current_status="NONE"

    local prev_status="NONE"

    if [[ -z "$ci_str" ]]; then
        current_status="NONE"
    elif [[ "$ci_str" =~ x ]]; then
        current_status="FAILURE"
    elif [[ "$ci_str" =~ - ]]; then
        current_status="PENDING"
    else
        current_status="SUCCESS"
    fi

    prev_status=$(tmux show-options -wv @gh_ci_prev_status 2>/dev/null)

    if [[ "$current_status" == "SUCCESS" ]]; then
        if [[ "$prev_status" == "NONE" ]] || [[ "$prev_status" == "PENDING" ]]; then
            tmux display-popup -E -w 60 -h 5 "echo ''; echo 'ooo CI ALL SUCCESS! ooo'; echo '  > $pr_title'; sleep 5"
        fi
    fi

    tmux set-option -w @gh_ci_prev_status "$current_status"

    tmux set-option -w @gh_ci_prev_status "$current_status"
}

cd "${1:-$(pwd)}" 2>/dev/null || exit

pr_json=$(gh pr view --json title,state,isDraft,statusCheckRollup 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$pr_json" ]; then
    echo ""

    exit 0
fi


state_raw=$(echo "$pr_json" | jq -r 'if .isDraft then "Draft" else .state end')

title=$(echo "$pr_json" | jq -r '.title')

ci=$(echo "$pr_json" | jq -r '(.statusCheckRollup // [] | map(if .conclusion == "SUCCESS" then "o" elif .conclusion == "FAILURE" then "x" else "-" end) | join(""))')

notify "$ci" "$title"

printf "[Status]:%s [CI]:%s [Title]: %-60.60s" "$state_raw" "$ci" "$title"
