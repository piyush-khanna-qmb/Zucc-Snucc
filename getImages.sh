#!/bin/bash

url="https://www.kiet.edu/home/department_wise_faculty_list/MQ=="

outputFolder="D:/Sean/Vision/Face Database/ECE"
mkdir -p "$outputFolder"

webpageContent=$(curl -s "$url")

imageTags=$(echo "$webpageContent" | grep -o '<img [^>]*src="[^"]*' | sed -e 's/<img [^>]*src="//g')

totalImages=$(echo "$imageTags" | wc -l)
currentImage=0

echo -e "\033[1;32m Author: Victor Baron\033[1;32m"
echo -e "\033[1;32m Time: 26th August, 2022 08:11 PM"
echo -e "\033[1;32m Purpose: Bulk database download of KIET faculties for Robot Training \033[0m"
echo -e "\033[1;32m \t\t(Can also be used to download photos of sukanyaas 👀) \033[0m"
echo -e "\033[1;91m \n\n\n\n\n\n\n\n\n\n\n\t\t\t\t\t       Initiating File Retrieval...\033[0m"
sleep 6
clear

for imageUrl in $imageTags; do
    currentImage=$((currentImage + 1))
    imageName=$(basename "$imageUrl")
    imagePath="$outputFolder/$imageName"
    
    echo -e "\033[1;93mDownloading image [$currentImage/$totalImages]: $imageName...\033[0m"
    
    loading_bar="[--------------------]"
    for ((i=0; i<20; i++)); do
        loading_bar=${loading_bar/[-]/@}
        echo -ne "\r$loading_bar [$((i*5))%]"
        sleep 0.02  # Adjust sleep duration for animation speed
    done
    
    curl -s -o "$imagePath" "$imageUrl"
    
    echo -ne "\r[####################] [100%]"
    
    echo -e "\n\033[1;92mDownloaded: $imageName\033[0m"
    
    echo
done

echo -e "\033[1;32m All images have been downloaded successfully! \033[1;32m"

sleep 5
