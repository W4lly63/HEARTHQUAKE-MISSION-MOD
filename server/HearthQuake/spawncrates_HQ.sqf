/*
	File: spawncrates.sqf
	Author:  W4lly63	
*/
if (isServer) then {

private ["_tool","_crate","_weapon","_item","_backpack","_num_tools","_num_items","_num_backpacks","_num_weapons","_num_ammo","_num_skins","_crate_typeHQ","_numberofcrates","_box","_box_now"];



//-----------------settings----------------------------

_numberofcrates = 1;								// this is the number of crates that you want to spawn								
_min = 10; 											// minimum distance from the center position (Number) in meters
_max = 900 ; 											// Example : maximum range of spawned crates, to keep them INSIDE the sector B compound

_mindist = 2; 		// minimum distance from the nearest object (Number) in meters, ie. spawn at least this distance away from anything within x meters..
_water = 0;			// water mode (Number)	0: cannot be in water , 1: can either be in water or not , 2: must be in water
_shoremode = 0; 	// 0: does not have to be at a shore , 1: must be at a shore
_marker = false; 	// Draw a green circle in which the crate will be spawned randomly
_markersize = 5; 	// Radius of the marker in meters

_num_tools  = 8;
_num_items = 30;
_num_backpacks = 4;
_num_ammo = 30;
_num_weapons = 15;
_num_skins = 5;
_crate_typeHQ ="TKVehicleBox_EP1";

//--------------------------------------------------------------

spawnCenter_HQ = _this select 0; 	// coords center where spawn crates
box_arrayHQ  = [];
nextH_Q = _this select 1;
crate_typeHQ = _crate_typeHQ;

  diag_log format['Start spawnCrates HearthQuake : %1',diag_tickTime];

  for "_i" from 1 to _numberofcrates do
  {
	_pos = [spawnCenter_HQ,_min,_max,_mindist,_water,2000,_shoremode] call BIS_fnc_findSafePos; 		// find a random location within range

	if (_marker) then {
	    _event_marker = createMarker [ format ["loot_marker_%1", _i], _pos];
		_event_marker setMarkerShape "ELLIPSE";
		_event_marker setMarkerColor "ColorGreen";
		_event_marker setMarkerAlpha 0.75;
		_event_marker setMarkerSize [(_markersize+15), (_markersize+15)]; 							//green circle slightly bigger , box can spawn just outside if not increased
		_pos = [_pos,0,_markersize,0,_water,2000,_shoremode] call BIS_fnc_findSafePos; 	 			//find a random spot INSIDE the marker area
		_pos = [_pos select 0, _pos select 1, 0];
		
	};
	
		/*crates     				    = ["USVehicleBox","RUVehicleBox","TKVehicleBox_EP1",
		                               "USBasicWeaponsBox","RUBasicWeaponsBox","USSpecialWeaponsBox","USSpecialWeapons_EP1","RUSpecialWeaponsBox","SpecialWeaponsBox","TKSpecialWeapons_EP1","CZBasicWeapons_EP1","UNBasicWeapons_EP1",
		                               "GuerillaCacheBox","RULaunchersBox","RUBasicAmmunitionBox","RUOrdnanceBox","USBasicAmmunitionBox","USLaunchersBox","USOrdnanceBox","USOrdnanceBox_EP1","USLaunchers_EP1","USBasicWeapons_EP1","USBasicAmmunitionBox_EP1","UNBasicAmmunitionBox_EP1",
									   "TKOrdnanceBox_EP1","TKLaunchers_EP1","TKBasicAmmunitionBox_EP1","GuerillaCacheBox_EP1","GERBasicWeapons_EP1"];

	
	    _crate = crates call BIS_fnc_selectRandom;*/

	diag_log format['HearthQuake Spawncrate %1 : Location %2',_i,_pos];
	_box = _crate_typeHQ createvehicle _pos;  				                              //create the crate  
	clearMagazineCargoGlobal _box;
	clearWeaponCargoGlobal _box;
    clearBackpackCargoGlobal _box;
	_box setVariable ["permaLoot",true];							                              //stay until reset
	_box allowDamage false;											                              // Prevent boxes to explode when spawning
	
//-----------------------------------------------------------------------------

//////////////////////////////-----LOOTS---------------------------------------


		
		crate_tools					= ["ItemKeyKit","Binocular","Binocular_Vector","ItemCompass","ItemCrowbar","ItemEtool","ItemFishingPole","ItemFlashlightRed","ItemGPS","ItemHatchet","ItemKnife","ItemMachete","ItemMatchbox","ItemToolbox","NVGoggles"];

		crate_items					= ["FoodNutmix","FoodPistachio","FoodMRE","ItemSodaOrangeSherbet","ItemSodaRbull","ItemSodaR4z0r","ItemSodaMdew","ItemSodaPepsi","ItemBandage","ItemSodaCoke","FoodCanBakedBeans","FoodCanFrankBeans","FoodCanPasta","FoodCanSardines",
		                               "ItemAntibiotic","ItemBloodbag","ItemEpinephrine","ItemHeatPack","ItemMorphine","ItemGoldBar","ItemGoldBar10oz","CinderBlocks","ItemCanvas","ItemComboLock","ItemLightBulb",
									   "ItemLockbox","ItemSandbag","ItemTankTrap","ItemWire","MortarBucket","PartEngine","PartFueltank","PartGeneric","PartGlass","PartPlankPack","PartVRotor","PartWheel","PartWoodPile",
		                               "ItemBriefcase100oz","ItemVault","30m_plot_kit","ItemHotwireKit",
		                               "ItemWaterbottle","FoodNutmix","FoodPistachio","FoodMRE","ItemSodaOrangeSherbet","ItemSodaRbull","ItemSodaR4z0r","ItemSodaMdew","ItemSodaPepsi","ItemSodaCoke","FoodCanBakedBeans","FoodCanFrankBeans","FoodCanPasta",

		                               "forest_large_net_kit","cinder_garage_kit","PartPlywoodPack","ItemSandbagExLarge5X","park_bench_kit","ItemComboLock","CinderBlocks","ItemCanvas","ItemComboLock","ItemLightBulb","ItemLockbox","ItemSandbag","ItemTankTrap","ItemWire","MortarBucket","PartPlankPack","PartWoodPile",
		                               "PartEngine","PartFueltank","PartGeneric","PartGlass","PartVRotor","PartWheel",



		                               "ItemWaterbottle","ItemAntibiotic","ItemBloodbag","ItemEpinephrine","ItemHeatPack","ItemMorphine","ItemBandage","FoodCanFrankBeans","FoodCanPasta",		                               
		                               "ItemPainkiller",
		                               "ItemDocument","ItemGoldBar10oz"];

		crate_backpacks      		= ["DZ_Patrol_Pack_EP1","DZ_Assault_Pack_EP1","DZ_Czech_Vest_Puch","DZ_TerminalPack_EP1","DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_CompactPack_EP1","DZ_British_ACU","DZ_GunBag_EP1","DZ_CivilBackpack_EP1","DZ_Backpack_EP1","DZ_LargeGunBag_EP1"];

		
		
		crate_ammo                  = ["50Rnd_762x54_UK59","200Rnd_556x45_M249","100Rnd_762x51_M240","100Rnd_762x54_PK","30Rnd_556x45_StanagSD","10Rnd_762x54_SVD","10Rnd_127x99_m107","20Rnd_762x51_DMR","5Rnd_127x108_KSVK","5Rnd_86x70_L115A1","HandGrenade_West","30Rnd_556x45_Stanag","2000Rnd_762x51_M134","200Rnd_762x51_M240","100Rnd_127x99_M2","150Rnd_127x107_DSHKM"];
		
		crate_weapons				= ["SVD_Gh_DZ","M107_DZ","M110_NVG_EP1","G36A_Camo_DZ","M4A1_HWS_GL_camo","SCAR_L_STD_HOLO","M4A3_CCO_EP1","M4A1_AIM_SD_camo","M16A4_ACOG_DZ","m8_carbine","L85_Holo_DZ","m8_sharpshooter",
		                               "MK48_DZ","M249_DZ","Pecheneg_DZ","M240_DZ",
		                               "SCAR_H_LNG_Sniper_SD","SVD_des_EP1","DMR_DZ","M40A3_DZ","ChainSaw","ChainSawB","ChainSawG","ChainSawP","ChainSawR"];	
		
		crate_skin				    = ["Skin_Ins_Soldier_GL_DZ","Skin_TK_INS_Soldier_EP1_DZ","Skin_TK_INS_Warlord_EP1_DZ","Skin_GUE_Commander_DZ","Skin_GUE_Soldier_Sniper_DZ","Skin_GUE_Soldier_MG_DZ","Skin_GUE_Soldier_Crew_DZ","Skin_GUE_Soldier_2_DZ","Skin_GUE_Soldier_CO_DZ","Skin_BanditW1_DZ","Skin_BanditW2_DZ","Skin_Bandit1_DZ","Skin_Bandit2_DZ","Skin_Sniper1_DZ","Skin_CZ_Soldier_Sniper_EP1_DZ","Skin_GUE_Soldier_Sniper_DZ"];

        

/////////////////////////////---------------------------------------------------

//////////////////add items to crate///////////////////////////////////////////

    for "_i" from 1 to _num_tools do {
		_tool = crate_tools call BIS_fnc_selectRandom;
			_box addWeaponCargoGlobal [_tool,1];
	};
	
	for "_i" from 1 to _num_items do {
		_item = crate_items call BIS_fnc_selectRandom;
			_box addMagazineCargoGlobal [_item,1];
	};
	
	for "_i" from 1 to _num_backpacks do {
		_item = crate_backpacks call BIS_fnc_selectRandom;
			_box addBackpackCargoGlobal [_item,1];
	};
	
	for "_i" from 1 to _num_ammo do {
		_item = crate_ammo call BIS_fnc_selectRandom;
			_box addMagazineCargoGlobal [_item,1];
	};
	
	for "_i" from 1 to _num_weapons do {
		_item = crate_weapons call BIS_fnc_selectRandom;
			_box addWeaponCargoGlobal [_item,1];
	};
	
	for "_i" from 1 to _num_skins do {
		_item = crate_skin call BIS_fnc_selectRandom;
			_box addMagazineCargoGlobal [_item,1];
	};


	//----------------------------------------------------------------------------------
	_box_now =[_box];
	box_arrayHQ = box_arrayHQ + _box_now;
    };
	
   
};

nul = [box_arrayHQ,spawnCenter_HQ,nextH_Q,crate_typeHQ] execVM "\z\addons\dayz_server\HearthQuake\clean_replace_HQ.sqf";

	
	


