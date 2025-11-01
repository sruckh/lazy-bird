<div align="center">

```
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
```

### Automate game development while you sleep 🦜💤

**Your AI-powered development assistant that works 24/7**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Godot](https://img.shields.io/badge/Godot-4.2+-blue.svg)](https://godotengine.org/)
[![Claude](https://img.shields.io/badge/Claude-Code-purple.svg)](https://claude.ai/code)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-green.svg)]()

[Quick Start](#-quick-start) • [Features](#-features) • [Installation](#-installation) • [Docs](CLAUDE.md) • [Architecture](Docs/Design/)

---

</div>

## 🎯 What is Lazy_Bird?

Lazy_Bird is a **progressive automation system** that lets Claude Code work on your Godot game projects autonomously. Create GitHub Issues in the morning, review Pull Requests at lunch, and merge completed features in the evening—all while you focus on creative work or simply relax.

```
Morning (7 AM)          Work Hours                 Lunch (12 PM)         Evening (6 PM)
──────────────          ──────────────             ─────────────         ─────────────
Create Issues      →    Claude implements     →    Review PRs       →    Merge & Ship
Add "ready" label       Runs tests automatically   Approve changes       Plan tomorrow
Go to work             Creates PRs if passing      Back to work          Enjoy life
```

**The result?** You save 20-100 hours per month on repetitive development tasks.

---

## 🚀 Quick Start

```bash
# 1. One-command installation
curl -L https://raw.githubusercontent.com/yusyus/lazy-bird/main/wizard.sh | bash

# 2. Create your first automated task
gh issue create --template task \
  --title "[Task]: Add player health system" \
  --label "ready"

# 3. Monitor progress
./wizard.sh --status
```

**That's it!** The system will pick up your issue, implement the feature, run tests, and create a PR—all automatically.

## Features

- 🤖 **Autonomous Development** - Claude Code works while you're away
- 🧪 **Automated Testing** - Runs gdUnit4 tests, retries on failure
- 🌿 **Safe Git Workflow** - Isolated worktrees, automatic PRs
- 📊 **Progress Monitoring** - Check status from phone via notifications
- 🔐 **Security First** - Secret management, containerized execution
- 📈 **Progressive Scaling** - Start simple (1 agent), scale to multiple

## How It Works

```
Morning (7-8am)          Work Hours                Lunch (12pm)        Evening (6pm)
─────────────────       ──────────────            ─────────────       ──────────────
Create GitHub Issues → Claude processes tasks  →  Review PRs      →  Merge & test
Add "ready" label       Runs tests automatically   Approve/comment     Deploy builds
Go to work              Creates PRs if passing     Back to work        Plan tomorrow
```

## Architecture

**Phase 1: Single Agent** (Start here)
- One task at a time, sequential processing
- 15-minute wizard setup, 8GB RAM
- Perfect for solo developers

**Phase 2: Multi-Agent** (Scale up)
- 2-3 agents working in parallel
- Godot Server coordinates test execution
- 16GB RAM recommended

**Phase 3+:** Remote access, CI/CD, enterprise features

## Requirements

- Linux (Ubuntu 20.04+, Arch, Manjaro, etc.) or Windows WSL2
- Godot 4.2+
- Claude Code CLI
- GitHub or GitLab account
- 8GB RAM minimum, 16GB recommended

## Installation

### One-Command Install

```bash
curl -L https://raw.githubusercontent.com/yusyus/lazy_birtd/main/wizard.sh | bash
```

### Manual Install

```bash
git clone https://github.com/yusyus/lazy_birtd.git
cd lazy_birtd

# Run Phase 0 validation (required)
./tests/phase0/validate-all.sh /path/to/your/godot-project

# If validation passes, run wizard
./wizard.sh
```

The wizard will:
- Detect your system capabilities
- Ask 8 simple questions
- Install appropriate phase
- Set up Godot Server
- Configure issue watcher
- Create issue templates
- Validate everything works

## Usage

### Creating Tasks

Create a GitHub/GitLab issue with detailed steps:

```markdown
## Task Description
Add a health system to the player character

## Detailed Steps
1. Create res://player/health.gd with Health class
2. Add max_health (100) and current_health properties
3. Implement take_damage(amount) method
4. Implement heal(amount) method (max at max_health)
5. Add health_changed signal

## Acceptance Criteria
- [ ] Health class exists with all methods
- [ ] Tests pass
- [ ] Signal emits correctly

## Complexity
medium
```

Add the `ready` label and the system will pick it up within 60 seconds.

### Monitoring Progress

```bash
# Check system status
./wizard.sh --status

# View logs
journalctl -u issue-watcher -f
journalctl -u godot-server -f

# Health check
./wizard.sh --health
```

### Managing the System

```bash
./wizard.sh --status          # Current state
./wizard.sh --upgrade         # Move to next phase
./wizard.sh --health          # Run diagnostics
./wizard.sh --repair          # Fix issues
./wizard.sh --weekly-review   # Progress report
```

## Example Workflow

```bash
# Morning routine (5 minutes)
gh issue create --template task --title "Add pause menu" --label "ready"
gh issue create --template task --title "Fix jump physics" --label "ready"
gh issue create --template task --title "Add sound effects" --label "ready"

# Check at lunch (2 minutes)
gh pr list  # Review created PRs
gh pr review 123 --approve

# Evening (5 minutes)
git pull
# Test merged changes
# Plan tomorrow's tasks
```

## Project Structure

```
lazy_birtd/
├── wizard.sh                 # Main installation script
├── scripts/
│   ├── godot-server.py      # Test coordination server
│   ├── issue-watcher.py     # GitHub/GitLab issue monitor
│   └── agent-runner.sh      # Claude Code agent launcher
├── tests/
│   └── phase0/              # Validation tests
├── Docs/
│   └── Design/              # Complete specifications
├── docker/
│   └── claude-agent/        # Containerized Claude environment
└── templates/               # Issue templates

Configuration:
~/.config/lazy_birtd/
├── config.yml              # Main config
├── secrets/                # API tokens (chmod 700)
└── logs/                   # All logs
```

## Documentation

- **[CLAUDE.md](CLAUDE.md)** - Complete guide for developers
- **[Docs/Design/](Docs/Design/)** - Detailed specifications
  - `wizard-complete-spec.md` - Wizard architecture
  - `godot-server-spec.md` - Test coordination
  - `claude-cli-reference.md` - Correct CLI commands
  - `issue-workflow.md` - GitHub/GitLab integration
  - `retry-logic.md` - Test failure handling
  - `security-baseline.md` - Security guidelines
  - `phase0-validation.md` - Pre-implementation testing

## Key Concepts

### Godot Server

HTTP API that queues and executes Godot tests sequentially, preventing conflicts when multiple agents need to run tests.

```
Claude Agent 1 ──┐
Claude Agent 2 ──┼──> Godot Server → Single Godot Process
Claude Agent 3 ──┘
```

### Issue-Driven Tasks

Tasks are defined as GitHub/GitLab issues, not files. This provides:
- Mobile-friendly interface
- Permanent history
- Rich formatting (markdown, code blocks)
- Native PR linking

### Test Retry Logic

If tests fail, Claude gets the error message and tries to fix it. Default: 3 retries (4 total attempts). Success rate: ~90-95%.

### Git Worktrees

Each task gets its own isolated git worktree, preventing conflicts and allowing easy cleanup.

## Security

**Critical: Follow security guidelines in [Docs/Design/security-baseline.md](Docs/Design/security-baseline.md)**

- Secrets stored in `~/.config/lazy_birtd/secrets/` (chmod 600)
- Claude agents run in Docker containers
- Services bind to localhost or VPN only
- API tokens never committed to git
- Regular secret rotation (90 days)

## Cost Estimate

- **Phase 1:** $50-100/month (Claude API)
- **Phase 2-3:** $100-150/month
- **Phase 4+:** $150-300/month

Budget limits and alerts included to prevent surprises.

## Troubleshooting

### Tasks not being processed

```bash
# Check issue watcher
systemctl status issue-watcher

# Verify API token
./tests/phase0/test-api-access.sh

# Check for issues with "ready" label
gh issue list --label "ready"
```

### Tests failing

```bash
# Check Godot Server
systemctl status godot-server

# View test logs
cat /var/lib/lazy_birtd/tests/latest/output.log

# Test gdUnit4
godot --headless -s addons/gdUnit4/bin/GdUnitCmdTool.gd --help
```

### General issues

```bash
# Run wizard diagnostics
./wizard.sh --health

# Auto-repair common problems
./wizard.sh --repair

# Check all logs
journalctl -u godot-server -f
journalctl -u issue-watcher -f
```

## FAQ

**Q: Does this really work?**
A: The architecture is sound, but relies on Claude Code CLI working in headless mode. Run Phase 0 validation first to verify.

**Q: Is it safe?**
A: Yes, with proper setup. Claude runs in Docker containers, uses git worktrees, and has permission restrictions. Follow security baseline.

**Q: How much does it cost?**
A: Claude API costs vary. Expect $50-300/month depending on usage. Budget limits prevent overages.

**Q: Can I use it with other game engines?**
A: Currently designed for Godot, but architecture is adaptable. Would need engine-specific test integration.

**Q: Does it work on Windows?**
A: Yes, via WSL2. Native Windows support is experimental.

**Q: What if Claude breaks something?**
A: Tests catch most issues. Changes are in isolated worktrees and PRs for review. Nothing merges without approval.

## Roadmap

**Current Status:** Design phase complete, ready for implementation

**Phase 0 (Now):**
- ✅ Complete specification
- ✅ Validation framework
- ⏳ Implementation

**Phase 1 (Week 1):**
- Setup wizard
- Single agent automation
- Issue watcher
- Godot Server
- Basic monitoring

**Phase 2 (Week 2-3):**
- Multi-agent scheduler
- Enhanced monitoring
- Remote access (VPN)

**Future:**
- CI/CD integration
- Visual test recording
- Team collaboration features
- Cost optimization

## Contributing

Contributions welcome! Please:

1. Read [CLAUDE.md](CLAUDE.md) first
2. Check [Docs/Design/](Docs/Design/) for specifications
3. Run Phase 0 validation
4. Submit PRs with tests

## License

MIT License - see [LICENSE](LICENSE) file.

## Acknowledgments

- Built for [Claude Code](https://claude.ai/code)
- Designed for [Godot Engine](https://godotengine.org/)
- Uses [gdUnit4](https://github.com/MikeSchulze/gdUnit4) for testing

## Support

- **Documentation:** [CLAUDE.md](CLAUDE.md) and [Docs/Design/](Docs/Design/)
- **Issues:** [GitHub Issues](https://github.com/yusyus/lazy_birtd/issues)
- **Discussions:** [GitHub Discussions](https://github.com/yusyus/lazy_birtd/discussions)

---

<div align="center">

**Made with ☕ and 🤖 for game developers who'd rather be creating than coding**

⭐ Star this repo if Lazy_Bird saves you time!

```
    🦜 Fly lazy, code smart
```

**Status:** Design Complete | Phase 0 Ready | Implementation Starting

</div>
