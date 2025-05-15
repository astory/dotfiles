alias ed="ed -p\*"
alias cdg='cd $(to_workspace)'
alias pull_main="git checkout main && git fetch && git pull && bundle install && RAILS_ENV=development bin/rails db:migrate && yarn install"
alias recheck="git rebase -x \"git diff --name-only HEAD~1 --diff-filter=ACM | tr '\n' '\0' | lefthook run pre-commit --files-from-stdin -n\""

in_workspace() {
  if [[ -z $1 ]]; then
    local_path=$(pwd)
  else
    local_path=$1
  fi
  if [[ $local_path == */workspace/* ]]; then
    return 0
  else
    return 1
  fi
}

to_workspace() {
  if [[ -z $1 ]]; then
    local_path=$(pwd)
  else
    local_path=$1
  fi
  echo $local_path | sed -E 's,/workspace/([^/]+)/.*$,/workspace/\1,'
}

changed_files() {
  if [ -z $@ ]; then
    diffbase="HEAD~1"
  else
    diffbase=$@
  fi
  (cdg && git diff --name-only $diffbase --diff-filter=ACM | tr '\n' ' ' | xargs realpath)
}

wwid() {
  nvim -p $(changed_files $@)
}

rebase_command () {
  command="$1 $(changed_files)"
  git rebase -x "${command}" "${@:2}"
}

n_times () {
  log=$(mktemp)
  # Only one job at a time because parallel tests are broke.  Thanks, Ruby!
  parallel --jobs 1 --max-args 0 --joblog="$log" --keep-order --files \
    "${@:2} 2>&1" \
    ::: $(seq $1) 
  cat "$log"
  echo "Code Count"
  awk 'NR>1{arr[$7]++}END{for (a in arr) print a, arr[a]}' "$log"
}

find_test () {
  if ! in_workspace; then
    echo "Cannot find tests outside of a workspace."
    return 1
  fi
  if [[ -z $1 ]]; then
    echo "No input given."
    return 1
  fi
  input_filename=$(basename $1)
  if [[ $input_filename == *_spec.rb ]]; then
    target=$(echo $input_filename | sed 's/_spec\.rb$/.rb/')
  else
    target=$(echo $input_filename | sed 's/\.rb$/_spec\.rb/')
  fi
  ( # Subshell to keep directory changes contained
    cd $(dirname $(realpath $1))
    while [ true ]; do
      dir=$(pwd)
      # Erase to start of line
      printf "\33[2K\r"
      printf '%s' "Looking for $target in $dir..." >&2
      results=$(cdg && find $dir -name $target)
      if [[ -z $results ]]; then
        if ! in_workspace $(dirname $dir); then
          printf "\33[2K\r"
          echo "Could not find file named $target." >&2
          return 1
        fi
        cd ..
      else
        # Erase to start of line to clean up
        printf "\33[2K\r"
        echo $results
        return 0
      fi
    done
  )
}
