on run
  set Target to ""
  set defaultTarget to (path to home folder as alias)
  set para to "{query}"

  if para is "" then
      tell application "Finder"

          try
              set Target to (folder of the front window as alias)
          on error
              set Target to defaultTarget
          end try

          tell application "Typora"
              open Target as alias
          end tell

      end tell
  else
      try
          set Target to para as string
              if Target starts with "~" then
                  set homepath to POSIX path of (path to home folder)
                  if homepath ends with "/" then
                      set homepath to characters 1 thru -2 of homepath as string
                  end if
                  try
                      set Target to homepath & characters 2 thru -1 of Target as string
                  on error
                      set Target to homepath
                  end try

              end if

          tell application "Typora"
              open Target
          end tell

      on error
          return (Target as string) & " is not a valid file or folder path."
      end try
  end if

  return para
end run