#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t -c"
#generate random number between 1 and 1000
SECRET_NUMBER=$(( ($RANDOM % 1000) + 1))
GUESSES=1

echo "Enter your username:"
read USERNAME_INPUT
#get user from db
USER=$($PSQL "SELECT name, games_played, best_game FROM data WHERE name='$USERNAME_INPUT';")
#if not found
if [[ -z $USER ]]
then
  #add user to db
  USER_ADDED_OUTPUT=$($PSQL "INSERT INTO data(name) VALUES('$USERNAME_INPUT');")
  # USERNAME=$USER
  echo "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
else
  #read data into variables
  echo "$USER" | while read USERNAME BAR GAMES_PLAYED BAR BEST_GAME;
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done  
fi

#echo WELCOME_TEXT

echo "Guess the secret number between 1 and 1000:"
read GUESS

#--guessing game--
#do while breaks when secret_number is guessed correctly
while [[ true ]]
do  
  #TODO: if not number -> continue
  if [[ ! $GUESS =~ ^[0-9]+|[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"    
  else  
    if [[ $GUESS > $SECRET_NUMBER ]]
    then
      echo "It's lower than that, guess again:"
    elif [[ $GUESS < $SECRET_NUMBER ]]
    then
      echo "It's higher than that, guess again:"
    else 
      #number correct
      break   
    fi      
  fi
  read GUESS
  ((GUESSES++))
done

echo "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

#--update db--
PSQL_NO_ALIGN="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
BEST_GAME=$($PSQL_NO_ALIGN "SELECT best_game FROM data WHERE name='$USERNAME_INPUT'")
#if null
if [[ -z $BEST_GAME ]]
then 
  # echo "null -> update"
  UPDATE_OUTPUT=$($PSQL "UPDATE data SET games_played=games_played+1, best_game=$GUESSES WHERE name='$USERNAME_INPUT';")
else
  #if GUESSES < best_game
  if [[ $GUESSES < $BEST_GAME ]]
  then
    #update amount_games_played and best_game
    # echo "$GUESSES < $BEST_GAME -> update"
    UPDATE_OUTPUT=$($PSQL "UPDATE data SET games_played=games_played+1, best_game=$GUESSES WHERE name='$USERNAME_INPUT';")
  else
    #update amount_games_played
    # echo "$GUESSES > $BEST_GAME -> no update"
    UPDATE_OUTPUT=$($PSQL "UPDATE data SET games_played=games_played+1 WHERE name='$USERNAME_INPUT';")
  fi
fi
  #UPDATE data SET games_played=games_played+1, best_game=MIN(best_game, $GUESSES) WHERE name='$USERNAME_INPUT';

