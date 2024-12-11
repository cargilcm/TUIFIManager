# .bashrc an alias and function to parse the cd_on_exit directory from TUIFIManager
# usage: in shell (-session) source this file if not loaded by the bash environment then execute 'tuify', can access last set dir later (as $CD_dir)
alias tuify='function _tui(){
   og_dir=$(pwd)
   exec 5>&1;
   # tee fd#5 just works for stdin/stdout and command substitution as value assigned to variable tt i think is how this line of code is described
   tt=$(tuifi | tee /dev/fd/5);
   export CD_dir="$(pytuifn)";
   # if tuifi programs output contains the sequence //\nCD then cntl+E was executed and should cd to the dir that follows
   if [[ "$(tcd)" == "CD" ]]; then
      cd "$CD_dir";
   fi
   };_tui;'

function pytuifn(){
  (python -c 'import sys;t=sys.argv[1];exec("try: backsl_first=t.index(\"//\"); backsl_second=t.index(\"//\",backsl_first+2,len(t)); print(t[backsl_first+6:backsl_second]);\nexcept: \"\"\"\"\"\";");' "$tt";);
}
function tcd(){
  # if below is true tuify() indicates a cd is needed. regex is much easier if only possible in a proper bash function hence tcd vs included in tuify alias
   if [[ "$tt" =~ "//"$'\n'"CD" ]];
      then echo "CD";
   fi
}

