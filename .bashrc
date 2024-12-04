# .bashrc an alias and function to parse the cd_on_exit directory from TUIFIManager
# usage: in shell (-session) source this file if not loaded by the bash environment then execute 'tuify'
alias tuify2='function _tui(){
   og_dir=$(pwd)
   exec 5>&1;
   tt=$(tuifi | tee /dev/fd/5);
   echo "$tt" > tuiout && $(pytuifn);
   rm tuiout;
   cd "$(cat tu*2 |head -c -2)";
   rm "$og_dir"/tuiout2
   };_tui;'
#export tuiout=$(echo $tt|sed "s/\" \"/\"\\n\"/g")
function pytuifn(){
  (python -c 'with open("./tuiout", "r") as file: t=file.read();print(t[t.index("//")+6:len(t)])') > tuiout2;
}
