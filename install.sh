#!/bin/bash

if [ ! -e "$HOME/Library/Developer/Xcode/UserData/CodeSnippets" ];
then
    echo "Linking Code Snippets"
    mkdir -p "$HOME/Library/Developer/Xcode/UserData"
    ln -shF "$PWD/Code\ Snippets" "$HOME/Library/Developer/Xcode/UserData/CodeSnippets"
fi

for group in File\ Templates/*; do
    echo "Linking $group"

    mkdir -p "$HOME/Library/Developer/Xcode/Templates/File Templates"
    ln -shF "$PWD/$group" "$HOME/Library/Developer/Xcode/Templates/$group"
done

echo "Installing Scripts/hide_simulator.scpt"

read -d '' HIDE_SIMULATOR <<EOF
<dict>
    <key>Xcode.Alert.RunScript</key>
    <dict>
        <key>enabled</key>
        <true/>
        <key>path</key>
        <string>$PWD/Scripts/hide_simulator.scpt</string>
    </dict>
</dict>
EOF

defaults write com.apple.dt.Xcode "Xcode.AlertEvents.4_1" -dict-add "Xcode.AlertEvent.TestingGeneratesOutput" "$HIDE_SIMULATOR"
defaults write com.apple.dt.Xcode "Xcode.AlertEvents" -dict-add "Xcode.AlertEvent.TestingGeneratesOutput" "$HIDE_SIMULATOR"

echo "\nPlease Restart Xcode"
