 /*
 coded by W4lly63
 */
 
 while {true} do
{
	waitUntil {
              effectHQ == 1;
    };
	
	
	if (effectHQ == 1) then {
	
	    
	
	    player  spawn {
			
			
				for "_i" from 0 to 15 do {
				
				    playsound "0334";
				
                    _vx = vectorUp _this select 0;
                    _vy = vectorUp _this select 1;
                    _vz = vectorUp _this select 2;
                    _coef = 0.01 - (0.0001 * _i);
                    _this setVectorUp [
                    _vx+(-_coef+random (2*_coef)),
                    _vy+(-_coef+random (2*_coef)),
                    _vz+(-_coef+random (2*_coef))
                    ];
                    sleep (0.3 + random 0.1);
	            };
				
			            
	    };
		
    };
	
	waitUntil {
              effectHQ == 0;
    };    			   
				
	
};