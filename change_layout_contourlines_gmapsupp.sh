#!/bin/bash
# set -x #echo on

#=====================================================================
#
# Replace .TYP-files in gmapsupp.img image file with GMapTool,
# gmaptool (gmt) is published by www.gmaptool.eu. 
# Only for Contourlines gmapsupp.img maps by OpenMTBMap.org or MTBMap.com or VeloMap.org or OutdoorMaps.com


# First Check if we are Using OSx or Linux
if [[ "$OSTYPE" == "linux-gnu" ]] 2>/dev/null; then 
    gmt=gmt_linux
elif [[ "$OSTYPE" == "darwin"* ]] 2>/dev/null; then
    gmt=./resources/gmt_osx
elif [[ "$OSTYPE" == "cygwin" ]] 2>/dev/null; then
    echo "Please use the .cmd script for Windows isntead"
	echo "well if you know why, then hack this script"
	echo "Aborting"
	exit
elif [[ "$OSTYPE" == "msys" ]] 2>/dev/null; then
    echo "Please use the .cmd script for Windows isntead"
	echo "well if you know why, then hack this script"
	echo "Aborting"
	exit
elif [[ "$OSTYPE" == "win32" ]] 2>/dev/null; then
    echo "Please use the .cmd script for Windows isntead"
	echo "well if you know why, then hack this script"
	echo "Aborting"
	exit
elif [[ "$OSTYPE" == "freebsd"* ]] 2>/dev/null; then
	echo "gmt is not tested on freebsd - I hope it works"
	gmt=./resources/gmt_linux
elif [ "`uname`" = "Darwin" ] 2>/dev/null; then
    gmt=./resources/gmt_osx
elif [ "`uname`" = "Linux" ] 2>/dev/null; then
    gmt=/maps/gmt_linux
else
    echo "Cannot determine the operating system. Please edit the .sh file to select"
	echo "the correct version of gmt (gmaptool). I do not know if gmt runs on other systems"
	echo "than OSx and Linux"
	echo "This script is made for bash, but can run also on sh (Bourne Shell)"
	echo ""
	echo "Aborting"
	exit
fi
	


# Check if we can find contours_*part1.img & contours*_part2.img - in this case do not respect commandline input!
if [ -n "$2" ]; then
	imgfile=$1
	imgfile2=$2
		# Check if $imgfile and $imgfile2 are actually existing files
		if [ -f $imgfile ] && [ -f $imgfile2 ]; then
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
			echo Going to change .TYP-file for:
			echo $imgfile 
			echo $imgfile2
			echo ""
		else
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
				if [ -f $imgfile ]; then
					echo ""
					else
					echo $imgfile 
					echo does not exist or is no file.
					echo ""
				fi
				if [ -f $imgfile2 ]; then
					echo ""
					else
					echo $imgfile2
					echo does not exist or is no file.
					echo ""
				fi
			echo "Aborting."
			echo ""
			exit
		fi
		
elif [ -n "$3" ]; then
	imgfile=$1
	imgfile2=$2
	imgfile3=$3
		# Check if $imgfile and $imgfile2 are actually existing files
		if [ -f $imgfile ] && [ -f $imgfile2 ] && [ -f $imgfile3 ]; then
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
			echo Going to change .TYP-file for:
			echo $imgfile 
			echo $imgfile2
			echo $imgfile3
			echo ""
		else
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
				if [ -f $imgfile ]; then
					echo ""
					else
					echo $imgfile 
					echo does not exist or is no file.
					echo ""
				fi
				if [ -f $imgfile2 ]; then
					echo ""
					else
					echo $imgfile2
					echo does not exist or is no file.
					echo ""
				fi
				if [ -f $imgfile3 ]; then
					echo ""
					else
					echo $imgfile3
					echo does not exist or is no file.
					echo ""
				fi
			echo "Aborting."
			echo ""
			exit
		fi

elif [ -n "$4" ]; then
	imgfile=$1
	imgfile2=$2
	imgfile3=$3
	imgfile3=$4
		# Check if $imgfile and $imgfile2 are actually existing files
		if [ -f $imgfile ] && [ -f $imgfile2 ] && [ -f $imgfile3 ] && [ -f $imgfile4 ]; then
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
			echo Going to change .TYP-file for:
			echo $imgfile 
			echo $imgfile2
			echo $imgfile3
			echo $imgfile4
			echo ""
		else
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
				if [ -f $imgfile ]; then
					echo ""
					else
					echo $imgfile 
					echo does not exist or is no file.
					echo ""
				fi
				if [ -f $imgfile2 ]; then
					echo ""
					else
					echo $imgfile2
					echo does not exist or is no file.
					echo ""
				fi
				if [ -f $imgfile3 ]; then
					echo ""
					else
					echo $imgfile3
					echo does not exist or is no file.
					echo ""
				fi
				if [ -f $imgfile4 ]; then
					echo ""
					else
					echo $imgfile4
					echo does not exist or is no file.
					echo ""
				fi
			echo "Aborting."
			echo ""
			exit
		fi		
			
elif [ -n "$1" ]; then
	imgfile=$1	
		# Check if $imgfile is an actually existing file
		if [ -f $imgfile ]; then
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
			echo "Going to change .TYP-file for:"
			echo $imgfile
		else
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
			echo $imgfile 
			echo does not exist or is no file.
			echo "Aborting."
			echo ""
			exit
		fi
