# editor
export EDITOR=hx
export SUDO_EDITOR=hx

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
