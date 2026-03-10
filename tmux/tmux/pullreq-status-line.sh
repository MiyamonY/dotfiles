#!/bin/bash
cd "${1:-$(pwd)}" 2>/dev/null || exit

pr_json=$(gh pr view --json title,state,isDraft,statusCheckRollup 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$pr_json" ]; then
    echo ""

    exit 0
fi


state_raw=$(echo "$pr_json" | jq -r 'if .isDraft then "Draft" else .state end')

title=$(echo "$pr_json" | jq -r '.title')

ci=$(echo "$pr_json" | jq -r '(.statusCheckRollup // [] | map(if .conclusion == "SUCCESS" then "o" elif .conclusion == "FAILURE" then "x" else "-" end) | join(""))')

printf "[Status]:%s [CI]:%s [Title]: %-60.60s" "$state_raw" "$ci" "$title"
