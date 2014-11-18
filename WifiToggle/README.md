WifiToggle
==========

Package to install script and launchagent for automatic toggle of the Wifi interface.
ToggleAirport script turn off Wifi interface when Ethernet interface goes up and vice versa.
Tested with legacy ethernet port, USB ethernet and thunderbolt ethernet. 

To know if WifiToggle work with your ethernet interface, use this command : 
`networksetup -listallhardwareports`
If your ethernet "Hardware Port" have "ethernet" in his name, WifiToggle should work.



*Initial main script credits goes to Trenneren @ http://hints.macworld.com/article.php?story=20100927161027611*