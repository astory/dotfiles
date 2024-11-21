alias ed="ed -p\*"
alias cdg='cd $(pwd | sed '\''s,/workspace/zenpayroll/.*$,/workspace/zenpayroll,'\'')'

# This might be unnecessary now that we've updated system ruby
#nvim () {
#  regex='^'"${HOME}"'/workspace/zenpayroll(/.*)?$'
#  if [[ "$(pwd)" =~ $regex ]]; then
#    export XDG_DATA_HOME="${HOME}/workspace/zenpayroll/.local/share/vim"
#  fi
#  $(which nvim) $@
#}

n_times () {
  log=$(mktemp)
  parallel -n 0 --joblog="$log" --keep-order --files \
    "${@:2}" \
    ::: $(seq $1)

  cat "$log"
  echo "Code Count"
  awk 'NR>1{arr[$7]++}END{for (a in arr) print a, arr[a]}' "$log"
}
