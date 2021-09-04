#!/usr/bin/env bash
#This bash script searches for orphaned files in the Obsidian attachment folder
#tested on Ubuntu 20
#Sergei Korneev 2021



echo >./tmpfile
mkdir -p './Orphaned' 
attachfolder='_resources'
vault='MYVAULT'

#Merging all notes into one text

find  "./$vault" -type f -iname \*.md -o -iname \*.htm?   | while read F; \
	do echo Adding "${F##*/}"; \
		cat   "$F"   >> './tmpfile'; \
	done 


echo    'Searching...'

#Searching for references


find  "./$vault/$attachfolder" -type f -iname \* | while read F; \
        do grep -qi "${F##*/}" './tmpfile'; \
			if [[ $? != 0 ]]; then \
                           echo "${F##*/}" " is orphan" ; \
			   #Move them 
			   mv "$F" './Orphaned'
			fi \

        done 




rm './tmpfile'

echo    'Done!'
