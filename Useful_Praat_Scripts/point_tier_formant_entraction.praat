#################################################################################
#
# This script extracts F1 and F2 from the phoneme point tier 
# of a selected Sound file.
# It assumes phonemes are on Tier 2 and words are on Tier 1.
#
# To run this script, open a Sound and TextGrid in Praat and have them selected.
#
# This script:
# 1) Extracts labels, timestamps and identifyers from a point tier
# 2) Extract F1 and F2 in the points
# 3) Save data to a csv file 
# Script by Megh Krishnaswamy, Last edtited on December 4, 2023
#################################################################################

# form for user input:
clearinfo
form Extract formants and word labels
	integer point_tier: 3
	sentence destination_file_name: full_path_to_csv_file_location
endform

writeInfoLine: "Extracting formants..."

# Extract the names of the Praat objects:
thisSound$ = selected$("Sound")
thisTextGrid$ = selected$("TextGrid")


# Create Formant object using sound file:
select Sound 'thisSound$'
To Formant (burg)... 0.01 5 5500 0.025 50

# Append a header row:
header_row$ = "filename"+ "," + "label" + "," + "f1" + "," + "f2" + newline$
fileappend "'destination_file_name$'" 'header_row$'


# Extract the number of points in the phoneme tier
select TextGrid 'thisTextGrid$'
numberOfPhonemes = Get number of points: point_tier
printline number of phonemes is 'numberOfPhonemes'


# Loop over each point in the point tier to get the label and timestamp:
	for point from 1 to numberOfPhonemes
		select TextGrid 'thisTextGrid$'
		fileName$ = thisTextGrid$
		plabel$ = Get label of point... 'point_tier' 'point'
		ptime = Get time of point... 'point_tier' 'point'
	
		# extract f1 and f2
    	select Formant 'thisSound$'
    	f1 = Get value at time... 1 ptime Hertz Linear
    	f2 = Get value at time... 2 ptime Hertz Linear
		f1$ = string$: f1
		f2$ = string$: f2
	
		# print it out and save to file
		result_row$ = fileName$ + "," 
						... + plabel$ + ","
						... + f1$ + ","
						... + f2$ + newline$			
		printline 'result_row$'
		fileappend "'destination_file_name$'" 'result_row$'

		endfor
# Cleanup
	select Formant 'thisSound$'
	Remove

