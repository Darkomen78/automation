automation
==========

Scripts and other stuff for macadmins

Kickstart and autoconfig works better with MDS and Munki but you can adapt them to work with anything.

General purpose of this repo is to minimize manual action to get a fresh pre-configurate “in a good way” system from scratch.

Example workflow :

1. Recovery boot (manual or auto with MDS arduino)
2. MDS : Erase and install (manual or auto)
3. MDS ask some variables (manual) : Computer Name, Tag, Full Username, Server User Password, Munki Option
4. Reboot and system install (auto)
5. Munki install and main configuration script (auto)
6. Local admin login and configuration (auto)
7. Munki first run on “munki option” manifest (auto)
8. Admin logout and email “computer ready” sent (auto)
9. Local user login (manual)
10. Local user session configuration (auto)
11. Local user mail/vpn/timemachine configuration (semi-auto)

Example in motion : [macOS 10.14 Mojave automatic install on T2 device](https://www.youtube.com/watch?v=xFASDulnU48)
