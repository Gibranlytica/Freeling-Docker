#!/bin/bash
declare -a arr=("ca" "as" "cs" "pt" "nb"
                "gl" "hr" "sl" "ru" "fr"
                "de")
for i in "${arr[@]}"
do
  rm -rf "/root/usr/local/FreeLing-4.1/$i"
  rm -r "/root/usr/local/FreeLing-4.1/config/$i*"
done