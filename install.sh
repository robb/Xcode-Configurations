#!/bin/sh

if [ ! -e "$HOME/Library/Developer/Xcode/UserData/CodeSnippets" ];
then
    echo "Linking Code Snippets"
    mkdir -p "$HOME/Library/Developer/Xcode/UserData"
    ln -s "$PWD/CodeSnippets" "$HOME/Library/Developer/Xcode/UserData/CodeSnippets"
fi
