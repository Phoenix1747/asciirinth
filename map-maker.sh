#!/bin/bash
clear
echo -e "\n${COLOR_menuHeader} ASCIIrinth Map Maker${COLOR_reset}\n"
echo " In order for this to work you need to make a txt file and 'draw' your map with ASCII characters in any external editor."
echo " This will convert it to a compatible .map file for the game. Your map will be shown exactly like you specified it to look like."
echo -e  "\n Requirements:"
echo "  *) One unique character posing as the player."
echo "  *) One unique character for the goal."
echo "  *) Mark accessible places with a SPACEs."
echo -e "  *) At the end of the file should be a blank line otherwise it will not load correctly.\n\n"
trap "tput civis -- invisible; return" SIGINT
tput cnorm -- normal
read -p " Specify your txt file [(PATH/)FILE.txt]: " original
read -p " What name should the map have [NAME]: " mapname
tput civis -- invisible
clear

mapname="maps/$mapname.map"

# Really crude code, but hey... if it works.
i=0
while IFS= read -r "line"
do

  echo "$line"
  while IFS= read -r -n1 "char"
  do

    tmp+="$char,"

  done <<< "$line"

  declare line$i="$tmp"
  tmp=""
  ((i++))

done < "$original"

j=0
while [ "$j" -le "$i" ]
do

  lines="line$j"
  if [ $j = 0 ]
  then
    echo "${!lines}" > "$mapname"
  else
    echo "${!lines}" >> "$mapname"
  fi
  ((j++))

done

echo -e "\n\033[0;32m Your map has been successfully exported to '$mapname'.\033[0m\n"
read -s -n1 -p " Press any key to continue..."
