on run
	set keepGoing to true

	repeat while keepGoing
		-- Pick folder
		try
			set chosenFolder to POSIX path of (choose folder with prompt "Pick a folder to organize")
		on error
			return
		end try

		set folderName to do shell script "basename " & quoted form of chosenFolder

		-- Build HTML preview (returns total count on stdout)
		set totalCount to do shell script "__INSTALL_DIR__/bin/organize-preview " & quoted form of chosenFolder

		if totalCount is "0" then
			set again to button returned of (display dialog "'" & folderName & "' is already organized — nothing to move." with title "Organize Folder" buttons {"Done", "Pick Another Folder"} default button "Done" with icon note)
			if again is "Pick Another Folder" then
				set keepGoing to true
			else
				return
			end if
		else
			-- Open preview in browser
			do shell script "open /tmp/organize-preview.html"
			delay 0.8

			-- Confirm
			try
				display dialog totalCount & " files in '" & folderName & "' will be organized." & return & return & "Review the preview in your browser, then click Organize." with title "Organize Folder" buttons {"Cancel", "Organize"} default button "Organize" cancel button "Cancel" with icon note
			on error
				do shell script "rm -f /tmp/organize-preview.html /tmp/organize-raw.txt"
				set again to button returned of (display dialog "Cancelled." with title "Organize Folder" buttons {"Done", "Pick Another Folder"} default button "Done")
				if again is "Pick Another Folder" then
					set keepGoing to true
				else
					return
				end if
			end try

			-- Organize
			set resultText to do shell script "__INSTALL_DIR__/bin/organize-folder " & quoted form of chosenFolder & " 2>&1"
			do shell script "rm -f /tmp/organize-preview.html /tmp/organize-raw.txt"

			set resultLine to last paragraph of resultText
			set again to button returned of (display dialog "Done — " & resultLine with title "Organize Folder" buttons {"Done", "Pick Another Folder"} default button "Done" with icon note)
			if again is "Pick Another Folder" then
				set keepGoing to true
			else
				return
			end if
		end if
	end repeat
end run
