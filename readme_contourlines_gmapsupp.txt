About the Openmtbmap.org & www.Velomap.org Maps Contourlines Gmapsupp 10m Download - Please Read - Short Installation Help 
- See my Homepage for detailed instructions


-----------------------------------------------------------------------------------------
------------------Transparent Contourlines Gmasuppp.img Files-----------------------------------
-----------------------------------------------------------------------------------------

To Install just place them into the /garmin folder on the mSD of your Garmin device
Then activate it in the setup map menu of your device.

The gmapsupp.img contourlines .img files do not use a .typfile by default - 
so the layout of the contourlines will be determined by your device itself.



------------------------------------------------------------------------------------------
------------------Layout Customization ------------------------------------------------------------------
------------------------------------------------------------------------------------------

If you want to have thinner or thicker contourlines - you can apply a .TYP file

---------------------------------
for Windows - simply drag the contourlines_gmapsupp.img over the change_layout_contourlines_gmapsupp.cmd
You can also just doubleclick the change_layout_contourlines_gmapsupp.cmd if you did not move the .img file yet
It's even possible to drag/drop the contourlines_gmapsupp from your mSD right 
onto the change_layout_contourlines_gmapsupp.cmd without moving if back to your PC first.

---------------------------------
For Linux and OSx (only up to OSx 10.14 Mojave, from Catalina 10.15 due to no 32 bit support not possible )
Open terminal, enter bash and drop first change_layout_contourlines_gmapsupp.sh then drop the contourlines_country_gmapsupp.img
to start changing the layout. You can also just cd to the current folder - then enter e.g.:
bash change_layout_contourlines_gmapsupp.sh contours_AUSTRIA_gmapsupp.img

Alternatively - right click the change_layout_contourlines_gmapsupp.sh - and give it execute rights (744 permission)
OR in terminal run: 
chmod +x bash change_layout_contourlines_gmapsupp.sh
then you can also run it by doubleclick.


