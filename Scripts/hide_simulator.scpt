#!/usr/bin/env osascript

if application "iOS Simulator" is running then
  set attempts to 0
  tell application "Finder"
    repeat while ((visible of process "iOS Simulator" is false) and (attempts is less than 10))
      set visible of process "iOS Simulator" to false
      delay 0.1
      set attempts to attempts + 1
    end repeat
    set visible of process "iOS Simulator" to false
  end tell
end if
