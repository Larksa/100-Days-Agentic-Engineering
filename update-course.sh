#!/bin/bash
# 100 Days of Agentic Engineering — Update Script
# Run this to get the latest course materials.
# Your projects and progress are never affected by updates.

set -e

# Always re-lock course files on exit, even if the script fails partway through
relock_files() {
    chmod -R a-w days/ 2>/dev/null || true
    chmod a-w CLAUDE.md 2>/dev/null || true
    chmod a-w README.md 2>/dev/null || true
    chmod a-w setup.sh 2>/dev/null || true
    chmod a-w update-course.sh 2>/dev/null || true
}
trap relock_files EXIT

echo ""
echo "=========================================="
echo "  Checking for course updates..."
echo "=========================================="
echo ""

# Check we're in the right directory
if [ ! -f "CLAUDE.md" ] || [ ! -d "days" ]; then
    echo "ERROR: Please run this from inside the 100-Days-Agentic-Engineering folder."
    echo ""
    echo "Try this:"
    echo "  cd 100-Days-Agentic-Engineering"
    echo "  bash update-course.sh"
    echo ""
    exit 1
fi

# Check if this is a git repo (ZIP downloads won't have .git/)
if [ ! -d ".git" ]; then
    echo "This copy of the course was downloaded as a ZIP file."
    echo "To get updates, please re-download the latest version from:"
    echo ""
    echo "  https://github.com/Larksa/100-Days-Agentic-Engineering/releases/latest"
    echo ""
    echo "Your projects in the 'projects/' folder won't be affected."
    echo "Just copy your 'projects/' folder and 'progress.json' to the new download."
    echo ""
    exit 0
fi

# Temporarily make course files writable so git can update them
chmod -R u+w days/ 2>/dev/null || true
chmod u+w CLAUDE.md 2>/dev/null || true
chmod u+w README.md 2>/dev/null || true
chmod u+w setup.sh 2>/dev/null || true
chmod u+w update-course.sh 2>/dev/null || true

# Reset any accidental local changes to course files
# (shouldn't happen with read-only, but just in case)
git checkout -- days/ CLAUDE.md README.md 2>/dev/null || true

# Pull latest changes
echo "  Downloading updates..."
echo ""
if git pull origin main --ff-only 2>&1; then
    echo ""
    echo "  ✓ Course updated to the latest version!"
else
    echo ""
    echo "  Could not update automatically."
    echo "  This sometimes happens if something unexpected changed."
    echo ""
    echo "  Try running the command again. If it still fails,"
    echo "  you can re-download the course from:"
    echo "    https://github.com/Larksa/100-Days-Agentic-Engineering/releases/latest"
    echo ""
    echo "  Your projects in 'projects/' are safe — they are never touched by updates."
fi

# Re-lock is handled by the EXIT trap above

echo ""
echo "=========================================="
echo ""
echo "  Run 'claude' to continue the course."
echo ""
echo "=========================================="
echo ""
