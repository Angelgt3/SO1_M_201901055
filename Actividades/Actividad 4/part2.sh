#!/bin/bash
while true; do
  if read -t 1 msg < /tmp/user1_to_user2; then
    echo "User1: $msg"
    read -p "User2: " response
    if [[ "$response" == "exit" ]]; then
      echo "Chat finalizado"
      break
    fi
    echo "$response" > /tmp/user2_to_user1
  fi
done
