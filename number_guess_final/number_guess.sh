#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t -c"
#generate random number between 1 and 1000
SECRET_NUMBER=$(( ($RANDOM % 1000) + 1))
GUESSES=1

#--handle user--
echo "Enter your username:"
read USERNAME_INPUT
#get user from db
USER=$($PSQL "SELECT name, games_played, best_game FROM data WHERE name='$USERNAME_INPUT';")
#if not found
if [[ -z $USER ]]
then
  #add user to db
  USER_ADDED_OUTPUT=$($PSQL "INSERT INTO data(name) VALUES('$USERNAME_INPUT');")
  echo "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
else
  #read data into variables
  echo "$USER" | while read USERNAME BAR GAMES_PLAYED BAR BEST_GAME;
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done  
fi

#--guessing game--
echo "Guess the secret number between 1 and 1000:"
read GUESS

while [[ $GUESS != $SECRET_NUMBER ]]
do  
  #if not number
  if [[ ! $GUESS =~ ^[0-9]+|[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"    
  else  
    if [[ $GUESS -gt $SECRET_NUMBER ]]
    then
      echo "It's lower than that, guess again:"
    elif [[ $GUESS -lt $SECRET_NUMBER ]]
    then
      echo "It's higher than that, guess again:"
    fi      
  fi
  read GUESS
  ((GUESSES++))
done

echo "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

#--update db--
#sed to remove spaces
BEST_GAME=$(echo "$($PSQL "SELECT best_game FROM data WHERE name='$USERNAME_INPUT'")" | sed 's/ //g')   
if [[ -z $BEST_GAME || $GUESSES -lt $BEST_GAME ]]
then
  UPDATE_OUTPUT=$($PSQL "UPDATE data SET games_played=games_played+1, best_game=$GUESSES WHERE name='$USERNAME_INPUT';")
else
  UPDATE_OUTPUT=$($PSQL "UPDATE data SET games_played=games_played+1 WHERE name='$USERNAME_INPUT';")
fi
