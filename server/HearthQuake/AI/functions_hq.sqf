find_suitable_ammunition_hq = {

	private["_weapon","_result","_ammoArray"];

	_result 	= false;
	_weapon 	= _this;
	_ammoArray 	= getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");

	if (count _ammoArray > 0) then {
		_result = _ammoArray select 0;
		call {
			if(_result == "20Rnd_556x45_Stanag") 	exitWith { _result = "30Rnd_556x45_Stanag"; };
			if(_result == "30Rnd_556x45_G36") 		exitWith { _result = "30Rnd_556x45_Stanag"; };
			if(_result == "30Rnd_556x45_G36SD") 	exitWith { _result = "30Rnd_556x45_StanagSD"; };
		};
	};

	_result

};



