#!/bin/sh

if [ ! -e "$HOME/Library/Developer/Xcode/UserData/CodeSnippets" ];
then
    echo "Linking Code Snippets"
    mkdir -p "$HOME/Library/Developer/Xcode/UserData"
    ln -s "$PWD/CodeSnippets" "$HOME/Library/Developer/Xcode/UserData/CodeSnippets"
fi

for group in File\ Templates/*; do
    echo "Linking $group"

    mkdir -p "$HOME/Library/Developer/Xcode/Templates/File Templates"
    ln -s "$PWD/$group" "$HOME/Library/Developer/Xcode/Templates/$group"
done
