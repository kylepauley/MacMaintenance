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
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_

    -- MacMaintenance BEGIN
    
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
        do shell script "defaults write com.apple.finder EnableODiskBrowsing -boolean TRUE && killall Finder"
        spinner's stopAnimation_(sender)
    end EntfernteCDDVDaktivierenJA_
    
    on EntfernteCDDVDaktivierenNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.finder EnableODiskBrowsing -boolean FALSE && killall Finder"
        spinner's stopAnimation_(sender)
    end EntfernteCDDVDaktivierenNEIN_
    
    -- Erweiterter Speichern unter Dialog
    on ErweiterterSpeichernUnterDialogJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write -g NSNavPanelExpandedStateForSaveMode -boolean TRUE"
        spinner's stopAnimation_(sender)
    end ErweiterterSpeichernUnterDialogJA_
    
    on ErweiterterSpeichernUnterDialogNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write -g NSNavPanelExpandedStateForSaveMode -boolean FALSE"
        spinner's stopAnimation_(sender)
    end ErweiterterSpeichernUnterDialogNEIN_
    
    -- AirDrop auf nicht unterstützten Macs aktivieren
    on AirDropAktivierenJA_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.NetworkBrowser BrowseAllInterfaces -boolean TRUE"
        spinner's stopAnimation_(sender)
    end AirDropAktivierenJA_
    
    on AirDropAktivierenNEIN_(sender)
        spinner's startAnimation_(sender)
        do shell script "defaults write com.apple.NetworkBrowser BrowseAllInterfaces -boolean FALSE"
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
        spinner's stopAnimation_(sender)
    end Cachesloeschen_
    
    -- Inaktiven Bereich im Arbeitsspeicher aufräumen
    on InaktivenRAMleeren_(sender)
        spinner's startAnimation_(sender)
        do shell script "purge"
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
            do shell script "launchctl stop org.cups.cupsd && mv /etc/cups/cupsd.conf /etc/cups/cupsd.conf.backup && cp /etc/cups/cupsd.conf.default /etc/cups/cupsd.conf && mv /etc/cups/printers.conf /etc/cups/printers.conf.backup && launchctl start org.cups.cupsd" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end DrucksystemZuruecksetzen_
    
    -- Drucksystem Admin öffnen
    on CUPSconfigadmin_(sender)
        spinner's startAnimation_(sender)
        do shell script "if [ `cupsctl | grep WebInterface` != "WebInterface=yes" ]; then cupsctl WebInterface=yes; fi"
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
            do shell script "mv /etc/apache2/httpd.conf.backup /etc/apache2/httpd.conf" with administrator privileges
        end try
        spinner's stopAnimation_(sender)
    end PHP5imApacheAktivierenNEIN_
    
    -- MacMaintenance END
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script