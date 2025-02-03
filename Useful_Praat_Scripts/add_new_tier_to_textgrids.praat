################################################################
############## README ###############
# Script modified using stackoverflow answer: 
# https://stackoverflow.com/questions/50890599/is-it-possible-to-add-tiers-automatically-in-praat
#
# This script adds a new tier at a user-defined position,
# to all textgrids saved in a user-defined directory
# This script takes as its input:
# 1) a source directory with textgrids that need to be modified
# 2) A tier name and tier position number for the new tiers (optional)
# 
# It will write the new textgrids to the destination foler and print the same to the info window
# to rewrite existing textgrids, provide the same input for source and destination.
# Script by Megh Krishnaswamy, Last edtited on December 4, 2023
################################################################

#Form for user input:
clearinfo
form Add tiers to all textgids in a folder
	sentence Source_directory_name: full_path_to_directory
	sentence Destination_directory_name: full_path_to_directory
	sentence Tier_name: enter_tier_name
	integer Tier_position_integer: 1
endform

# Directory and file information:
wd$ = source_directory_name$ + "/*.TextGrid"
printline directory and filetype 'wd$'
printline tier number for new tier 'tier_position_integer'

#get list of files:
downloadsList = Create Strings as file list: "downloadsList", wd$
selectObject: downloadsList
numFiles = Get number of strings
printline number of files: 'numFiles'

# loop over all textgrids and insert a tier
for fileNum from 1 to numFiles
    fileName$ = Get string: fileNum
	filePath$ = source_directory_name$ + "/" + fileName$
	printline 'filePath$'
    Read from file: filePath$
    Insert interval tier: tier_position_integer, tier_name$


	# Save file to disk:
	destination_path$ = destination_directory_name$ + "/" + fileName$
    Save as text file: destination_path$
    Remove
    selectObject: downloadsList
    printline Added textgrids to 'numFiles' files in the 'destination_path$' directory

endfor

#Cleanup
selectObject: downloadsList
Remove
