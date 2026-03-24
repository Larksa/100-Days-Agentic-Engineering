#!/bin/bash
# Tests for setup.sh and update-course.sh
# Run from the repo root: bash tests/test-setup.sh

set -e

# Always restore admin write permissions, even if test is interrupted
trap 'chmod -R u+w days/ CLAUDE.md README.md 2>/dev/null' EXIT

PASS=0
FAIL=0
ERRORS=""

# Helper function
check() {
    local description="$1"
    local command="$2"
    local expected="$3"

    if eval "$command" > /dev/null 2>&1; then
        if [ "$expected" = "should_fail" ]; then
            FAIL=$((FAIL + 1))
            ERRORS="$ERRORS\n  FAIL: $description (expected failure, got success)"
        else
            PASS=$((PASS + 1))
            echo "  ✓ $description"
        fi
    else
        if [ "$expected" = "should_fail" ]; then
            PASS=$((PASS + 1))
            echo "  ✓ $description"
        else
            FAIL=$((FAIL + 1))
            ERRORS="$ERRORS\n  FAIL: $description"
        fi
    fi
}

echo ""
echo "Running setup tests..."
echo ""

# ─── Test setup.sh exists and is executable ─────────────────
check "setup.sh exists" "test -f setup.sh"
check "setup.sh is executable" "test -x setup.sh"

# ─── Test update-course.sh exists and is executable ─────────
check "update-course.sh exists" "test -f update-course.sh"
check "update-course.sh is executable" "test -x update-course.sh"

# ─── Run setup.sh ───────────────────────────────────────────
echo ""
echo "Running setup.sh..."
bash setup.sh

echo ""
echo "Verifying setup results..."
echo ""

# ─── Test course files are read-only ────────────────────────
check "days/ is read-only" "test ! -w days/day-01.md"
check "CLAUDE.md is read-only" "test ! -w CLAUDE.md"
check "README.md is read-only" "test ! -w README.md"

# ─── Test writing to course files fails ─────────────────────
check "Cannot write to days/day-01.md" "echo test >> days/day-01.md" "should_fail"
check "Cannot write to CLAUDE.md" "echo test >> CLAUDE.md" "should_fail"

# ─── Test student files are writable ────────────────────────
check "projects/ directory exists" "test -d projects"
check "progress.json exists" "test -f progress.json"
check "progress.json is writable" "test -w progress.json"

# ─── Test progress.json has valid JSON ──────────────────────
check "progress.json is valid JSON" "python3 -c 'import json; json.load(open(\"progress.json\"))'"

# ─── Test student can create project files ──────────────────
mkdir -p projects/test-project
echo "test" > projects/test-project/test.txt
check "Can create files in projects/" "test -f projects/test-project/test.txt"
rm -rf projects/test-project

# ─── Restore write permissions for admin ────────────────────
chmod -R u+w days/ CLAUDE.md README.md

# ─── Report ─────────────────────────────────────────────────
echo ""
echo "=========================================="
echo "  Results: $PASS passed, $FAIL failed"
echo "=========================================="
if [ $FAIL -gt 0 ]; then
    printf "%b\n" "$ERRORS"
    echo ""
    exit 1
else
    echo "  All tests passed!"
    echo ""
fi
