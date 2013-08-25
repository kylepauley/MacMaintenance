--
--  AppDelegate.applescript
--  MacMaintenance
--
--  Created by Philipp on 15.05.13.
--  Copyright (c) 2013 Mr Maintenance. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
    -- Variablen setzen
    property spinner : missing value
    property buttonPurgeMemory : missing value
    property SpeicherplatzCaches : missing value
    property toolbar : missing value
    property tabView : missing value
    property tabFinder : missing value
    property tabDock : missing value
    property tabCaches : missing value
    property tabSystem : missing value
    property tabWartung : missing value
    property tabHinweise : missing value
    property popUpButtonWartung : missing value
    property aktionNachWartung : missing value
    property answerDockSize : 0
    property macMaintenanceVersion : missing value
        
    -- Einstellungen
    property settingFinderHiddenFiles : missing value
    property settingFinderLibraryOrdner : missing value
    property settingPapierkorbWarnung : missing value
    property settingEntfernteCDDVD : missing value
    property settingSpeichernUnterDialog : missing value
    property settingAirDrop : missing value
    property settingBildschirmfotoSchatten : missing value
    property settingDockDurchsichtig : missing value
    property settingDock2D : missing value
    property settingDockSizePixel : 0
    property settingTimeMachineNetzlaufwerke : missing value
    property settingInitialSetup : missing value
    property settingPHP5eingebauterWebserver : missing value
    property settingFTPwiederAktivieren : missing value
    property settingApache2WebserverStarten : missing value
    
    -- Checkboxen
    property checkBoxFinderHiddenFiles : missing value
    property checkBoxFinderLibraryOrdner : missing value
    property checkBoxPapierkorbWarnung : missing value
    property checkBoxEntfernteCDDVD : missing value
    property checkBoxSpeichernUnterDialog : missing value
    property checkBoxAirDrop : missing value
    property checkBoxBildschirmfotoSchatten : missing value
    property checkBoxDockDurchsichtig : missing value
    property checkBoxDock2D : missing value
    property checkBoxTimeMachineNetzlaufwerke : missing value
    property checkBoxInitialSetup : missing value
    property checkBoxPHP5eingebauterWebserver : missing value
    property checkBoxFTPwiederAktivieren : missing value
    property checkBoxApache2WebserverStarten : missing value
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
        
        -- Feststellen welche Einstellungen momentan aktiv sind
        -- Finder Versteckte Dateien
        try
            set settingFinderHiddenFiles to (do shell script "defaults read com.apple.finder AppleShowAllFiles")
        end try
        if settingFinderHiddenFiles is "1" then
           checkBoxFinderHiddenFiles's setState_(1)
        else
            set settingFinderHiddenFiles to "0"
            checkBoxFinderHiddenFiles's setState_(0)
        end if
        -- Finder Library Ordner
        try
            set settingFinderLibraryOrdner to (do shell script "ls -lO ~ |grep Library|grep hidden")
        end try
        if settingFinderLibraryOrdner contains "hidden" then
            checkBoxFinderLibraryOrdner's setState_(0)
        else
            checkBoxFinderLibraryOrdner's setState_(1)
        end if
        -- Papierkorb Warnung
        try
            set settingPapierkorbWarnung to (do shell script "defaults read com.apple.finder WarnOnEmptyTrash")
        end try
        if settingPapierkorbWarnung is "1" then
            checkBoxPapierkorbWarnung's setState_(1)
        else
            set settingPapierkorbWarnung to "0"
            checkBoxPapierkorbWarnung's setState_(0)
        end if
        -- Entfernte CD/DVD
        try
            set settingEntfernteCDDVD to (do shell script "defaults read com.apple.finder EnableODiskBrowsing")
        end try
        if settingEntfernteCDDVD is "1" then
            checkBoxEntfernteCDDVD's setState_(1)
        else
            set settingEntfernteCDDVD to "0"
            checkBoxEntfernteCDDVD's setState_(0)
        end if
        -- Erweiterter Speichern unter Dialog
        try
            set settingSpeichernUnterDialog to (do shell script "defaults read -g NSNavPanelExpandedStateForSaveMode")
        end try
        if settingSpeichernUnterDialog is "1" then
            checkBoxSpeichernUnterDialog's setState_(1)
        else
            set settingSpeichernUnterDialog to "0"
            checkBoxSpeichernUnterDialog's setState_(0)
        end if
        -- AirDrop
        try
            set settingAirDrop to (do shell script "defaults read com.apple.NetworkBrowser BrowseAllInterfaces")
        end try
        if settingAirDrop is "1" then
            checkBoxAirDrop's setState_(1)
        else
            set settingAirDrop to "0"
            checkBoxAirDrop's setState_(0)
        end if
        -- Bildschirmfotos ohne Schatten
        try
            set settingBildschirmfotoSchatten to (do shell script "defaults read com.apple.screencapture disable-shadow")
        end try
        if settingBildschirmfotoSchatten is "1" then
            checkBoxBildschirmfotoSchatten's setState_(1)
        else
            set settingBildschirmfotoSchatten to "0"
            checkBoxBildschirmfotoSchatten's setState_(0)
        end if
        -- Dock Apps durchsichtig
        try
            set settingDockDurchsichtig to (do shell script "defaults read com.apple.Dock showhidden")
        end try
        if settingDockDurchsichtig is "1" then
            checkBoxDockDurchsichtig's setState_(1)
        else
            set settingDockDurchsichtig to "0"
            checkBoxDockDurchsichtig's setState_(0)
        end
        -- Dock 2D Modus
        try
            set settingDock2D to (do shell script "defaults read com.apple.dock no-glass")
        end try
        if settingDock2D is "1" then
            checkBoxDock2D's setState_(1)
        else
            set settingDock2D to "0"
            checkBoxDock2D's setState_(0)
        end if
        -- Dock Größe in Pixeln
        try
            set settingDockSizePixel to (do shell script "defaults read com.apple.dock tilesize") as integer
        end try
        -- TimeMachine auf Netzlaufwerke
        try
            set settingTimeMachineNetzlaufwerke to (do shell script "defaults read com.apple.systempreferences TMShowUnsupportedNetworkVolumes")
        end try
        if settingTimeMachineNetzlaufwerke is "1" then
            checkBoxTimeMachineNetzlaufwerke's setState_(1)
        else
            set settingTimeMachineNetzlaufwerke to "0"
            checkBoxTimeMachineNetzlaufwerke's setState_(0)
        end if
        -- Mac OS X Einrichtungsassistent
        try
            set settingInitialSetup to (do shell script "if [ -f /var/db/.AppleSetupDone ]; then echo '0'; else echo '1'; fi")
        end try
        if settingInitialSetup is "1" then
            checkBoxInitialSetup's setState_(1)
        else
            checkBoxInitialSetup's setState_(0)
        end if
        -- Apache2 Webserver starten
        try
            set settingApache2WebserverStarten to (do shell script "TESTVAR=`ps aux|grep http[d]|wc -l` && echo $TESTVAR")
        end try
        if (settingApache2WebserverStarten is greater than "0") then
            checkBoxApache2WebserverStarten's setState_(1)
            else
            checkBoxApache2WebserverStarten's setState_(0)
        end if
        
        -- PHP5 eingebauter Webserver
        try
            set settingPHP5eingebauterWebserver to (do shell script "cat /etc/apache2/httpd.conf |grep libphp5.so|colrm 2")
        end try
        if settingPHP5eingebauterWebserver is "L" then
            checkBoxPHP5eingebauterWebserver's setState_(1)
        else if settingPHP5eingebauterWebserver is "#" then
            checkBoxPHP5eingebauterWebserver's setState_(0)
        end if
        -- FTP Dienst wieder aktivieren
        try
            set settingFTPwiederAktivieren to (do shell script "cat /System/Library/LaunchDaemons/ftp.plist|grep Enabled")
        end try
        if settingFTPwiederAktivieren contains "Enabled" then
            set settingFTPwiederAktivieren to "1"
            checkBoxFTPwiederAktivieren's setState_(1)
        else
            set settingFTPwiederAktivieren to "0"
            checkBoxFTPwiederAktivieren's setState_(0)
        end if
        
        -- ######################################
        
        -- Projektversion für die GUI
        set projectVersion to current application's NSBundle's mainBundle()'s objectForInfoDictionaryKey_("CFBundleShortVersionString")
        macMaintenanceVersion's setStringValue_(projectVersion)
        
        -- Deaktiviere Funktionen die unter Snow Leopard / Mavericks nicht verfügbar sind
        set productVersion to (do shell script "sw_vers -productVersion")
        if productVersion contains "10.6"
            buttonPurgeMemory's setEnabled_(false)
            checkBoxAirDrop's setEnabled_(false)
            checkBoxFTPwiederAktivieren's setEnabled_(false)
            checkBoxApache2WebserverStarten's setEnabled_(false)
        else if productVersion contains "10.7"
            checkBoxApache2WebserverStarten's setEnabled_(false)
        else if productVersion contains "10.9"
            checkBoxDock2D's setEnabled_(false)
            checkBoxDockDurchsichtig's setEnabled_(false)
        end if
    
        -- Wie viel Speicherplatz belegen die Caches?
        set SpeicherplatzCachesinMB to do shell script "du -scm /Library/Caches/ /System/Library/Caches/ ~/Library/Caches/ | grep total | cut -f 1"
        SpeicherplatzCaches's setStringValue_("(ca. "&SpeicherplatzCachesinMB&" MB)")
    
        -- Finder Toolbar Objekt hervorheben
        toolbar's setSelectedItemIdentifier_("toolbarFinder")
	end applicationWillFinishLaunching_

    -- MacMaintenance BEGIN

    -- ######################## TABS & TOOLBAR ########################

    -- Tabs per Toolbar ansteuern
    on selectTabFinder_(sender)
        tabView's selectTabViewItem_(tabFinder)
    end selectTabFinder_

    on selectTabDock_(sender)
        tabView's selectTabViewItem_(tabDock)
    end selectTabDock_

    on selectTabCaches_(sender)
        tabView's selectTabViewItem_(tabCaches)
        set SpeicherplatzCachesinMB to do shell script "du -scm /Library/Caches/ /System/Library/Caches/ ~/Library/Caches/ | grep total | cut -f 1"
        SpeicherplatzCaches's setStringValue_("(ca. "&SpeicherplatzCachesinMB&" MB)")
    end selectTabCaches_

    on selectTabSystem_(sender)
        tabView's selectTabViewItem_(tabSystem)
    end selectTabSystem_

    on selectTabWartung_(sender)
        tabView's selectTabViewItem_(tabWartung)
    end selectTabWartung_

    on selectTabHinweise_(sender)
        tabView's selectTabViewItem_(tabHinweise)
    end selectTabHinweise_

    -- ######################## FINDER ########################
    
    -- Versteckte Dateien im Finder anzeigen
    on FinderVersteckteDateien_(sender)
        spinner's startAnimation_(sender)
        if settingFinderHiddenFiles is "1" then
            do shell script "defaults write com.apple.finder AppleShowAllFiles -boolean FALSE && killall Finder"
            set settingFinderHiddenFiles to "0"
        else
            do shell script "defaults write com.apple.finder AppleShowAllFiles -boolean TRUE && killall Finder"
            set settingFinderHiddenFiles to "1"
        end if
        spinner's stopAnimation_(sender)
    end FinderVersteckteDateien_
    
    -- Library Ordner im Finder anzeigen
    on FinderLibraryOrdner_(sender)
        spinner's startAnimation_(sender)
        if settingFinderLibraryOrdner contains "hidden" then
            do shell script "chflags nohidden ~/Library"
            set settingFinderLibraryOrdner to ""
        else
            do shell script "chflags hidden ~/Library"
            set settingFinderLibraryOrdner to "hidden"
        end if
        spinner's stopAnimation_(sender)
    end FinderLibraryOrdner_
    
    -- Nachfrage beim Leeren des Papierkorbes anzeigen
    on NachfragePapierkorbLeeren_(sender)
        spinner's startAnimation_(sender)
        if settingPapierkorbWarnung is "1" then
            do shell script "defaults write com.apple.finder WarnOnEmptyTrash -boolean FALSE && killall Finder"
            set settingPapierkorbWarnung to "0"
        else
            do shell script "defaults write com.apple.finder WarnOnEmptyTrash -boolean TRUE && killall Finder"
            set settingPapierkorbWarnung to "1"
        end if
        spinner's stopAnimation_(sender)
    end NachfragePapierkorbLeeren_
    
    -- Entfernte CD/DVD aktivieren
    on EntfernteCDDVDaktivieren_(sender)
        spinner's startAnimation_(sender)
        if settingEntfernteCDDVD is "1" then
            do shell script "defaults write com.apple.finder EnableODiskBrowsing -boolean FALSE && defaults write com.apple.NetworkBrowser ODSSupported -boolean FALSE && killall Finder"
            set settingEntfernteCDDVD to "0"
        else
            do shell script "defaults write com.apple.finder EnableODiskBrowsing -boolean TRUE && defaults write com.apple.NetworkBrowser ODSSupported -boolean TRUE && killall Finder"
            set settingEntfernteCDDVD to "1"
        end if
        spinner's stopAnimation_(sender)
    end EntfernteCDDVDaktivieren_
    
    -- Erweiterter Speichern unter Dialog
    on ErweiterterSpeichernUnterDialog_(sender)
        spinner's startAnimation_(sender)
        if settingSpeichernUnterDialog is "1" then
            do shell script "defaults write -g NSNavPanelExpandedStateForSaveMode -boolean FALSE && killall Finder"
            set settingSpeichernUnterDialog to "0"
        else
            do shell script "defaults write -g NSNavPanelExpandedStateForSaveMode -boolean TRUE && killall Finder"
            set settingSpeichernUnterDialog to "1"
        end if
        spinner's stopAnimation_(sender)
    end ErweiterterSpeichernUnterDialog_
    
    -- AirDrop auf nicht unterstützten Macs aktivieren
    on AirDropAktivieren_(sender)
        spinner's startAnimation_(sender)
        if settingAirDrop is "1" then
            do shell script "defaults write com.apple.NetworkBrowser BrowseAllInterfaces -boolean FALSE && killall Finder"
            set settingAirDrop to "0"
        else
            do shell script "defaults write com.apple.NetworkBrowser BrowseAllInterfaces -boolean TRUE && killall Finder"
            set settingAirDrop to "1"
        end if
        spinner's stopAnimation_(sender)
    end AirDropAktivieren_

    -- Bildschirmfotos ohne Schatten
    on BildschirmfotosOhneSchatten_(sender)
        spinner's startAnimation_(sender)
        if settingBildschirmfotoSchatten is "1" then
            try
                do shell script "defaults write com.apple.screencapture disable-shadow -boolean FALSE && killall SystemUIServer && sleep 5"
                set settingBildschirmfotoSchatten to "0"
            end try
        else
            try
                do shell script "defaults write com.apple.screencapture disable-shadow -boolean TRUE && killall SystemUIServer && sleep 5"
                set settingBildschirmfotoSchatten to "1"
            end try
        end if
        spinner's stopAnimation_(sender)
    end BildschirmfotosOhneSchatten_

    -- ######################## DOCK ########################
    
    -- Ausgeblendete Programme durchsichtig anzeigen
    on AusgeblendeteProgrammeDurchsichtig_(sender)
        spinner's startAnimation_(sender)
        if settingDockDurchsichtig is "1" then
            do shell script "defaults write com.apple.Dock showhidden -boolean FALSE && killall Dock"
            set settingDockDurchsichtig to "0"
        else
            do shell script "defaults write com.apple.Dock showhidden -boolean TRUE && killall Dock"
            set settingDockDurchsichtig to "1"
        end if
        spinner's stopAnimation_(sender)
    end AusgeblendeteProgrammeDurchsichtig_
    
    -- Dock im 2D Modus ausführen
    on Dockim2DModus_(sender)
        spinner's startAnimation_(sender)
        if settingDock2D is "1"
            do shell script "defaults write com.apple.dock no-glass -boolean FALSE && killall Dock"
            set settingDock2D to "0"
        else
            do shell script "defaults write com.apple.dock no-glass -boolean TRUE && killall Dock"
            set settingDock2D to "1"
        end if
        spinner's stopAnimation_(sender)
    end Dockim2DModus_

    -- Dock Größe in Pixeln angeben
    on DockSizePixel_(sender)
        spinner's startAnimation_(sender)
        try
            display dialog (localized string "DockSize") default answer settingDockSizePixel
            try
                set answerDockSize to (text returned of result) as integer
            end try
            if (answerDockSize is greater than "0") and (answerDockSize is less than "129") then
                set settingDockSizePixel to answerDockSize
                do shell script "defaults write com.apple.dock tilesize -int "&settingDockSizePixel
                do shell script "killall Dock"
                set answerDockSize to "0"
            end if
        end try
        spinner's stopAnimation_(sender)
    end DockSizePixel_

    -- ######################## CACHES ########################
    
    -- Caches löschen
    on Cachesloeschen_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "rm -rf /System/Library/Caches/*" with administrator privileges
            do shell script "rm -rf /Library/Caches/*" with administrator privileges
            do shell script "rm -rf ~/Library/Caches/*" with administrator privileges
        end try
        set SpeicherplatzCachesinMB to do shell script "du -scm /Library/Caches/ /System/Library/Caches/ ~/Library/Caches/ | grep total | cut -f 1"
        SpeicherplatzCaches's setStringValue_("(ca. "&SpeicherplatzCachesinMB&" MB)")
        spinner's stopAnimation_(sender)
    end Cachesloeschen_
    
    -- Inaktiven Bereich im Arbeitsspeicher aufräumen
    on InaktivenRAMleeren_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "purge" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end InaktivenRAMleeren_
    
    -- Spotlight Index neu aufbauen
    on SpotlightIndexNeuAufbauen_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "mdutil -i off / && mdutil -E / && mdutil -i on /" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end SpotlightIndexNeuAufbauen_
    
    -- Schriftarten Caches löschen
    on SchriftartenCachesNeuErstellen_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "atsutil databases -remove" with administrator privileges
            do shell script "atsutil databases -removeUser"
        end try
        spinner's stopAnimation_(sender)
    end SchriftartenCachesNeuErstellen_
    
    -- ######################## SYSTEM ########################
    
    -- Periodische Skripte ausführen
    on PeriodischeSkripteStarten_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "periodic daily weekly monthly" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end PeriodischeSkripteStarten_
    
    -- Zugriffsrechte reparieren
    on ZugriffsrechteReparieren_(sender)
        spinner's startAnimation_(sender)
        do shell script "diskutil repairPermissions /"
        spinner's stopAnimation_(sender)
    end ZugriffsrechteReparieren_
       
    -- Drucksystem zurücksetzen
    on DrucksystemZuruecksetzen_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "launchctl stop org.cups.cupsd && mv /etc/cups/cupsd.conf /etc/cups/cupsd.conf.backup && cp /etc/cups/cupsd.conf.default /etc/cups/cupsd.conf && if [ -f /etc/cups/printers.conf ]; then mv /etc/cups/printers.conf /etc/cups/printers.conf.backup; fi && rm -rf ~/Library/Printers/ && launchctl start org.cups.cupsd" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end DrucksystemZuruecksetzen_
    
    -- Drucksystem Admin öffnen
    on CUPSconfigadmin_(sender)
        spinner's startAnimation_(sender)
        do shell script "if [ `cupsctl | grep WebInterface` != 'WebInterface=yes' ]; then cupsctl WebInterface=yes; fi"
        do shell script ""
        tell application "Safari"
            activate
            open location "http://127.0.0.1:631"
        end tell
        spinner's stopAnimation_(sender)
    end CUPSconfigadmin_
    
    -- Time Machine Backups auf nicht unterstützte Laufwerke aktivieren
    on TimeMachineNetzlaufwerke_(sender)
        spinner's startAnimation_(sender)
        if settingTimeMachineNetzlaufwerke is "1" then
            do shell script "defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes -boolean FALSE"
            set settingTimeMachineNetzlaufwerke to "0"
        else
            do shell script "defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes -boolean TRUE"
            set settingTimeMachineNetzlaufwerke to "1"
        end if
        spinner's stopAnimation_(sender)
    end TimeMachineNetzlaufwerke_
    
    -- LaunchServiceDB zurücksetzen
    on LaunchServiceDBZuruecksetzen_(sender)
        spinner's startAnimation_(sender)
        do shell script "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user"
        spinner's stopAnimation_(sender)
    end LaunchServiceDBZuruecksetzen_
    
    -- Mac OS X Einrichtungsdialog zurücksetzen
    on AppleSetupDoneLoeschen_(sender)
        spinner's startAnimation_(sender)
        if settingInitialSetup is "1" then
            try
                do shell script "touch /var/db/.AppleSetupDone" with administrator privileges
                set settingInitialSetup to "0"
            on error
                checkBoxInitialSetup's setState_(1)
            end try
        else
            try
                do shell script "rm /var/db/.AppleSetupDone" with administrator privileges
                set settingInitialSetup to "1"
            on error
                checkBoxInitialSetup's setState_(0)
            end try
        end if
        spinner's stopAnimation_(sender)
    end AppleSetupDoneLoeschen_

    -- Apache2 Webserver starten
    on Apache2WebserverStarten_(sender)
        spinner's startAnimation_(sender)
        if settingApache2WebserverStarten is "0" then
            try
                do shell script "apachectl start" with administrator privileges
                set settingApache2WebserverStarten to "1"
            on error
                checkBoxApache2WebserverStarten's setState_(0)
            end try
        else
            try
                do shell script "apachectl stop" with administrator privileges
                set settingApache2WebserverStarten to "0"
            on error
                checkBoxApache2WebserverStarten's setState_(1)
            end try
        end if
        spinner's stopAnimation_(sender)
    end Apache2WebserverStarten_

    -- PHP5 im eingebauten Webserver aktivieren
    on PHP5imApacheAktivieren_(sender)
        spinner's startAnimation_(sender)
        if settingPHP5eingebauterWebserver is "#" then
            try
                do shell script "mv /etc/apache2/httpd.conf /etc/apache2/httpd.conf.tmp && cat /etc/apache2/httpd.conf.tmp | sed -e 's/#LoadModule php5_module/LoadModule php5_module/' > /etc/apache2/httpd.conf && rm /etc/apache2/httpd.conf.tmp" with administrator privileges
                set settingPHP5eingebauterWebserver to "L"
                if settingApache2WebserverStarten is "1" then
                    do shell script "apachectl restart" with administrator privileges
                end if
            on error
                checkBoxPHP5eingebauterWebserver's setState_(0)
            end try
        else if settingPHP5eingebauterWebserver is "L" then
            try
                do shell script "mv /etc/apache2/httpd.conf /etc/apache2/httpd.conf.tmp && cat /etc/apache2/httpd.conf.tmp | sed -e 's/LoadModule php5_module/#LoadModule php5_module/' > /etc/apache2/httpd.conf && rm /etc/apache2/httpd.conf.tmp" with administrator privileges
                set settingPHP5eingebauterWebserver to "#"
                if settingApache2WebserverStarten is "1" then
                    do shell script "apachectl restart" with administrator privileges
                end if
            on error
                checkBoxPHP5eingebauterWebserver's setState_(1)
            end try
        end if
        spinner's stopAnimation_(sender)
    end PHP5imApacheAktivieren_
    
    -- FTP Dateifreigabe wieder aktivieren (ab Lion)
    on FTPDateifreigabeAktivieren_(sender)
        spinner's startAnimation_(sender)
        if settingFTPwiederAktivieren contains "1" then
            try
                do shell script "launchctl unload -w /System/Library/LaunchDaemons/ftp.plist" with administrator privileges
                do shell script "mv /System/Library/LaunchDaemons/ftp.plist /System/Library/LaunchDaemons/ftp.plist.tmp && cat /System/Library/LaunchDaemons/ftp.plist.tmp | sed -e 's/Enabled/Disabled/' > /System/Library/LaunchDaemons/ftp.plist" with administrator privileges
                set settingFTPwiederAktivieren to "0"
            on error
                checkBoxFTPwiederAktivieren's setState_(1)
            end try
        else
            try
                do shell script "mv /System/Library/LaunchDaemons/ftp.plist /System/Library/LaunchDaemons/ftp.plist.tmp && cat /System/Library/LaunchDaemons/ftp.plist.tmp | sed -e 's/Disabled/Enabled/' > /System/Library/LaunchDaemons/ftp.plist" with administrator privileges
                do shell script "launchctl load -w /System/Library/LaunchDaemons/ftp.plist" with administrator privileges
                set settingFTPwiederAktivieren to "1"
            on error
                checkBoxFTPwiederAktivieren's setState_(0)
            end try
        end if
        spinner's stopAnimation_(sender)
    end FTPDateifreigabeAktivieren_

    -- ######################## WARTUNG ########################

    on wartungAusfuehren_(sender)
        display dialog (localized string "DialogCloseApps") with icon stop
        
        spinner's startAnimation_(sender)
        
        set aktionNachWartung to popUpButtonWartung's objectValue()
        set aktionNachWartung to aktionNachWartung as text

        -- Alle geöffneten Programme schließen
        tell application "System Events" to set the visible of every process to true
        set white_list to {"Finder", "MacMaintenance"}
        try
            tell application "Finder"
                set process_list to the name of every process whose visible is true
            end tell
            repeat with i from 1 to (number of items in process_list)
                set this_process to item i of the process_list
                if this_process is not in white_list then
                    tell application this_process
                        quit saving no
                    end tell
                end if
            end repeat
        end try
        
        -- Hier kommt das Wartungsskript hin
        try
            -- 0 bedeutet nichts unternehmen
            if aktionNachWartung contains "0" then
                do shell script "rm -rf /System/Library/Caches/* ; rm -rf /Library/Caches/* ; rm -rf ~/Library/Caches/* ; periodic daily weekly monthly ; diskutil repairPermissions /" with administrator privileges
            -- 1 bedeutet sleep
            else if aktionNachWartung contains "1" then
                do shell script "rm -rf /System/Library/Caches/* ; rm -rf /Library/Caches/* ; rm -rf ~/Library/Caches/* ; periodic daily weekly monthly ; diskutil repairPermissions /" with administrator privileges
                tell application "System Events" to sleep
            -- 2 bedeutet Neu starten
            else if aktionNachWartung contains "2" then
                do shell script "rm -rf /System/Library/Caches/* ; rm -rf /Library/Caches/* ; rm -rf ~/Library/Caches/* ; periodic daily weekly monthly ; diskutil repairPermissions / ; shutdown -r now" with administrator privileges
            -- 3 bedeutet Herunterfahren
            else if aktionNachWartung contains "3" then
                do shell script "rm -rf /System/Library/Caches/* ; rm -rf /Library/Caches/* ; rm -rf ~/Library/Caches/* ; periodic daily weekly monthly ; diskutil repairPermissions / ; shutdown -h now" with administrator privileges
            end if
        end try
        spinner's stopAnimation_(sender)
    end wartungAusfuehren_

    -- MacMaintenance END
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script