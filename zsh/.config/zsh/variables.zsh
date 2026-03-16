# editor
export EDITOR=vi
export SUDO_EDITOR=vi

# for docker-compose
export UID

# for tar on MacOS
export COPYFILE_DISABLE=1

# for less
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"

# path
export PATH="${HOME}/.local/bin:${PATH}"

# go
export GOPATH="${HOME}/.local/share/go"
export GOBIN="${HOME}/.local/bin"

# tmux-fzf
export FZF_TMUX="1"
export FZF_TMUX_OPTS="-p 80%"
