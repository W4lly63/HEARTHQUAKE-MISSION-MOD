if(isServer) then {
   
   nul = [] execVM  "\z\addons\dayz_server\HearthQuake\destroy.sqf";
   group_waypoints_hq		= compile preprocessFileLineNumbers "\z\addons\dayz_server\HearthQuake\AI\group_waypoints_hq.sqf";
   on_kill_hq		= compile preprocessFileLineNumbers "\z\addons\dayz_server\HearthQuake\AI\on_kill_hq.sqf";
   cache_units_hq		= compile preprocessFileLineNumbers "\z\addons\dayz_server\HearthQuake\AI\cache_units_hq.sqf";

};