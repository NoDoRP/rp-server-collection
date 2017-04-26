
# Welcome to the NoDoRP GTAV github page.

This is where the sever code lives for the server.


To open the sever, simply open the CitizenMP.Server.exe file. This should automatically start the server.

## Extra info.
The citmp-server.yml file has what scripts running in the server, the backup version contains everything that was active earlier (all the es_roleplay stuff)
Going through the folders, the [assets] folder has most of the standalone scripts, and pretty much everything there works.
### [caraddons] folder
has all the cars I've added. flatb is the flatbed truck, imex is just a way to force the importexport and special races cars to work, ivpackr is IVpack, nodopack is a couple addon cars combined, podo is the police dominator. Everything else in there was experimenting with things.
### [essential]
has all the scripts that requires essential mode to run. As of right now, I know banking and paycheck to work as advertised. es_admin probably works with server groups done. es_carshop kind of works, someone should look into how to add cars for that.
### es_roleplay
contains a lot,  its probably easier to go though the advanced RP server dump because that folder is esseintially that pack put into one folder. Again, I needed to condense some things so the server runs. What probably should be looked into of that folder is the players.lua and playerc.lua scripts as that's the character customization scripts. The rest are store scripts and job scripts which work to some degree from what I've seen.
the SQL database stuff is basically every database I installed for the server to work. It should have every one I used. Also just a little warning, every script requiring use of the mysql database does need your password for it.
### [gameplay]
has some misc. standalone jobs and the compass. They all work iirc.
### [system]
I didn't add much that's currently still active on the server. loadipl is the main one added there. baseevents,chat,hardcap,rconlog,scoreboard and sessionmanager were all there from base and probably for the most part be left alone.
oh and spawnmanage
### [test]
has the coordinates saving script and the loading splash screen.
everything else in the resources folder is pretty self explanitory I think.
Outside of those files nothing else gets changed.
