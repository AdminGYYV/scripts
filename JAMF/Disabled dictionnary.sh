#!/bin/bash

# Script to disable the dictionnaries
# For computers used for exams
# This script is not working for MACOS dictionnaries.

sudo chmod -R 700 /Library/dictionnaries/
sudo chmod -R 700/System/Library/Assets/com_apple_MobileAsset_DictionaryServices_dictionaryOSX

sudo rm -R /Applications/Microsoft\ Word.app/Contents/SharedSupport/Proofing\ Tools/*
echo "Suppression des dictionnaire Word terminée"
sudo rm -R /Applications/Microsoft\ Excel.app/Contents/SharedSupport/Proofing\ Tools/*
echo "Suppression des dictionnaire Excel terminée"
sudo rm -R /Applications/Microsoft\ PowerPoint.app/Contents/SharedSupport/Proofing\ Tools/*
echo "Suppression des dictionnaire PowerPoint terminée"
sudo rm -R /Applications/Microsoft\ OneNote.app/Contents/SharedSupport/Proofing\ Tools/*
echo "Suppression des dictionnaire OneNote terminée"

sudo chmod -R 700 /Applications/LibreOffice.app/Contents/Resources/autocorr/
sudo chmod -R 700 /Applications/LibreOffice.app/Contents/Resources/autotext/
sudo rm -R /Applications/LibreOffice.app/Contents/Resources/extensions/dict-*