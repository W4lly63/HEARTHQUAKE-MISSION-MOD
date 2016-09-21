/*
	File: ai_spawn.sqf
	Author: W4lly63 - based to f3cuk/WICKED-AI spawn group  - all credits to f3cuk 
	Description: spawn AI groups inside zone
		
*/

if (isServer) then {
	
	private ["_hqCenter","_hqNumGroups","_min","_max","_mindist","_water","_shoremode","_pos","_numForGroup","_skillGroup","_numMagsMan","_mission","_aiweapon","_aigear","_aiskin","_aicskill","_aipack","_current_time","_unarmed","_weapon","_magazine","_gearmagazines","_geartools","_unit","_unitGroup","_backpack","_unitnumber","_nGroups"];
	
	///////////////////Settings/////////////////////////////////////////////////////
	
	_hqCenter                   = _this select 0;                        // HeartQuake center

	
    _min                        = 100; 											// minimum distance from the center position (Number) in meters
    _max                        = 800 ; 											//  maximum range of spawned hearthquake groups  
    _mindist                    = 1; 		// minimum distance from the nearest object (Number) in meters, ie. spawn at least this distance away from anything within x meters..
    _water                      = 0;			// water mode (Number)	0: cannot be in water , 1: can either be in water or not , 2: must be in water
    _shoremode                  = 0; 	// 0: does not have to be at a shore , 1: must be at a shore
    _numForGroup                = [2,3,4,5];   // 
	_skillGroup                 = ["easy","medium","hard","extreme","random"];
	_numMagsMan                 = [3,4,5,6];
	_nGroups                    = [6,7,8];  //if u change this need change createGroup block too
	_hqNumGroups                = _nGroups select floor random count _nGroups;    // numbers of AI groups spawn inside heartquake zone  
	
	ai_skill_extreme			= [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["endurance",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Extreme
	ai_skill_hard				= [["aimingAccuracy",0.80],["aimingShake",0.80],["aimingSpeed",0.80],["endurance",1.00],["spotDistance",0.80],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Hard
	ai_skill_medium				= [["aimingAccuracy",0.60],["aimingShake",0.60],["aimingSpeed",0.60],["endurance",1.00],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Medium
	ai_skill_easy				= [["aimingAccuracy",0.40],["aimingShake",0.50],["aimingSpeed",0.50],["endurance",1.00],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Easy
	ai_skill_random				= [ai_skill_extreme,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_easy];
	
	ai_wep_assault				= ["SVD_Gh_DZ","M107_DZ","M110_NVG_EP1","G36A_Camo_DZ","M4A1_HWS_GL_camo","SCAR_L_STD_HOLO","M4A3_CCO_EP1","M4A1_AIM_SD_camo","M16A4_ACOG_DZ","m8_carbine","BAF_L85A2_RIS_Holo","m8_sharpshooter"];	// Assault
	ai_wep_machine				= ["MK48_DZ","M249_DZ","Pecheneg_DZ","M240_DZ"];	// Light machine guns
	ai_wep_sniper				= ["SCAR_H_LNG_Sniper_SD","SVD_des_EP1","DMR_DZ","M40A3"];	// Sniper rifles
	ai_wep_random				= [ai_wep_assault,ai_wep_assault,ai_wep_assault,ai_wep_sniper,ai_wep_machine];	// random weapon 60% chance assault rifle,20% light machine gun,20% sniper rifle
	
	ai_gear0					= [["ItemBandage","ItemBandage","ItemAntibiotic"],["ItemRadio","ItemMachete","ItemCrowbar"]];
	ai_gear1					= [["ItemBandage","ItemSodaPepsi","ItemMorphine"],["Binocular_Vector"]];
	ai_gear2					= [["ItemDocument","FoodCanFrankBeans","ItemHeatPack"],["ItemToolbox"]];
	ai_gear3					= [["ItemWaterbottle","ItemBloodbag"],["ItemCompass","ItemCrowbar"]];
	ai_gear4					= [["ItemBandage","ItemEpinephrine","ItemPainkiller"],["ItemGPS","ItemKeyKit"]];
	ai_gear_random				= [ai_gear0,ai_gear1,ai_gear2,ai_gear3,ai_gear4];	// Allows the possibility of random gear
	
	ai_hero_skin				= ["FR_AC","FR_AR","FR_Corpsman","FR_GL","FR_Marksman","FR_R","FR_Sapper","FR_TL"];
	ai_bandit_skin				= ["Ins_Soldier_GL_DZ","TK_INS_Soldier_EP1_DZ","TK_INS_Warlord_EP1_DZ","GUE_Commander_DZ","GUE_Soldier_Sniper_DZ","GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_2_DZ","GUE_Soldier_CO_DZ","BanditW1_DZ","BanditW2_DZ","Bandit1_DZ","Bandit2_DZ"];
	ai_special_skin				= ["Functionary1_EP1_DZ"];
	ai_all_skin					= [ai_hero_skin,ai_bandit_skin,ai_special_skin];
		
	ai_packs					= ["DZ_Czech_Vest_Puch","DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_GunBag_EP1","DZ_CivilBackpack_EP1","DZ_Backpack_EP1","DZ_LargeGunBag_EP1"];
	
	ai_ground_units_hq			= 0;
	ai_add_humanity_hq		    = 50;			// amount of humanity gained for killing a bandit AI	
	ai_add_skin_hq				= true;	
	ai_kills_gain_hq			= true;			// add kill to bandit/human kill score
	ai_humanity_gain_hq			= true;			// gain humanity for killing AI
    ai_clear_body_hq 			= false;		// instantly clear bodies	
	ai_share_info_hq			= true;			// AI share info on player position
	ai_share_distance_hq		= 300;			// distance from killed AI for AI to share your rough position
	ai_clean_dead 				= false;			// clear bodies after certain amount of time
	ai_cleanup_time 			= 7200;			// time to clear bodies in seconds
	ai_clean_roadkill			= false; 		// clean bodies that are roadkills
	ai_roadkill_damageweapon_hq	= 0;			// percentage of chance a roadkill will destroy weapon AI is carrying
	ai_bandit_combatmode_hq		= "RED";		// combatmode of bandit AI
	ai_bandit_behaviour_hq		= "COMBAT";		// behaviour of bandit AI
	
			/* AI Cache Units */
		ai_cache_units_hq			= false;
		/**Range for Re-Activation*************/
		/****** Default: 800 ******************/
		ai_cache_units_reactivation_range_hq = 800;
		/**Time untill units are Frozen again**/
		/************* Default: 30 ************/
		ai_cache_units_refreeze_hq = 30;
		/****** Log Actions to RPT File? ******/
		/*********** Default: true ************/
		ai_cache_units_freeze_log_hq = true;
		/******** Unassign Waypoints?  ********/
		/*********** Default: false ***********/
		ai_cache_units_unassign_waypoints_hq = false;
		/******** Randomize Position?  ********/
		/******** Distance to Randomize *******/
		/*********** Default: true ************/
		/*********** Distance: 20 *************/
		ai_cache_units_randomize_position_hq = true;
		ai_cache_units_randomize_distance_hq = 20;
		/********** Hide un-used AI?  *********/
		/*********** Default: true ************/
		ai_cache_unites_hide_ai_hq = true;
		/* AI Cache Units End */
	
	//////////////////////Groups////////////////////////////////////////////
	
	private ["_unitGroup1","_unitGroup2","_unitGroup3","_unitGroup4","_unitGroup5","_unitGroup6","_unitGroup7","_unitGroup8","_unitGroupHQ","_unitGroupSel"];
	
	_unitGroup1	= createGroup RESISTANCE;
	_unitGroup2	= createGroup RESISTANCE;
	_unitGroup3	= createGroup RESISTANCE;
	_unitGroup4	= createGroup RESISTANCE;
	_unitGroup5	= createGroup RESISTANCE;
	_unitGroup6	= createGroup RESISTANCE;
	_unitGroup7	= createGroup RESISTANCE;
	_unitGroup8	= createGroup RESISTANCE;
	
	_unitGroupHQ =[_unitGroup1,_unitGroup2,_unitGroup3,_unitGroup4,_unitGroup5,_unitGroup6,_unitGroup7,_unitGroup8];
	endMissionRemoveGroup = _unitGroupHQ;
	//////////////////////////////////////////////////////////////////////////////

	
	for "_i" from 0 to (_hqNumGroups -1) do {
	
	    _pos = [_hqCenter,_min,_max,_mindist,_water,2000,_shoremode] call BIS_fnc_findSafePos; // spawn group position
		_pos_x 			     = _pos select 0;
	    _pos_y 			     = _pos select 1;
	    _pos_z 			     = 0;
	    _unitnumber 		= _numForGroup select floor random count _numForGroup;  //num x group
	    _skill 				= _skillGroup select floor random count _skillGroup;  //skill x group
	    _gun 				= "Random";
	    _mags 				= _numMagsMan select floor random count _numMagsMan;  //mags x group
	    _backpack 			= "Random";
	    _skin 				= "bandit";
	    _gear 				= "Random";
	    _aitype				= "bandit";
		
		_mission = nil;
		
		_aiweapon 			= [];
	    _aigear 			= [];
	    _aiskin 			= "";
	    _aicskill 			= [];
	    _aipack 			= "";
	    _current_time		= time;
	    _unarmed			= false;
		
		//_unitGroup	= createGroup RESISTANCE;
		_unitGroupSel = _unitGroupHQ select _i;
		
		if(_pos_z == 0) then {
		    if(floor(random 2) == 1) then { 
			    _pos_x = _pos_x - (5 + random(25));
		    } else {
			_pos_x = _pos_x + (5 + random(25));
		    };			

		    if(floor(random 2) == 1) then { 
			    _pos_y = _pos_y - (5 + random(25));
		    } else {
			_pos_y = _pos_y + (5 + random(25));
		    };
	    };
		
			for "_x" from 1 to _unitnumber do {
			
			    call {					
					if(_gun == "Random") 	exitWith { _aiweapon = ai_wep_random call BIS_fnc_selectRandom; };
				    if(_gun == "unarmed") 	exitWith { _unarmed = true; };
				    _weapon = _gun;					
				};
				
				if (!_unarmed) then {
			        _weapon 	= _aiweapon call BIS_fnc_selectRandom;
			        _magazine 	= _weapon 	call find_suitable_ammunition;
		        };
				
				call {				
				    if(_gear == "Random") 	exitWith { _aigear = ai_gear_random call BIS_fnc_selectRandom; };				
				};
				
				_gearmagazines 	= _aigear select 0;
		        _geartools 		= _aigear select 1;
				
				call {				
			        if(_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin 	call BIS_fnc_selectRandom; };
			        _aiskin = _skin;
		        };
				
				_unit = _unitGroupSel createUnit [_aiskin,[_pos_x,_pos_y,_pos_z],[],0,"CAN COLLIDE"];
		        [_unit] joinSilent _unitGroupSel;
			   
			    call {
			        if(_aitype == "bandit") 	exitWith { _unit setVariable ["Bandit",true]; _unit setVariable ["humanity", ai_add_humanity_hq]; };
		        };
			   
			    if (!isNil "_gain") then { _unit setVariable ["humanity", _gain]; };
			   
			    call {
			        if(_backpack == "Random") 	exitWith { _aipack = ai_packs call BIS_fnc_selectRandom; };
			        _aipack = _backpack;
		        };
				
				if (isNil "_mission") then {
		
			        _unit enableAI "TARGET";
			        _unit enableAI "AUTOTARGET";
			        _unit enableAI "MOVE";
			        _unit enableAI "ANIM";
			        _unit enableAI "FSM";
		
		        };
				
				removeAllWeapons _unit;
		        removeAllItems _unit;

		        if (sunOrMoon != 1) then {
			        _unit addweapon "NVGoggles";
		        };

		        if (!_unarmed) then {
			        for "_k" from 1 to _mags do {
				        _unit addMagazine _magazine;
			        };
			    _unit addweapon _weapon;
			    _unit selectWeapon _weapon;
		        };

		        if(_backpack != "none") then {
			       _unit addBackpack _aipack;
		        };

		        {
			       _unit addMagazine _x
		        } count _gearmagazines;

		        {
			       _unit addweapon _x
		        } count _geartools;
				
				call {
			       if(_skill == "easy") 		exitWith { _aicskill = ai_skill_easy; };
			       if(_skill == "medium") 		exitWith { _aicskill = ai_skill_medium; };
			       if(_skill == "hard") 		exitWith { _aicskill = ai_skill_hard; };
			       if(_skill == "extreme") 	exitWith { _aicskill = ai_skill_extreme; };
			       if(_skill == "random") 		exitWith { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
			       _aicskill = ai_skill_random call BIS_fnc_selectRandom;
		        };
				
				{
			       _unit setSkill [(_x select 0),(_x select 1)]
		        } count _aicskill;
		
		        ai_ground_units_hq = (ai_ground_units_hq + 1);

		        _unit addEventHandler ["Killed",{[_pos, _unitnumber, "ground"] call on_kill_hq;}];
				
			};
			
			_unitGroupSel setFormation "ECH LEFT";
	        _unitGroupSel selectLeader ((units _unitGroupSel) select 0);
			_unitGroupSel setCombatMode ai_bandit_combatmode_hq;
			_unitGroupSel setBehaviour ai_bandit_behaviour_hq;
			
			if(_pos_z == 0) then {
		       [_unitGroupSel,[_pos_x,_pos_y,_pos_z],_skill] spawn group_waypoints_hq;
	        };
	        if(ai_cache_units) then {
		       [_unitGroupSel] spawn cache_units_hq;
	        };
			//endMissionRemoveGroup = endMissionRemoveGroup + _unitGroupSel;
	        diag_log format ["HearthQuake: Spawned a group of %1 AI (%3) at %2",_unitnumber,_pos,_aitype];
	
	        _unitGroupSel
	};
};