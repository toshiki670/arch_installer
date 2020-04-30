#!/bin/bash


echo "Enable wheel group as sudoer."
echo "Uncomment the below:"
echo "# %wheel ALL=(ALL) ALL"
echo
read -p "Press enter to continue"

visudo
exit $?
