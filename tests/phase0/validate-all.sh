#!/bin/bash
# Phase 0: Complete Validation Suite
# Master script that runs all Phase 0 validation tests

set -euo pipefail

echo "╔════════════════════════════════════════╗"
echo "║  Phase 0: Complete Validation Suite   ║"
echo "╚════════════════════════════════════════╝"
echo ""

PROJECT_PATH="${1:-}"

if [ -z "$PROJECT_PATH" ]; then
    echo "Usage: $0 <godot-project-path>"
    echo ""
    echo "Example:"
    echo "  $0 /home/user/my-godot-game"
    echo ""
    echo "This script runs all Phase 0 validation tests:"
    echo "  1. Claude Code CLI validation"
    echo "  2. Godot + gdUnit4 validation"
    echo "  3. Git worktree validation"
    exit 1
fi

if [ ! -d "$PROJECT_PATH" ]; then
    echo "Error: Project path does not exist: $PROJECT_PATH"
    exit 1
fi

# Get absolute path to scripts directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SCRIPTS_PATH="$SCRIPT_DIR/scripts"

# Verify scripts exist
if [ ! -f "$SCRIPTS_PATH/validate-claude.sh" ]; then
    echo "Error: validate-claude.sh not found at $SCRIPTS_PATH/validate-claude.sh"
    exit 1
fi

if [ ! -f "$SCRIPTS_PATH/validate-godot.sh" ]; then
    echo "Error: validate-godot.sh not found at $SCRIPTS_PATH/validate-godot.sh"
    exit 1
fi

if [ ! -f "$SCRIPTS_PATH/test-worktree.sh" ]; then
    echo "Error: test-worktree.sh not found at $SCRIPTS_PATH/test-worktree.sh"
    exit 1
fi

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Track results
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Track individual script results
CLAUDE_RESULT=0
GODOT_RESULT=0
WORKTREE_RESULT=0

echo "Project: $PROJECT_PATH"
echo ""
echo "Running validation scripts..."
echo "════════════════════════════════════════"
echo ""

# Test 1: Claude Code Validation
echo -e "${BLUE}[1/3]${NC} Claude Code CLI Validation"
echo "────────────────────────────────────────"
TESTS_RUN=$((TESTS_RUN + 1))

if "$SCRIPTS_PATH/validate-claude.sh"; then
    CLAUDE_RESULT=0
    TESTS_PASSED=$((TESTS_PASSED + 1))
    echo -e "${GREEN}✅ PASSED${NC} - Claude Code validation successful"
else
    CLAUDE_RESULT=$?
    TESTS_FAILED=$((TESTS_FAILED + 1))
    echo -e "${RED}❌ FAILED${NC} - Claude Code validation failed"
fi

echo ""
echo ""

# Test 2: Godot + gdUnit4 Validation
echo -e "${BLUE}[2/3]${NC} Godot + gdUnit4 Validation"
echo "────────────────────────────────────────"
TESTS_RUN=$((TESTS_RUN + 1))

if "$SCRIPTS_PATH/validate-godot.sh" "$PROJECT_PATH"; then
    GODOT_RESULT=0
    TESTS_PASSED=$((TESTS_PASSED + 1))
    echo -e "${GREEN}✅ PASSED${NC} - Godot validation successful"
else
    GODOT_RESULT=$?
    TESTS_FAILED=$((TESTS_FAILED + 1))
    echo -e "${RED}❌ FAILED${NC} - Godot validation failed"
fi

echo ""
echo ""

# Test 3: Git Worktree Validation
echo -e "${BLUE}[3/3]${NC} Git Worktree Validation"
echo "────────────────────────────────────────"
TESTS_RUN=$((TESTS_RUN + 1))

if "$SCRIPTS_PATH/test-worktree.sh" "$PROJECT_PATH"; then
    WORKTREE_RESULT=0
    TESTS_PASSED=$((TESTS_PASSED + 1))
    echo -e "${GREEN}✅ PASSED${NC} - Worktree validation successful"
else
    WORKTREE_RESULT=$?
    TESTS_FAILED=$((TESTS_FAILED + 1))
    echo -e "${RED}❌ FAILED${NC} - Worktree validation failed"
fi

echo ""
echo ""

# Final Summary
echo "╔════════════════════════════════════════╗"
echo "║      PHASE 0 VALIDATION SUMMARY        ║"
echo "╠════════════════════════════════════════╣"
printf "║ %-20s %17s ║\n" "Tests Run:" "$TESTS_RUN"
printf "║ %-20s %17s ║\n" "Passed:" "$TESTS_PASSED"
printf "║ %-20s %17s ║\n" "Failed:" "$TESTS_FAILED"
echo "╠════════════════════════════════════════╣"

# Individual results
if [ $CLAUDE_RESULT -eq 0 ]; then
    printf "║ %-20s %17s ║\n" "Claude Code:" "✓ PASS"
else
    printf "║ %-20s %17s ║\n" "Claude Code:" "✗ FAIL"
fi

if [ $GODOT_RESULT -eq 0 ]; then
    printf "║ %-20s %17s ║\n" "Godot + gdUnit4:" "✓ PASS"
else
    printf "║ %-20s %17s ║\n" "Godot + gdUnit4:" "✗ FAIL"
fi

if [ $WORKTREE_RESULT -eq 0 ]; then
    printf "║ %-20s %17s ║\n" "Git Worktrees:" "✓ PASS"
else
    printf "║ %-20s %17s ║\n" "Git Worktrees:" "✗ FAIL"
fi

echo "╚════════════════════════════════════════╝"
echo ""

# Final verdict
if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✅ ALL PHASE 0 VALIDATIONS PASSED  ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo "Your system is ready for Lazy_Bird automation!"
    echo ""
    echo "Verified:"
    echo "  ✓ Claude Code CLI (8 tests)"
    echo "  ✓ Godot 4.x + gdUnit4 (10 tests)"
    echo "  ✓ Git worktrees for multi-agent (10 tests)"
    echo ""
    echo "Total: 28 tests passed across all validation scripts"
    echo ""
    echo "Next Steps:"
    echo "  1. Run the setup wizard: ./wizard.sh"
    echo "  2. Create your first issue with 'ready' label"
    echo "  3. Watch Lazy_Bird automate your game development!"
    echo ""
    exit 0
else
    echo -e "${RED}╔═══════════════════════════════════════╗${NC}"
    echo -e "${RED}║    ❌ PHASE 0 VALIDATION FAILED      ║${NC}"
    echo -e "${RED}╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo "Failed: $TESTS_FAILED/$TESTS_RUN validation script(s)"
    echo ""
    echo "Please fix the failures above before proceeding."
    echo "Review the error messages and consult documentation:"
    echo "  - Docs/Design/phase0-validation.md"
    echo "  - Docs/Design/claude-cli-reference.md"
    echo ""
    exit 1
fi
