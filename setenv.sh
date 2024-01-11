#!/bin/bash

ENV_FILE=.env.ids
touch $ENV_FILE

case "$(uname -sr)" in

   Darwin*)
     echo 'Setting environment for Mac OS X'
     echo "USER_NAME=$USER" > $ENV_FILE
     echo "GRP_ID=$(id -g)" >> $ENV_FILE
     echo "USER_ID=$(id -u)" >> $ENV_FILE
     ;;

   Linux*Microsoft*)
     echo 'Setting environment for WSL (NOT IMPLEMENTED)'  # Windows Subsystem for Linux
     exit 1
     ;;

   Linux*)
     echo 'Setting environment for Linux'
     echo "USER_NAME=$USER" > $ENV_FILE
     echo "GRP_ID=$(id -g)" >> $ENV_FILE
     echo "USER_ID=$(id -u)" >> $ENV_FILE
     ;;

   CYGWIN*|MINGW*|MINGW32*|MSYS*)
     echo 'Setting environment for MS Windows'
     ;;

   # Add here more strings to compare
   # See correspondence table at the bottom of this answer

   *)
     echo 'ERROR: UNSUPPORTED OS'
     exit 1
     ;;
esac

