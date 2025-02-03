#################################################################################
#
# This script extracts F1 and F2 from the phoneme point tier Sound file.
# It outputs this information to a user-specified location
#
# 1) extract the word in the intervals on tier 2
# 2) extract F1 and F2 in the points on tier 3
# 3) loop through all the files in a folder
# 4) have a csv file in which the columns are: name of the file, word, F1, F2# 
# To run this script:
#
# Fill the form with a source folder, destination csv filename, and the
# location fo your word and vowel tier
#
# Script by Megh Krishnaswamy, Last edtited on November 30, 2023
#################################################################################

## Form for getting information from user. 
#here, enter the source folder, destination file name, and locaiton of relevant tiers 

clearinfo
form Extract formants and word and phoneme labels
	sentence Source_directory_name: /Users/meghavarshinikrishnaswamy/Downloads/TestFolder/test2
	sentence Destination_csv_path: /Users/meghavarshinikrishnaswamy/Downloads/TestFolder/test2/data.csv
	integer word_tier: 2
	integer vowel_tier: 3
endform

Create Strings as file list... list 'source_directory_name$'/*.wav
numberOfFiles = Get number of strings

header_row$ = "filename"+ "," + "word" + "," + "f1" + "," + "f2" + newline$
fileappend "'destination_csv_path$'" 'header_row$'

# Loop over all file names, open them and select them
for ifile to numberOfFiles
	select Strings list
	fileName$ = Get string... ifile
	sound= Read from file... 'source_directory_name$'/'fileName$'
	fileName$ = selected$("Sound")
	thisSound$ = selected$("Sound")
	textgrid = Read from file... 'Source_directory_name$'/'fileName$'.TextGrid
	thisTextGrid$ = selected$("TextGrid")

	#Create a formant object the sound file	
	select Sound 'thisSound$'
	To Formant (burg)... 0.01 5 5500 0.025 50

	# Get number of labels in the point tier of the current textgrid
	select TextGrid 'thisTextGrid$'
	numberOfPhonemes = Get number of points: vowel_tier
	
	# Loop over each point in the vowel tier to get the label and timestamp:
	for point from 1 to numberOfPhonemes
		select TextGrid 'thisTextGrid$'
		plabel$ = Get label of point... 'vowel_tier' 'point'
		ptime = Get time of point... 'vowel_tier' 'point'

		# get word tier label
		word_interval = Get interval at time... word_tier ptime
    	word_label$ = Get label of interval... word_tier word_interval
	
		# extract f1 and f2
    	select Formant 'thisSound$'
    	f1 = Get value at time... 1 ptime Hertz Linear
    	f2 = Get value at time... 2 ptime Hertz Linear
		f1$ = string$: f1
		f2$ = string$: f2
	
		# print it out and save to file
		result_row$ =  fileName$ + "," 
						... + word_label$ + ","
						... + f1$ + ","
						... + f2$ + newline$		
		printline 'result_row$'
		fileappend "'destination_csv_path$'" 'result_row$'
		endfor

	# Declutter the object window:
	select Sound 'thisSound$'
	plus TextGrid 'thisTextGrid$'
	plus Formant 'thisSound$'
	Remove

	endfor