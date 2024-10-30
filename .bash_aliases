nvim () {
  regex='^'"${HOME}"'/workspace/zenpayroll(/.*)?$'
  if [[ "$(pwd)" =~ $regex ]]; then
    export XDG_DATA_HOME="${HOME}/workspace/zenpayroll/.local/share/vim"
  fi
  $(which nvim) $@
}
