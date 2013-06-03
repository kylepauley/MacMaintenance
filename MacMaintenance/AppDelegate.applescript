--
--  AppDelegate.applescript
--  MacMaintenance
--
--  Created by Philipp on 15.05.13.
--  Copyright (c) 2013 Mr Maintenance. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
    property spinner : missing value
    property buttonPurgeMemory : missing value
    property buttonAirDropEnable : missing value
    property buttonAirDropDisable : missing value
    property SpeicherplatzCaches : missing value
    property tabView : missing value
    property tabFinder : missing value
    property tabDock : missing value
    property tabCaches : missing value
    property tabSystem : missing value
    property tabWartung : missing value
    property tabHinweise : missing value
    property popUpButtonWartung : missing value
    property aktionNachWartung : missing value
    property macMaintenanceVersion : missing value
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
        
        set projectVersion to current application's NSBundle's mainBundle()'s objectForInfoDictionaryKey_("CFBundleShortVersionString")
        macMaintenanceVersion's setStringValue_(projectVersion)
        
        set productVersion to do shell script "sw_vers -productVersion"
        -- Deaktiviere Funktionen die unter Snow Leopard nicht verfügbar sind
        if productVersion contains "10.6"
            buttonPurgeMemory's setEnabled_(false)
            buttonAirDropEnable's setEnabled_(false)
            buttonAirDropDisable's setEnabled_(false)
        end if
    
        -- Wie viel Speicherplatz belegen die Caches?
        set SpeicherplatzCachesinMB to do shell script "du -scm /Library/Caches/ /System/Library/Caches/ ~/Library/Caches/ | grep total | cut -f 1"
        SpeicherplatzCaches's setStringValue_("(ca. "&SpeicherplatzCachesinMB&" MB)")
	end applicationWillFinishLaunching_

    -- MacMaintenance BEGIN

    -- Tabs per Toolbar ansteuern
    on selectTabFinder_(sender)
        tabView's selectTabViewItem_(tabFinder)
    end selectTabFinder_

    on selectTabDock_(sender)
        tabView's selectTabViewItem_(tabDock)
    end selectTabDock_

    on selectTabCaches_(sender)
        tabView's selectTabViewItem_(tabCaches)
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
    on FinderVersteckteDateienJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.finder AppleShowAllFiles -boolean TRUE && killall Finder"
        spinner's stopAnimation_(sender)
    end FinderVersteckteDateienJA_
    
    on FinderVersteckteDateienNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.finder AppleShowAllFiles -boolean FALSE && killall Finder"
        spinner's stopAnimation_(sender)
    end FinderVersteckteDateienNEIN_
    
    -- Library Ordner im Finder anzeigen
    on FinderLibraryOrdnerJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "chflags nohidden ~/Library"
        spinner's stopAnimation_(sender)
    end FinderLibraryOrdnerJA_
    
    on FinderLibraryOrdnerNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "chflags hidden ~/Library"
        spinner's stopAnimation_(sender)
    end FinderLibraryOrdnerNEIN_
    
    -- Nachfrage beim Leeren des Papierkorbes anzeigen
    on NachfragePapierkorbLeerenJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.finder WarnOnEmptyTrash -boolean TRUE && killall Finder"
        spinner's stopAnimation_(sender)
    end NachfragePapierkorbLeerenJA_
    
    on NachfragePapierkorbLeerenNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.finder WarnOnEmptyTrash -boolean FALSE && killall Finder"
        spinner's stopAnimation_(sender)
    end NachfragePapierkorbLeerenNEIN_
    
    -- Entfernte CD/DVD aktivieren
    on EntfernteCDDVDaktivierenJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.finder EnableODiskBrowsing -boolean TRUE && defaults write com.apple.NetworkBrowser ODSSupported -bool TRUE && killall Finder"
        spinner's stopAnimation_(sender)
    end EntfernteCDDVDaktivierenJA_
    
    on EntfernteCDDVDaktivierenNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.finder EnableODiskBrowsing -boolean FALSE && defaults write com.apple.NetworkBrowser ODSSupported -bool FALSE && killall Finder"
        spinner's stopAnimation_(sender)
    end EntfernteCDDVDaktivierenNEIN_
    
    -- Erweiterter Speichern unter Dialog
    on ErweiterterSpeichernUnterDialogJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write -g NSNavPanelExpandedStateForSaveMode -boolean TRUE && killall Finder"
        spinner's stopAnimation_(sender)
    end ErweiterterSpeichernUnterDialogJA_
    
    on ErweiterterSpeichernUnterDialogNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write -g NSNavPanelExpandedStateForSaveMode -boolean FALSE && killall Finder"
        spinner's stopAnimation_(sender)
    end ErweiterterSpeichernUnterDialogNEIN_
    
    -- AirDrop auf nicht unterstützten Macs aktivieren
    on AirDropAktivierenJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.NetworkBrowser BrowseAllInterfaces -boolean TRUE && killall Finder"
        spinner's stopAnimation_(sender)
    end AirDropAktivierenJA_
    
    on AirDropAktivierenNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.NetworkBrowser BrowseAllInterfaces -boolean FALSE && killall Finder"
        spinner's stopAnimation_(sender)
    end AirDropAktivierenNEIN_
    
    -- ######################## DOCK ########################
    
    -- Ausgeblendete Programme durchsichtig anzeigen
    on AusgeblendeteProgrammeDurchsichtigJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.Dock showhidden -boolean TRUE && killall Dock"
        spinner's stopAnimation_(sender)
    end AusgeblendeteProgrammeDurchsichtigJA_
    
    on AusgeblendeteProgrammeDurchsichtigNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.Dock showhidden -boolean FALSE && killall Dock"
        spinner's stopAnimation_(sender)
    end AusgeblendeteProgrammeDurchsichtigNEIN_
    
    -- Dock im 2D Modus ausführen
    on Dockim2DModusJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.dock no-glass -boolean TRUE && killall Dock"
        spinner's stopAnimation_(sender)
    end Dockim2DModusJA_
    
    on Dockim2DModusNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.dock no-glass -boolean FALSE && killall Dock"
        spinner's stopAnimation_(sender)
    end Dockim2DModusNEIN_

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
            do shell script "purge"
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
    on TimeMachineNetzlaufwerkeJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes -boolean TRUE"
        spinner's stopAnimation_(sender)
    end TimeMachineNetzlaufwerkeJA_
    
    on TimeMachineNetzlaufwerkeNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes -boolean FALSE"
        spinner's stopAnimation_(sender)
    end TimeMachineNetzlaufwerkeNEIN_
    
    -- LaunchServiceDB zurücksetzen
    on LaunchServiceDBZuruecksetzen_(sender)
        spinner's startAnimation_(sender)
        do shell script "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user"
        spinner's stopAnimation_(sender)
    end LaunchServiceDBZuruecksetzen_
    
    -- Mac OS X Einrichtungsdialog zurücksetzen
    on AppleSetupDoneLoeschenJA_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "rm /var/db/.AppleSetupDone" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end AppleSetupDoneLoeschenJA_
    
    on AppleSetupDoneLoeschenNEIN_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "touch /var/db/.AppleSetupDone" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end AppleSetupDoneLoeschenNEIN_
    
    -- PHP5 im eingebauten Webserver aktivieren
    on PHP5imApacheAktivierenJA_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "mv /etc/apache2/httpd.conf /etc/apache2/httpd.conf.backup && cat /etc/apache2/httpd.conf.backup | sed -e 's/#LoadModule php5_module/LoadModule php5_module/' > /etc/apache2/httpd.conf" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end PHP5imApacheAktivierenJA_
    
    on PHP5imApacheAktivierenNEIN_(sender)
        spinner's startAnimation_(sender)
        try
            do shell script "if [ -f /etc/apache2/httpd.conf.backup ]; then mv /etc/apache2/httpd.conf.backup /etc/apache2/httpd.conf; fi" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end PHP5imApacheAktivierenNEIN_
    
    -- FTP Dateifreigabe wieder aktivieren (ab Lion)
    on FTPDateifreigabeAktivierenJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "mv /System/Library/LaunchDaemons/ftp.plist /System/Library/LaunchDaemons/ftp.plist.backup && cat /System/Library/LaunchDaemons/ftp.plist.backup | sed -e 's/Disabled/Enabled/' > /System/Library/LaunchDaemons/ftp.plist" with administrator privileges
        do shell script "launchctl load -w /System/Library/LaunchDaemons/ftp.plist" with administrator privileges
        spinner's stopAnimation_(sender)
    end FTPDateifreigabeAktivierenJA_
    
    on FTPDateifreigabeAktivierenNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "launchctl unload -w /System/Library/LaunchDaemons/ftp.plist" with administrator privileges
        do shell script "if [ -f /System/Library/LaunchDaemons/ftp.plist.back ]; then mv /System/Library/LaunchDaemons/ftp.plist.backup /System/Library/LaunchDaemons/ftp.plist; fi" with administrator privileges
        spinner's stopAnimation_(sender)
    end FTPDateifreigabeAktivierenNEIN_

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