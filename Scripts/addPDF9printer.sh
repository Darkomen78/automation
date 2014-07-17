#!/bin/bash

PPDSRC='/Applications/Adobe Acrobat 9 Pro/Adobe Acrobat Pro.app/Contents/MacOS/SelfHealFiles/AdobePDFPrinter/PPDs/Contents/Resources/en.lproj/ADPDF9.PPD'
PPDDEST='/Library/Printers/PPDs/Contents/Resources/en.lproj/ADPDF9.PPD'
PRINTERNAME='AdobePDF'
PRINTERADDR='lpd://127.0.0.1'

cp "$PPDSRC" "$PPDDEST"
/usr/sbin/lpadmin -E -p $PRINTERNAME -v "$PRINTERADDR" -P "$PPDDEST" -o printer-is-shared=false && cupsenable $PRINTERNAME && cupsaccept $PRINTERNAME

exit 0

