#!/bin/bash
mkfifo /tmp/user1_to_user2
mkfifo /tmp/user2_to_user1

echo "Chat iniciado"

while true; do
  read -p "User1: " msg
  if [[ "$msg" == "exit" ]]; then
    echo "Chat finalizado"
    break
  fi
  echo "$msg" > /tmp/user1_to_user2
  if read -t 1 response < /tmp/user2_to_user1; then
    echo "User2: $response"
  fi
done

rm /tmp/user1_to_user2
rm /tmp/user2_to_user1