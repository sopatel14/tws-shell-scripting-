#!/bin/bash



echo "===Deletion of user==="

read -p "Delete the user:" username

sudo userdel "$username"

echo "$username username is deleted"

echo "===Deletion of user is done"

cat /etc/passwd | grep  "$username" | wc 

echo "as wc is 0 the user is deleted"







