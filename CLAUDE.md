# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles managed with **GNU Stow**. Each top-level directory is a Stow *package* whose internal tree mirrors the target layout under `$HOME`. For example `zsh/.zshrc` symlinks to `~/.zshrc`, and `helix/.config/helix/config.toml` symlinks to `~/.config/helix/config.toml`.

## Deploying changes

There is no install script. Symlinks are created/refreshed with `stow` from the repo root:

```sh
stow zsh        # link a single package into $HOME
stow */         # link all packages
stow -D zsh     # remove (unlink) a package
stow -R zsh     # restow (relink) after adding/removing files in a package
```

Editing a file in this repo edits the live config through the symlink — no copy step. Adding a *new* file to an already-stowed package requires `stow -R <pkg>` so the new path gets linked.

Package installs are tracked in `brew-list` (formulae) and `brew-cask-list` (casks); these are plain manifests, not lockfiles.

## Architecture conventions

- **XDG-first.** Config lives under `~/.config`, state under `~/.local/state`, data under `~/.local/share`, cache under `~/.cache`. These are exported in `zsh/.config/zsh/rc.zsh`. New tool configs should follow XDG paths, not dotfiles in `$HOME`.
- **Machine-local overrides are not committed.** Per-machine secrets/config are sourced from `~/.config/local/` and never live in the repo:
  - zsh: every `~/.config/local/zsh/*.zsh` is sourced last by `.zshrc`.
  - git: `~/.config/local/git/config` is `[include]`d at the end of `git/.config/git/config`.
  Put anything host-specific there rather than hardcoding it into a tracked file.

## Zsh configuration structure

`zsh/.zshrc` is the orchestrator and sources, in order:
1. `rc.zsh` (XDG vars, completion, history, shell options), `variables.zsh` (env/PATH), `aliases.zsh`, `functions.zsh`
2. **All** of `~/.config/zsh/tools/*.zsh` in filename order
3. Machine-local `~/.config/local/zsh/*.zsh`
4. `keybinds.zsh`

Tool fragments use a **numeric prefix to control load order** (`00-` first, `21-` last) — e.g. `00-homebrew.zsh` must set up Homebrew before later fragments that depend on PATH. Each fragment guards on the tool's presence (`if command -v <tool>`), so the same config works on machines missing a given tool. When adding a tool, create a new `NN-<tool>.zsh` and pick the prefix by dependency order.

## Git

`git/.config/git/config` defines workflow aliases worth knowing before scripting around git here:
- `git new <branch>` / `git up` / `git current` resolve the default branch from `origin/HEAD` dynamically (not hardcoded `main`/`master`).
- `git save` / `wip` / `wipe` are checkpoint commits; `save` uses `--no-verify`.
- `git wt` is **git-wt** (`k1low/tap/git-wt`), a worktree manager. Worktrees are created under `.worktrees/` (set via `[wt] basedir`). The zsh wrapper in `tools/20-git-wt.zsh` overrides the `git` function to `cd` into a new worktree after `git wt <branch>` (controlled by `wt.nocd` config). Do not edit worktree files from the parent checkout — operate inside each worktree directly (see `.worktrees/README.md`).
- difftastic integration: `git dl` / `ds` / `dd` use `difft` as the external diff.
