#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

#if no argument provided
if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
  exit
fi 
#if not number
if [[ ! $1 =~ ^[0-9]+|[0-9]+$ ]]
then
  #if length < 3
  if [[ $(echo -n $1 | wc -m) < 3 ]]
  then 
    #get info via symbol
    ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, types.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius 
                            FROM elements AS e INNER JOIN properties AS p USING(atomic_number) INNER JOIN types USING(type_id)
                            WHERE symbol='$1'")
  else
    #get info via name
    ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, types.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius 
                            FROM elements AS e INNER JOIN properties AS p USING(atomic_number) INNER JOIN types USING(type_id)
                            WHERE name='$1'")
  fi
else
  #get infos via atomic_number
  ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, types.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius 
                            FROM elements AS e INNER JOIN properties AS p USING(atomic_number) INNER JOIN types USING(type_id)
                            WHERE atomic_number=$1")
fi  

#if found result = null
if [[ -z $ELEMENT_INFO ]]
then
  echo -e "I could not find that element in the database."
  exit
fi
#else
#output message 
echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING BAR BOILING
do 
  echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
done 

# The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
# The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
