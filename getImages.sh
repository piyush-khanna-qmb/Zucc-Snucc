#!/bin/bash

# Specify the URL of the webpage
url="https://www.kiet.edu/home/department_wise_faculty_list/MQ=="

# Create a directory to store the images
outputFolder="D:/Sean/Vision/Face Database/ECE"
mkdir -p "$outputFolder"

# Download the webpage content
webpageContent=$(curl -s "$url")

# Find all image tags in the HTML
imageTags=$(echo "$webpageContent" | grep -o '<img [^>]*src="[^"]*' | sed -e 's/<img [^>]*src="//g')

# Total number of images
totalImages=$(echo "$imageTags" | wc -l)
currentImage=0

echo -e "\033[1;32m Author: Victor Baron\033[1;32m"
echo -e "\033[1;32m Time: 26th August, 2022 08:11 PM"
echo -e "\033[1;32m Purpose: Bulk database download of KIET faculties for Robot Training \033[0m"
echo -e "\033[1;32m \t\t(Can also be used to download photos of sukanyaas 👀) \033[0m"
echo -e "\033[1;91m \n\n\n\n\n\n\n\n\n\n\n\t\t\t\t\t       Initiating File Retrieval...\033[0m"
sleep 6
clear

# Download images and maintain their original names
for imageUrl in $imageTags; do
    currentImage=$((currentImage + 1))
    imageName=$(basename "$imageUrl")
    imagePath="$outputFolder/$imageName"
    
    echo -e "\033[1;93mDownloading image [$currentImage/$totalImages]: $imageName...\033[0m"
    
    # Simulate loading bar
    loading_bar="[--------------------]"
    for ((i=0; i<20; i++)); do
        loading_bar=${loading_bar/[-]/@}
        echo -ne "\r$loading_bar [$((i*5))%]"
        sleep 0.02  # Adjust sleep duration for animation speed
    done
    
    # Download image
    curl -s -o "$imagePath" "$imageUrl"
    
    # Complete the loading bar
    echo -ne "\r[####################] [100%]"
    
    echo -e "\n\033[1;92mDownloaded: $imageName\033[0m"
    
    # Add a line break
    echo
done

echo -e "\033[1;32m All images have been downloaded successfully! \033[1;32m"

sleep 5
