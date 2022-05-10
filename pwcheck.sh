#!/bin/bash

#DO NOT REMOVE THE FOLLOWING TWO LINES
git add $0 >> .local.git.out
git commit -a -m "Lab 2 commit" >> .local.git.out
git push >> .local.git.out || echo


#Your code here
FILENAME=$1
COUNT=0
PASSWORD=$(<$FILENAME)
LENGTH=${#PASSWORD}

#Check if password is valid length
if [ $LENGTH -lt 6 ]; then
  echo "Error: Password length invalid."
  exit 1;
fi

if [ $LENGTH -gt 32 ]; then
  echo "Error: Password length invalid."
  exit 1;
fi

#Add 1 point for every character
for (( i=1; i<=$LENGTH; i++ ))
do
  let COUNT=COUNT+1
done

#Add 5 points if password contains a digit
if [[ $PASSWORD =~ [0-9] ]]; then
  let COUNT=COUNT+5
fi

#Add 5 points if password contains a special character
if [[ $PASSWORD =~ ["#$+%@"] ]]; then
  let COUNT=COUNT+5
fi

#Add 5 points if password contains a letter
if [[ $PASSWORD =~ [a-zA-Z] ]]; then
  let COUNT=COUNT+5
fi

#Subtract 10 from count if there is a character repeaded consecutively
if egrep -q "([a-zA-Z0-9])(\1)+" $FILENAME; then
  let COUNT=COUNT-10
fi

#Subtract 3 if there are 3 consecutive lower case letters
if [[ $PASSWORD =~ [a-z]{3} ]]; then
  let COUNT=COUNT-3
fi

#Subtract 3 if there are 3 consecutive upper case letters
if [[ $PASSWORD =~ [A-Z]{3} ]]; then
  let COUNT=COUNT-3
fi

#Subtract 3 if there are 3 consecutive digitse letters
if [[ $PASSWORD =~ [0-9]{3} ]]; then
  let COUNT=COUNT-3
fi

echo "Password Score: $COUNT"
