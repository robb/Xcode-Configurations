#!/bin/bash

CODE_SNIPPETS="$HOME/Library/Developer/Xcode/UserData/CodeSnippets"
TEMPLATES="$HOME/Library/Developer/Xcode/Templates/"

# Code Snippets

echo "Linking Code Snippets"

if [ "$(readlink $CODE_SNIPPETS)" = "$PWD/Code Snippets" ]; then
    >&2 echo "$CODE_SNIPPETS is a symbolic link that points to "$PWD/Code Snippets","
    >&2 echo "please remove it and try again."
    exit 1
fi

mkdir -p "$CODE_SNIPPETS"

for snippet in Code\ Snippets/*; do
    ID=$(xmllint -xpath "//key[contains(.,'IDECodeSnippetIdentifier')]/following-sibling::*[1]/text()" "$snippet")

    echo "- $snippet"

    ln -shfF "$PWD/$snippet" "$CODE_SNIPPETS/$ID.codesnippet"
done

# File Templates

mkdir -p "$TEMPLATES/File Templates"

echo ""
echo "Linking: File Templates"

for group in File\ Templates/*; do
    echo "- $group"

    ln -shfF "$PWD/$group" "$TEMPLATES/$group"
done

echo ""
echo "Installing Scripts"
echo "- Scripts/hide_simulator.scpt"

# Scripts

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

echo ""
echo "Please Restart Xcode"
