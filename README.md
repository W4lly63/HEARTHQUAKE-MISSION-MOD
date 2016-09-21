# HEARTHQUAKE-MISSION-MOD


Mission Mod for Arma2 Epoch - Tested on Epoch 1.0.6 RC1 - Dayz 1.8.8

HearthQuake Simulation Mission ALPHA 0.3

Description/Features

Generates earthquakes around map after a time ... in the radius destroys a lot of Buildings
Spawn a loots crate and if selected (recommended) groups of AI Enemy ... It increases the difficulty of game... may happen to be in a building in the earthquake area... and die.
It is not a classic mission because unknown location of crate in a radius of one km in a devasted area where there are various groups of AI is difficult to complete.

* HeartQuake in Random Zone with a lot of Buildings Destroyed
* Spawn Crate inside HQ Zone in Random Coords
* Spawn Some Groups of AI inside HQ Zone
* Player Effects 

* Ability to define HQ zone and dimension 
* Ability to define blacklist coords  
* Ability to define blacklist buildings 
* Ability to define AI spawn or not AI 
* Ability to use WAI or DZMS instead of AI included 
    (disabled in ALPHA - can enable WAI - or DZMS working but not remove units when 
     mission end for now)      
* and more...

AI included in mission are WAI inspired 
(all credits to F3cuk - https://github.com/f3cuk/WICKED-AI)



Installation Server

* UnPbo dayz_server.pbo with pbo manager  and copy inside dayz_server directory , downloaded folder HeartQuake  (MOD_HEARTHQUAKE\server\Heartquake)
* Open init\server_functions.sqf and in the bottom add  
     call compile preprocessFileLineNumbers "\z\addons\dayz_server\HearthQuake\starter.sqf";

* Open destroy.sqf and setup center coords and range of HearthQuake Zone, HQ can Happen    
* Random inside this zone, normally setup center of Map and Radius (half map length)
* Setup too coords of blacklist places and Buildings (if u want) and others settings.
* Open spawncrates_HQ.sqf if u want setup type and numbers of loot thst spawn in crate.
* Inside folder AI open ai_spawn.sqf if u want setup groups or numbers or other about AI.

* repack dayz_server folder with pbo manager  dayz_server.pbo

Installation Mission
o Open/unpbo mission folder and copy or merge if exist  downloaded Sounds folder and file
                HearthQuakeEffects.sqf
o Open description.ext and add or merge class CfgSounds (inside descripton.ext downloaded)
o Open init.sqf and add to the bottom  [] execVM ' hearthQuakeEffects.sqf';
o pack/close mission folder
o 
BE FILTERS
I dont use BE and the filters are not provided
certainly need to add to publicvariable.txt
!=" effectHQ"