else	
		if [ -f contours_*part1.img ] && [ -f contours_*part2.img ] && [ -f contours_*part3.img ] && [ -f contours_*part4.img ]; then
			imgfile=contours_*part1.img
			imgfile2=contours_*part2.img
			imgfile3=contours_*part3.img
			imgfile4=contours_*part4.img
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
			echo Going to change .TYP-file for:
			echo $imgfile  
			echo $imgfile2
			echo $imgfile3	
			echo $imgfile4			
			echo ""
		elif [ -f contours_*part1.img ] && [ -f contours_*part2.img ] && [ -f contours_*part3.img ]; then
			imgfile=contours_*part1.img
			imgfile2=contours_*part2.img
			imgfile3=contours_*part3.img
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
			echo Going to change .TYP-file for:
			echo $imgfile  
			echo $imgfile2
			echo $imgfile3			
			echo ""
		elif [ -f contours_*part1.img ] && [ -f contours_*part2.img ]; then
			imgfile=contours_*part1.img
			imgfile2=contours_*part2.img
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
			echo Going to change .TYP-file for:
			echo $imgfile  
			echo $imgfile2 
			echo ""
		elif ls ./contours_*gmapsupp.img 1> /dev/null 2>&1; then
			imgfile=./contours_*gmapsupp.img
			echo ""
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files of a single country"
			echo ""
			echo Going to change .TYP-file for:
			echo $imgfile 
		elif ls ./contours_*20m.img 1> /dev/null 2>&1; then
			imgfile=./contours_*20m.img
			echo ""
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files of a single country"
			echo ""
			echo Going to change .TYP-file for:
			echo $imgfile 
		elif ls ./contours_*.img 1> /dev/null 2>&1; then
			imgfile=./contours_*.img
			echo ""
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files of a single country"
			echo ""
			echo Going to change .TYP-file for:
			echo $imgfile 
		else
			echo "please use this script only for openmtbmap/velomap contourlines gmapsupp.img files"
			echo ""
			echo "Please pass the imgfile you wish to change as argument:"
			echo "or make sure the imgfile is named "contours_COUNTRY.img" or "contours_*20m.img""
			echo "for single part contourlines gmapsupp"
			echo "or contours_*part1.img & contours*_part2.img for multi part contourlines gmapsupp like"
			echo "China, Russia, South-America and Africa"
			echo ""
			echo "example for country Austria"
			echo "  $bash change_layout_contourlines_gmapsupp.sh contours_AUSTRIA.img"
			echo ""
			echo "example for country China"
			echo "  $bash change_layout_contourlines_gmapsupp.sh contours_CHINA_part1.img contoures_CHINA_part2.img"
			echo ""
			exit
		fi
fi	

# Now the following is extremely dirty without goto. If someone can have a look at the windows .cmd batch script and help me to get the bash script to the same quality I would be very happy (Felix 12.03.2019)
# If $typfile is still '' here, we need to aks the user
	echo ""
	echo "Select from the following options:"
	typ1="Thin     - Contourlines are Thin (1pixel)"
	typ2="Medium   - Major Contourlines 500m are a bit wider (2pixel)"
	typ3="Thick    - All contourlines are 2pixel wide"
	typ4="Extra Thick - All contourlines are 3pixel wide"
	typ5="Default  - Your GPS device decides how to display the contourlines."


	echo " 1: $typ1"
	echo " 2: $typ2"
	echo " 3: $typ3"
	echo " 4: $typ4"
	echo " 5: $typ5"
	echo ""
	echo "  Q: Press Q or any other key to Quit/Exit"
	echo ""
	echo ""
	
	echo "Enter your choice (1-4, Q): "
          # Do we run bash ?
          if [ -n "$BASH" ]; then
                    read -n 1 key
          else
                    read key
          fi

	echo ""

	typfile=''
	echo ""
	echo ""
	case "$key" in

		1)
			echo You selected:
			echo $typ1
			typfile=/maps/thin*.TYP
		;;

		2)
			echo You selected:
			echo $typ2
			typfile=/maps/mid*.TYP
		;;

		3)
			echo You selected:
			echo $typ3
			typfile=/maps/bold*.TYP
		;;

		4)
			echo You selected:
			echo $typ4
			typfile=/maps/xbol*.TYP
		;;
		
		5)
			echo You selected:
			echo $typ5
			typfile=/maps/def*.TYP
		;;

		q|Q)
			echo Aborting by user request.
			exit
		;;
		
		x|X)
			echo Aborting by user request.
			exit
		;;
		*)
			echo Unknown input command. Exiting...
			exit
		;;
	esac


echo "------------------------------------------------------------"
echo ""


# Use gmt to fist find FID and change FID in .typfile (only needed with drop/drag)
# then replace the typ inside the contours_*.img
FID=`$gmt -i $imgfile | grep ", FID " | cut -d',' -f 2 | sed -e 's/ FID //'`
$gmt -w -y $FID $typfile >/dev/null
$gmt -w -x $typfile $imgfile $imgfile2 $imgfile3 $imgfile4>/dev/null
echo Success - Replaced .TYP file in:
echo $imgfile 
echo $imgfile2
echo $imgfile3
echo $imgfile4
echo ""







