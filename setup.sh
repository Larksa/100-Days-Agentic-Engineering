#!/bin/bash
# 100 Days of Agentic Engineering — Setup Script
# Run this once after downloading the course.
# With --install flag: downloads the course first, then sets up.

set -e

REPO_URL="https://github.com/Larksa/100-Days-Agentic-Engineering.git"
COURSE_DIR="100-Days-Agentic-Engineering"

# ─── Install Mode ───────────────────────────────────────────────
# When called with --install, download the course first
if [ "$1" = "--install" ]; then
    echo ""
    echo "=========================================="
    echo "  100 Days of Agentic Engineering"
    echo "  Downloading the course..."
    echo "=========================================="
    echo ""

    # Check if git is available
    if ! command -v git &> /dev/null; then
        echo "ERROR: Git is not installed on your computer."
        echo ""
        echo "Install it first:"
        echo "  Mac:     Run 'xcode-select --install' in Terminal"
        echo "  Windows: Git comes with WSL (Ubuntu)"
        echo "  Linux:   Run 'sudo apt install git'"
        echo ""
        exit 1
    fi

    # Check if course folder already exists
    if [ -d "$COURSE_DIR" ]; then
        echo "The course folder already exists!"
        echo "If you want a fresh download, remove it first:"
        echo "  rm -rf $COURSE_DIR"
        echo ""
        echo "Or to update your existing course:"
        echo "  cd $COURSE_DIR"
        echo "  bash update-course.sh"
        echo ""
        exit 1
    fi

    # Clone the repo
    echo "Downloading course files..."
    git clone "$REPO_URL" "$COURSE_DIR"
    cd "$COURSE_DIR"

    echo "✓ Course downloaded"
    echo ""
    # Fall through to setup steps below
fi

# ─── Setup Mode ─────────────────────────────────────────────────
echo ""
echo "=========================================="
echo "  100 Days of Agentic Engineering"
echo "  Setting up your course..."
echo "=========================================="
echo ""

# Check we're in the right directory
if [ ! -f "CLAUDE.md" ] || [ ! -d "days" ]; then
    echo "ERROR: Please run this from inside the 100-Days-Agentic-Engineering folder."
    echo ""
    echo "Try this:"
    echo "  cd 100-Days-Agentic-Engineering"
    echo "  bash setup.sh"
    echo ""
    exit 1
fi

# Create projects folder if it doesn't exist
mkdir -p projects
if [ ! -f "projects/.gitkeep" ]; then
    touch projects/.gitkeep
fi

# Create a fresh progress.json if it doesn't exist
if [ ! -f "progress.json" ]; then
    echo '{"last_completed": 0, "days_completed": [], "days_started": []}' > progress.json
    echo "  ✓ Created your progress tracker"
else
    echo "  ✓ Progress tracker already exists (keeping your progress)"
fi

# Set course files to read-only (student can't accidentally edit)
chmod -R a-w days/
chmod a-w CLAUDE.md
chmod a-w README.md
echo "  ✓ Course files protected (read-only)"

# Make sure projects folder is writable
chmod -R u+w projects/
chmod u+w progress.json 2>/dev/null || true
echo "  ✓ Your project folder is ready"

# Make scripts executable
chmod u+x setup.sh 2>/dev/null || true
chmod u+x update-course.sh 2>/dev/null || true

echo ""
echo "=========================================="
echo ""
echo "  You're all set!"
echo ""
echo "  To start the course, type:"
echo ""
echo "    claude"
echo ""
echo "  When Claude opens, type:"
echo ""
echo "    day 1"
echo ""
echo "=========================================="
echo ""
