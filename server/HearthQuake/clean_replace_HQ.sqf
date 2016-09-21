// code by W4lly63
  
   	private ["_crateNext","_box","_max","_crateFound","_list","_crateTimedOut"];	
   
   box_arrayHQ = _this select 0;
   spawnCenterHQ = _this select 1; 
   _crateNext = _this select 2;
   _box = _this select 3;;  
   _max = 1200;

//Waits until player gets near  crates to end mission 
    
	CrateTimeoutHQ = (diag_tickTime + _crateNext);
	_crateFound = false;
	_crateTimedOut = false;
	while {true} do {
	    if (_crateFound ) then{
		    CrateTimeoutHQ = (diag_tickTime + 600);
			_crateFound = false;
		};
		if (diag_tickTime  > CrateTimeoutHQ) then {
		    _list = spawnCenterHQ  nearObjects [_box,_max];
            _numbCrates = (count _list) ;
		     diag_log format['HearthQuake Start Delete crates : %1 ',_numbCrates];
			_crateTimedOut = true;			
			{deleteVehicle _x} forEach _list;
			
			for "_j" from 0 to ((count endMissionRemoveGroup) -1) do {
			    {deleteVehicle _x} foreach (units (endMissionRemoveGroup select _j))			
			};
			
		};
		uiSleep 15;
		_list = spawnCenterHQ  nearObjects [_box,_max];
		for "_i" from 0 to ((count _list) -1) do {
		    if ({isPlayer _x && _x distance (box_arrayHQ select _i)< 10} count playableUnits > 0) then {
			    _crateFound = true;
		    };
		};
		if (_crateTimedOut) exitWith {};
		//uiSleep 15;
	};
	
	

