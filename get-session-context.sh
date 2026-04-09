#!/bin/bash
# Helper script to gather Codex session context for skillify

set -e

SESSION_ID="${SESSION_ID:-}"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"

find_session_id() {
    if [ -n "$SESSION_ID" ]; then
        echo "$SESSION_ID"
        return
    fi

    if [ -n "$CODEX_THREAD_ID" ]; then
        echo "$CODEX_THREAD_ID"
        return
    fi

    if [ -n "$CODEX_SESSION_ID" ]; then
        echo "$CODEX_SESSION_ID"
        return
    fi

    if [ -f "$CODEX_HOME/history.jsonl" ]; then
        tail -1 "$CODEX_HOME/history.jsonl" 2>/dev/null | grep -o '"session_id":"[^"]*"' | cut -d'"' -f4
    fi
}

find_session_dir() {
    local sid="$1"
    local file

    if [ ! -d "$CODEX_HOME/sessions" ]; then
        return
    fi

    file=$(find "$CODEX_HOME/sessions" -type f -name "*$sid*.jsonl" | head -1 || true)
    if [ -n "$file" ]; then
        dirname "$file"
    fi
}

print_session_info() {
    local sid="$1"

    echo "=== CODEX SESSION CONTEXT ==="
    echo ""
    echo "Session ID: $sid"
    echo ""
    echo "=== SESSION INFO ==="

    if [ -f "$CODEX_HOME/session_index.jsonl" ]; then
        local session_info
        session_info=$(grep "\"id\":\"$sid\"" "$CODEX_HOME/session_index.jsonl" | head -1 || true)
        if [ -n "$session_info" ]; then
            echo "Thread name: $(echo "$session_info" | grep -o '"thread_name":"[^"]*"' | cut -d'"' -f4 || echo "N/A")"
            echo "Updated: $(echo "$session_info" | grep -o '"updated_at":"[^"]*"' | cut -d'"' -f4 || echo "N/A")"
        else
            echo "No session index entry found."
        fi
    else
        echo "No session index found at $CODEX_HOME/session_index.jsonl"
    fi

    local session_dir
    session_dir=$(find_session_dir "$sid")
    echo "Session dir: ${session_dir:-not found}"
}

print_recent_user_messages() {
    local sid="$1"

    echo ""
    echo "=== RECENT USER MESSAGES ==="

    if [ -f "$CODEX_HOME/history.jsonl" ]; then
        grep "\"session_id\":\"$sid\"" "$CODEX_HOME/history.jsonl" | \
        tail -20 | \
        sed -n 's/.*"text":"\([^"]*\)".*/\1/p'
    else
        echo "No history found at $CODEX_HOME/history.jsonl"
    fi
}

print_recent_memories() {
    echo ""
    echo "=== MEMORIES ==="

    if [ -d "$CODEX_HOME/memories" ]; then
        ls -la "$CODEX_HOME/memories/" 2>/dev/null | tail -10 || echo "No memories available"
    else
        echo "No Codex memories directory found."
    fi
}

main() {
    local sid
    sid=$(find_session_id)

    if [ -z "$sid" ]; then
        echo "No Codex session ID found."
        echo "Set SESSION_ID, CODEX_THREAD_ID, or CODEX_SESSION_ID, or ensure $CODEX_HOME/history.jsonl exists."
        exit 1
    fi

    print_session_info "$sid"
    print_recent_user_messages "$sid"
    print_recent_memories
}

main
