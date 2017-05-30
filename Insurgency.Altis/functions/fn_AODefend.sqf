/*
@file: QS_fnc_AOenemy.sqf
Author:

	Quiksilver (credits: Ahoyworld.co.uk. Rarek et al for AW_fnc_spawnUnits.)
	
Last modified:

		24/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	AO enemies
__________________________________________________________________*/

//---------- CONFIG
#define AIR_TYPE "O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","I_Heli_light_03_F","O_Heli_Light_02_F"

private ["_enemiesArray","_randomPos","_patrolGroup","_AOvehGroup","_AOveh","_AOmrapGroup","_AOmrap","_mpos","_spawnPos","_overwatchGroup","_x","_staticGroup","_static","_aaGroup","_aa","_airGroup","_air","_sniperGroup","_staticDir","_Placement","_size"];
//
_mpos = getMarkerPos "aoCircle_2";
_sizeM = getMarkerSize "aoCircle_2"; 
_size = (_sizeM select 0);
_centerX = _mpos select 0;
_centerY = _mpos select 1;
_enemiesArray = [grpNull];
_x = 0;
//---------- INFANTRY PATROLS RANDOM
for "_x" from 1 to 3 do {
	_patrolGroup = createGroup east;
	_randomPos = ["aoCircle_2",0,[],[],200] SHK_pos_getPosMarker;	
	
	//_randomPos = [[[_mpos, _size],[]],["water"]] call BIS_fnc_randomPos;
	//
	_unit = _patrolGroup createUnit ["O_Soldier_TL_F", _randomPos, [], 0.5, "FORM"]; 
	
	for "_y" from 1 to 3 do {					
			_unit = _patrolGroup createUnit ["O_soldierU_AA_F", _randomPos, [], 0.5, "FORM"];  
		};
	for "_y" from 1 to 3 do {					
			_unit = _patrolGroup createUnit ["O_soldierU_AT_F", _randomPos, [], 0.5, "FORM"];  
		};
	for "_y" from 1 to 2 do {					
			_unit = _patrolGroup createUnit ["O_soldierU_medic_F", _randomPos, [], 0.5, "FORM"];  
		};
	for "_y" from 1 to 2 do {					
			_unit = _patrolGroup createUnit ["O_recon_M_F", _randomPos, [], 0.5, "FORM"];  
		};
	for "_y" from 1 to 2 do {					
			_unit = _patrolGroup createUnit ["O_Soldier_AR_F", _randomPos, [], 0.5, "FORM"];  
		};
	for "_y" from 1 to 5 do {					
			_unit = _patrolGroup createUnit ["O_soldierU_F", _randomPos, [], 0.5, "FORM"];  
		};

	_gMarker = _patrolGroup addWaypoint [_mPos, 0];
	_gMarker setWaypointType "SAD";
	_gMarker setWaypointSpeed "NORMAL";
	_gMarker setWaypointBehaviour "AWARE"; 
	_gMarker setWaypointFormation "NO CHANGE";

	[(units _patrolGroup)] call QS_fnc_setSkill1;
	
	_enemiesArray = _enemiesArray + [_patrolGroup];

	{
		_x addCuratorEditableObjects [units _patrolGroup, false];
	} foreach adminCurators;

};

//---------- HELICOPTER	
_nrbmax = 1 + random 1;
for "_x" from 1 to _nbrmax do {
	
	_airGroup = createGroup east;
	_randomPos = ["aoCircle_2",1,[],[],300] SHK_pos_getPosMarker;	
	_air = [AIR_TYPE] call BIS_fnc_selectRandom createVehicle [_randomPos select 0,_randomPos select 1,1000];
	waitUntil{!isNull _air};
	_air engineOn true;
	_air setPos [_randomPos select 0,_randomPos select 1,300];

	_air spawn
	{
		private["_x"];
		for [{_x=0},{_x<=200},{_x=_x+1}] do
		{
			_this setVelocity [0,0,0];
			sleep 0.1;
		};
	};

		"O_helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 0) assignAsDriver _air;
		((units _airGroup) select 0) moveInDriver _air;
		"O_helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 1) assignAsGunner _air;
		((units _airGroup) select 1) moveInGunner _air;

	[_airGroup, _mpos, 800] call BIS_fnc_taskPatrol;
	[(units _airGroup)] call QS_fnc_setSkill2;
	_air flyInHeight 300;
	_airGroup setCombatMode "RED";
	_air lock 3;
		
	_enemiesArray = _enemiesArray + [_airGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_air];

	{
		_x addCuratorEditableObjects [[_air], false];
		_x addCuratorEditableObjects [units _airGroup, false];
	} foreach adminCurators;
};
	
_enemiesArray;
