on run
  set theQuery to {"~/Desktop"}
  set finderSelection to ""
  set theTarget to ""
  set defaultTarget to (path to home folder as alias)
 
  if theQuery is "" then
      tell application "Finder"
          set finderSelection to (get selection)
          if length of finderSelection is greater than 0 then
              set theTarget to finderSelection
          else
              try
                  set theTarget to (folder of the front window as alias)
              on error
                  set theTarget to defaultTarget
              end try
          end if

          tell application "Typora"
              open theTarget as alias
          end tell
      end tell
  else
      try
          set targets to theQuery as string
              if targets starts with "~" then
                  set userHome to POSIX path of (path to home folder)
                  if userHome ends with "/" then
                      set userHome to characters 1 thru -2 of userHome as string
                  end if
                  try
                      set targets to userHome & characters 2 thru -1 of targets as string
                  on error
                      set targets to userHome
                  end try

              end if

          tell application "Typora"
              open targets
          end tell

      on error
          return (targets as string) & " is not a valid file or folder path."
      end try
  end if

  return theQuery
end run