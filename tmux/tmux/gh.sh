#!/bin/bash

pr_json=$(gh pr view --json state,isDraft,title,statusCheckRollup 2>/dev/null)

if [ -z "$pr_json" ]; then
    echo "(!) No Pull Request found."
    echo "--------------------------------------------------"
else
    title=$(echo "$pr_json" | jq -r '.title')
    state=$(echo "$pr_json" | jq -r 'if .isDraft then "DRAFT" else .state end')

    echo "PR: $title"
    echo "--------------------------------------------------"
    echo "Status: [${state}]"
    echo "CI Status:"
    echo "$pr_json" | jq -r '.statusCheckRollup[] | "\(.conclusion) \(.name)"' | while read -r line; do
        # st用にステータスを記号化して色付け
        case $line in
            SUCCESS*) echo -e "  [OK] ${line#SUCCESS }" ;;
            FAILURE*) echo -e "  [!!] ${line#FAILURE }" ;;
            SKIPPED*) echo -e "  [--] ${line#SKIPPED }" ;;
            PENDING*) echo -e "  [..] ${line#PENDING }" ;;
            *) echo "  [??] $line" ;;
        esac
    done | head -n 8 # 行数が増えすぎないよう制限

    echo "--------------------------------------------------"
fi

echo "--------------------------------------------------"
echo "o) PR View (Web)   s) PR Merge(Squash)"
echo "m) PR Merge(Rebase)"
echo "r) PR Ready        q) Quit"
echo "--------------------------------------------------"

read -n 1 -p "Select option: " sel
echo ""
case $sel in
    o)
        gh pr view -w
        ;;
    s)
        gh pr merge -s -d
        ;;
    m)
        gh pr merge -r -d
        ;;
    r)
        gh pr ready
        ;;
    q)
        exit 0
        ;;
    *)
        echo "Invalid option."
        sleep 1
        ;;
esac
