# editor
export EDITOR=vi
export SUDO_EDITOR=vi

# for docker-compose
export UID

# Define default_java for cross-platform JAVA_HOME resolution
if [[ -z "${DEFAULT_JAVA}" ]]; then # Only set if not already defined
  if [[ "$(uname)" == "Darwin" ]]; then
    DEFAULT_JAVA=$(/usr/libexec/java_home)
  else
    DEFAULT_JAVA=$(dirname $(dirname $(readlink -f $(which java))))
  fi
fi

# for less
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
