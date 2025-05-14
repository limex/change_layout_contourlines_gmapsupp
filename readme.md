This is an abopted sh file to work with docker in x86 mode to run it on silicon mac

First:
* Change to your own path of the change_layout_contourlines_gmapsupp folder 
* Add your desired contour image .img to the folder
* Change in belows commmand `contours_germany20m.img` to your desired contour image


`docker run -it --platform linux/amd64 -v /Users/guntherbosch/Sources/change_layout_contourlines_gmapsupp:/maps ubuntu:latest sh /maps/change_layout_contourlines_gmapsupp.sh /maps/contours_germany20m.img
`

Find more details in file `readme_contourlines_gmapsupp.txt`
and https://openmtbmap.org/download/gmapsupp/
