#!/bin/bash

#This script helps u to put a logo on pictures using imagemagick.

#Checks that imagemagick is installed.
if [[ $(composite --version) == "" ]] 
then
	echo "You don't have imagemagick installed, please install it before trying to run this script."
fi

#Logo path
if [[ "$1" == "" ]]
then
    echo "Enter the path of the logo as written(Ex: /home/user/Desktop/Logo.png)"
    read -re flogoname;
else
    flogoname="$1";
fi 

#Photos path
if [[ "$2" == "" ]]
then
    echo "Enter the path of the folder containing the photos:"
    read -re pos;
else
    pos="$2";
fi

#Logo position
if [[ "$3" == "" ]]
then
    echo "Choose logo position (1,2,3,4):"
    echo "1-Top Right"
    echo "2-Top Left"
    echo "3-Bottom Right"
    echo "4-Bottom Left"
    read -re input2;
else
    input2="$3";
fi

#Logo size
if [[ "$4" == "" ]]
then
    echo "Choose logo size (%):"
    read -re size;
else
    size=$4;
fi

#Output is where the results is going to be generated
if [ ! -d "Output" ]
then
    mkdir Output
fi

#An array containing the options for imagemagick to be able to pass them.
e=(NorthEast NorthWest SouthEast SouthWest);



for h in  "$pos"*.*
	do
		if [[ ! -d "$h" ]]
		then
			#differentiate between portrait and landscape photos taken by digital cameras with EXIF in it
			convert "$h" -auto-orient "$h" 
		
			#getting the each photo's width
			pwidth=$(convert "$h" -print "%w %h\\n" /dev/null);
			pwidth=$(echo "$pwidth" | cut -d ' ' -s -f2);
		
			#getting the file extinsion
			ext='.';
			ext+="echo $flogoname | rev | cut -d '.' -s -f1 |rev";
		
			#the new resulting photo's postion
			slogoname="Output/$(basename "$flogoname" "$ext").png"
	
			#make the logo's width and height a precentage of the photo's width 
			z=$((pwidth*size/100));
			float=$z;
			float+="x";
			float+=$z;
		
			#resizing the logo to fit the photo
			convert -background none "$flogoname" -resize "$float" "$slogoname" ;
			
			i=$(echo "$h" |rev| cut -d / -s -f 1|rev);
			echo " Processing " "$i"
			#putting the logo on the photo
			composite -background none -gravity "${e[(($input2-1))]}" "$slogoname" "$h" ./Output/"$i" 
		fi
	done

echo "You are done, thank you!"
