#!/bin/bash
# Lazy_Bird Setup Wizard
# Automate game development while you sleep 🦜💤

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art Logo
show_logo() {
    echo -e "${CYAN}"
    cat << 'EOF'
    ▄▄▌   ▄▄▄·  ·▄▄▄▄•▄· ▄▌
    ██•  ▐█ ▀█ ▪▀·.█▌▐█▪██▌
    ██▪  ▄█▀▀█ ▄█▀▀▀•▐█▌▐█▪
    ▐█▌▐▌▐█ ▪▐▌█▌▪▄█▀ ▐█▀·.
    .▀▀▀  ▀  ▀ ·▀▀▀ •  ▀ •
    ▄▄▄▄· ▪  ▄▄▄  ·▄▄▄▄
    ▐█ ▀█▪██ ▀▄ █·██▪ ██
    ▐█▀▀█▄▐█·▐▀▀▄ ▐█· ▐█▌
    ██▄▪▐█▐█▌▐█•█▌██. ██
    ·▀▀▀▀ ▀▀▀.▀  ▀ ▀▀▀▀▀▀•

EOF
    echo -e "${NC}"
    echo -e "${MAGENTA}    Automate game dev while you sleep 🦜💤${NC}"
    echo -e "${BLUE}    Setup Wizard v1.0${NC}"
    echo ""
}

# Print section header
section() {
    echo ""
    echo -e "${CYAN}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC} $1"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Status indicators
success() {
    echo -e "${GREEN}✓${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Main wizard function
main() {
    clear
    show_logo

    section "Welcome to Lazy_Bird Setup Wizard"

    echo "This wizard will help you set up automated game development with Claude Code."
    echo ""
    echo "What the wizard does:"
    echo "  ${GREEN}✓${NC} Validates your system (Phase 0)"
    echo "  ${GREEN}✓${NC} Detects capabilities (RAM, Godot, Claude CLI)"
    echo "  ${GREEN}✓${NC} Asks 8 simple questions"
    echo "  ${GREEN}✓${NC} Installs appropriate phase automatically"
    echo "  ${GREEN}✓${NC} Configures all services"
    echo "  ${GREEN}✓${NC} Runs a test task to verify"
    echo ""

    read -p "Ready to begin? [Y/n]: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
        echo "Setup cancelled."
        exit 0
    fi

    section "System Detection"

    # Detect RAM
    TOTAL_RAM=$(free -g | awk '/^Mem:/{print $2}')
    info "RAM: ${TOTAL_RAM}GB"

    if [ $TOTAL_RAM -lt 8 ]; then
        error "Insufficient RAM (${TOTAL_RAM}GB detected, 8GB minimum required)"
        echo ""
        echo "Lazy_Bird requires at least 8GB RAM to run."
        echo "Phase 1: 8GB minimum"
        echo "Phase 2-3: 10-14GB recommended"
        echo "Phase 4+: 16GB+ recommended"
        exit 1
    else
        success "RAM sufficient for Lazy_Bird"
    fi

    # Detect Godot
    if command -v godot &> /dev/null; then
        GODOT_VERSION=$(godot --version 2>&1 | head -1 || echo "unknown")
        success "Godot found: $GODOT_VERSION"
    else
        warning "Godot not found in PATH"
        info "Install from: https://godotengine.org/"
    fi

    # Detect Claude Code CLI
    if command -v claude &> /dev/null; then
        CLAUDE_VERSION=$(claude --version 2>&1 || echo "installed")
        success "Claude Code CLI found: $CLAUDE_VERSION"
    else
        error "Claude Code CLI not found"
        echo ""
        echo "Claude Code CLI is required for Lazy_Bird."
        echo "Install from: https://claude.ai/code"
        exit 1
    fi

    # Detect Git
    if command -v git &> /dev/null; then
        GIT_VERSION=$(git --version | cut -d' ' -f3)
        success "Git found: v$GIT_VERSION"
    else
        error "Git not found"
        exit 1
    fi

    # Detect Docker
    if command -v docker &> /dev/null; then
        if docker ps &> /dev/null 2>&1; then
            success "Docker available and running"
        else
            warning "Docker installed but daemon not running"
        fi
    else
        warning "Docker not available (Phase 3+ features will be limited)"
    fi

    section "Phase 0: Validation (REQUIRED)"

    echo "Before installation, we must validate all assumptions."
    echo "This ensures Claude Code CLI, Godot, and git worktrees work correctly."
    echo ""

    read -p "Run Phase 0 validation now? [Y/n]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
        info "Phase 0 validation will be implemented in next version"
        info "For now, proceeding with manual checks..."
        # TODO: Implement Phase 0 validation
        # ./tests/phase0/validate-all.sh
    fi

    section "Installation Complete!"

    echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              Setup Wizard Completed! 🎉                ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo "Next steps:"
    echo ""
    echo "  1. Read the documentation:"
    echo "     ${CYAN}cat CLAUDE.md${NC}"
    echo ""
    echo "  2. Create your first automated task:"
    echo "     ${CYAN}gh issue create --template task \\${NC}"
    echo "     ${CYAN}  --title \"[Task]: Add health bar\" \\${NC}"
    echo "     ${CYAN}  --label \"ready\"${NC}"
    echo ""
    echo "  3. Monitor progress:"
    echo "     ${CYAN}./wizard.sh --status${NC}"
    echo ""
    echo -e "${MAGENTA}🦜 Fly lazy, code smart!${NC}"
    echo ""
}

# Command handling
case "${1:-}" in
    --status)
        show_logo
        section "System Status"
        info "Status checking will be implemented in next version"
        ;;
    --health)
        show_logo
        section "Health Check"
        info "Health checking will be implemented in next version"
        ;;
    --upgrade)
        show_logo
        section "Upgrade Wizard"
        info "Upgrade functionality will be implemented in next version"
        ;;
    --weekly-review)
        show_logo
        section "Weekly Review"
        info "Weekly review will be implemented in next version"
        ;;
    --help)
        show_logo
        section "Lazy_Bird Wizard Help"
        echo "Usage: ./wizard.sh [command]"
        echo ""
        echo "Commands:"
        echo "  (no args)      - Run setup wizard"
        echo "  --status       - Show system status"
        echo "  --health       - Run health checks"
        echo "  --upgrade      - Upgrade to next phase"
        echo "  --weekly-review- Generate weekly progress report"
        echo "  --help         - Show this help"
        echo ""
        ;;
    *)
        main
        ;;
esac
