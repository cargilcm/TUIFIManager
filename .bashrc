# .bashrc an alias and function to parse the cd_on_exit directory from TUIFIManager
# usage: in shell (-session) source this file if not loaded by the bash environment then execute 'tuify', can access last set dir later (as $CD_dir)
alias tuify='function _tui(){
   og_dir=$(pwd)
   exec 5>&1;
   # tee fd#5 just works for stdin/stdout and command substitution as value assigned to variable tt i think is how this line of code is described
   tt=$(tuifi | tee /dev/fd/5);
   echo "$tt" > tuiout && export CD_dir="$(pytuifn)";
   rm tuiout;
   cd "$CD_dir";
   };_tui;'

function pytuifn(){
  (python -c 'with open("./tuiout", "r") as file: t=file.read();print(t[t.index("//")+6:len(t)])');
}
