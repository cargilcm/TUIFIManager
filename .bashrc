# .bashrc an alias and function to parse the cd_on_exit directory from TUIFIManager
# usage: in shell (-session) source this file if not loaded by the bash environment then execute 'tuify' && CD_dir=$(pytuifn) && cd $CD_dir
alias tuify='function _tui(){
   exec 5>&1;
   tt=$(tuifi | tee /dev/fd/5);
   echo "$tt" > tuiout && export pytui=$(pytuifn);
   rm tuiout;
   };_tui;'
function pytuifn(){
  (python -c 'with open("./tuiout", "r") as file: t=file.read();print(t[t.index("//")+2:len(t)])');
}

