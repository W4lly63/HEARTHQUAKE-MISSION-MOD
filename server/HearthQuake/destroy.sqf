/*
	File: destroy.sqf
	Author: W4lly63
	Description: destroy randomly buildings places. spawn loots
		
*/

     if (isNil "effectHQ") then {
           effectHQ = 0;
	       publicVariable "effectHQ";
    };
	 
    ///////////////settings ///////////////////////////
	
	private ["_markersize","_markersize2","_firstHQ","_nextHQ","_noDamage_array","_min","_max","_mindist","_water","_shoremode","_marker","_aiTypeOnOff","_aiWAI_numGroups","_posWAI","_numForGroupWAI","_unitnumber","_skillGroup","_skill","_numForGroup"];

    spawnCenter_HQ     = [6900,8475.45,0]; 	// coords map center
   _min                = 1; 											// minimum distance from the center position (Number) in meters
   _max                = 6000 ; 											//  maximum range of spawned hearthquake  (half of map )
   _blackListArray     =[];       // insert here coords of blacklist places or leave blank  example _blackListArray  =[[1520,8700,0],[9245,11267,0]];  
   _mindist            = 1; 		// minimum distance from the nearest object (Number) in meters, ie. spawn at least this distance away from anything within x meters..
   _water              = 0;			// water mode (Number)	0: cannot be in water , 1: can either be in water or not , 2: must be in water
   _shoremode          = 0; 	// 0: does not have to be at a shore , 1: must be at a shore
   _marker             = true; 	// Draw  circle inside map
   _markersize         = 1000; // Radius of the marker in meters
   _markersize2        = 55; // Radius of the marker in meters
   _firstHQ            = 200;  // start first HQ sec.
   _nextHQ             = 3600;   // start next HQ sec.
   _noDamage_array     =["Land_A_Villa_EP1"];  // array of buildings dont want destroy
   
   _aiTypeOnOff        = 3; // AI used On Off Type ---- 0 = AI off ; 1 = WAI AI (server have WAI); 2 = DZMS AI (server have DZMS) ; 3 = AI Integrated in mission( based on WAI no need other server installations) 
                            // IMPORTANT!!!!     FOR NOW WORKING ONLY  3 - INTEGRATED AI WAI BASED   -----TODO WAI and DZMS NEED TO COMPLETE REMOVE AI WHEN MISSION END
							
   _aiWAI_numGroups    = 6; // AI WAI number of groups spawn
   _numForGroupWAI     = [2,3,4,5];   //
   _numForGroup        = [2,3,4,5];   //


   //////////////////////////////////////////////////
   
   
   QuakeTimeout_HQ = (diag_tickTime + _firstHQ);
   
    while {true} do {
	   
	    if (diag_tickTime > QuakeTimeout_HQ ) then {
   
            effectHQ = 1;
	        publicVariable "effectHQ";
            diag_log format['Start HearthQuake : %1',diag_tickTime];
            _pos = [spawnCenter_HQ,_min,_max,_mindist,_water,2000,_shoremode,_blackListArray] call BIS_fnc_findSafePos;
            [_pos, 1000, 42, [_noDamage_array]] call bis_fnc_destroyCity;
	        spawnBoxCenterHQ = _pos;
	        diag_log format['HearthQuake : %1',_pos];
	        uiSleep 15;
	        effectHQ = 0;
	        publicVariable "effectHQ";
			nextHQ = _nextHQ;
	        nul = [spawnBoxCenterHQ,nextHQ] execVM "\z\addons\dayz_server\HearthQuake\spawncrates_HQ.sqf";
			
			/////////////////OTHER AI CODE - INCOMPLETE//////////////
			/*if (_aiTypeOnOff == 1) then {
			      	for "_i" from 1 to _aiWAI_numGroups do {
					    _posWAI = [spawnBoxCenterHQ,100,800,_mindist,_water,2000,_shoremode] call BIS_fnc_findSafePos;
					    _unitnumber 		= _numForGroup select floor random count _numForGroup;  //num x group
					    _skillGroup      = ["easy","medium","hard","extreme","random"];
					    _skill 	        = _skillGroup select floor random count _skillGroup;  //skill x group
		                [[_posWAI select 0,_posWAI select 1,0],_unitnumber,_skill,"Random",4,"Random","Bandit","Random","Bandit"] call spawn_group;
	                };
			};
            if (_aiTypeOnOff == 2) then {
			    for "_i" from 1 to _aiWAI_numGroups do {
			        _posWAI = [spawnBoxCenterHQ,100,800,_mindist,_water,2000,_shoremode] call BIS_fnc_findSafePos;
				    _unitnumber 		= _numForGroup select floor random count _numForGroup;  //num x group
				    _skillGroup      = ["easy","medium","hard","extreme","random"];
				    _skill 	        = _skillGroup select floor random count _skillGroup;  //skill x group
			         nul = [[_posWAI select 0,_posWAI select 1,0],_unitnumber,_skill] execVM "\z\addons\dayz_server\DZMS\Scripts\DZMSAISpawn.sqf";
				};
			};*/
			//////////////////////////////////////////////////////
			
			if (_aiTypeOnOff == 3) then {
			      nul = [spawnBoxCenterHQ] execVM "\z\addons\dayz_server\HearthQuake\AI\ai_spawn.sqf";
			};
			
			
		    if (_marker) then {
				
				
					
					deleteMarker "hq_marker_1";
					deleteMarker "hq_marker_2";
					
				
				
	            _event_marker = createMarker [ format ["hq_marker_%1", 1], _pos];
		        _event_marker setMarkerShape "ELLIPSE";
		        _event_marker setMarkerColor "ColorKhaki";
		        _event_marker setMarkerAlpha 0.75;
		        _event_marker setMarkerSize [(_markersize+15), (_markersize+15)]; 							
		        _pos = [_pos,0,_markersize,0,_water,2000,_shoremode] call BIS_fnc_findSafePos; 	 			//find a random spot INSIDE the marker area
		        _pos = [_pos select 0, _pos select 1, 0];
				
				_event_marker2 = createMarker [ format ["hq_marker_%1", 2], _pos];
		        _event_marker2 setMarkerColor "ColorBlack";
		        _event_marker2 setMarkerType "Vehicle";
                _event_marker2 setMarkerText "HearthQuake Zone";						
		        _pos = [_pos,0,_markersize2,0,_water,2000,_shoremode] call BIS_fnc_findSafePos; 	 			//find a random spot INSIDE the marker area
		        _pos = [_pos select 0, _pos select 1, 0];
		
	        };

            QuakeTimeout_HQ = (diag_tickTime + _nextHQ);
            			
			uiSleep 20;
			
	    };
   
        
	   
	   
   }
