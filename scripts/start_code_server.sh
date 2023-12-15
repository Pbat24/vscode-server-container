#!/bin/bash

echo "DEBUG: ARGS=$@"

DISABLE_CONN_TOKEN=""

usage() { 
    echo "Usage: $0 [-d|-h]" 1>&2
    echo "options:" 1>&2
    echo "d     disables the connection token from the URL" 1>&2
    echo "h     prints this usage"  1>&2
    exit 1;
}

while getopts ":hd" opt; do
  case ${opt} in
    h )
        usage
        ;; 
    d )
        echo "Option -d triggerred"
        DISABLE_CONN_TOKEN="--without-connection-token"
        ;;
    : )
        echo "Option -$OPTARG requires an argument"
        exit 1
        ;;
    * )
        echo "Invalid Option: -$OPTARG"
        usage
        ;;
  esac
done

source /opt/vscode-server/.env
eval `ssh-agent`

HOST_IP=$(ifconfig eth0 | awk '/inet/{print $2}')
echo "'Working Directory $WORKING_DIR'"
code serve-web --port $VS_PORT --user-data-dir $WORKING_DIR --server-data-dir $WORKING_DIR --cli-data-dir $WORKING_DIR --host $HOST_IP $DISABLE_CONN_TOKEN
