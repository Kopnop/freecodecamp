#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]] 
  then
    echo -e "\n$1"
  else 
    echo -e "\nWelcome to My Salon, how can I help you?"  
  fi 
  #display options
  ALL_SERVICES=$($PSQL "SELECT * FROM services")
  echo "$ALL_SERVICES" | while read ID BAR NAME
  do
   echo "$ID) $NAME"
  done
  read SERVICE_ID_SELECTED
  #if not number
  if [[ ! $SERVICE_ID_SELECTED =~ (^[0-9]+|[0-9]+$) ]]
  then 
    #return to menu
    MAIN_MENU "I could not find that service. What would you like today?"
  else 
    #else if not in db
    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    if [[ -z $SERVICE_ID ]]
    then
      #return to menu
      MAIN_MENU "I could not find that service. What would you like today?"
      # echo "cant find"
    else 
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE
      #get customer_id
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      #if not in db
      if [[ -z $CUSTOMER_ID ]] 
      then
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        #insert new customer
        INSERT_CUSTOMER_RETURN=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
        #get customer_id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      fi  
      echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
      read SERVICE_TIME
      #insert into appointments
      INSERT_SERVICE_RETURN=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) 
                                        VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
      #goodbye message
      #get service name
      SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
      echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi 
  fi  
}

MAIN_MENU 