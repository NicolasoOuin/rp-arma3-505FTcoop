/*
Author: 

	Quiksilver

Last modified: 

	2/05/2014

Description:

	Central Theater
	
Notes:
	
	
______________________________________________*/

#define AIR_TYPE "O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","I_Heli_light_03_F","O_Heli_Light_02_F"
#define MRAP_TYPE "O_MRAP_02_F","O_G_Offroad_01_armed_F"

private ["_target1","_target2","_target3","_targetArray","_pos","_i","_position","_flatPos","_roughPos","_targetStartText","_targets","_targetsLeft","_dt","_enemiesArray","_unitsArray","_radioTowerDownText","_targetCompleteText","_regionCompleteText","_null","_mines","_chance"];

if(random 1 >= 0.35) then {

_mpos = getMarkerPos "aoCircle_2";
_sizeM = getMarkerSize "aoCircle_2"; 
_size = (_sizeM select 0); 
_centerX = _mpos select 0;
_centerY = _mpos select 1;
_enemiesArray = [grpNull];
_x = 0;

eastSide = createCenter east;
	
	_defendMessages = [
		"OPFOR Forces incoming! Seek cover immediately and defend the objective area!",
		"The enemy managed to call in reinforcements! Form a perimeter around the objective area!"
	];
	_targetStartText = format [
		"<t align='center' size='2.2'>Defend Target</t><br/><t size='1.5' align='center' color='#0d4e8f'>%1</t><br/>____________________<br/>We have a problem. The enemy managed to call in land reinforcements. They are on the way to take back the last target. You need to defend it at all cost!",
		currentAO
	];

	GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewMainDefend", currentAO]; publicVariable "showNotification";

	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle_2","aoMarker_2"];
	"aoMarker_2" setMarkerText format["Defend %1",currentAO];

	sleep 3;
	publicVariable "currentAO";
	currentAOUp = true; publicVariable "currentAOUp";
	radioTowerAlive = false; publicVariable "radioTowerAlive";

	_playersOnlineHint = format [
		"<t size='1.5' align='left' color='#C92626'>Enemy attacking %1!</t><br/><br/>____________________<br/>Get ready boys they are almost here!", currentAO
	];

	
	GlobalHint = _playersOnlineHint; publicVariable "GlobalHint"; hint parseText GlobalHint;

	sleep 3;

	hqSideChat = _defendMessages call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
//	sleep 3;

	//------------------------------------------ Create AO detection trigger
	_dt = createTrigger ["EmptyDetector", getMarkerPos "aoCircle_2"];
	_dt setTriggerArea [PARAMS_AOSize, PARAMS_AOSize, 0, false];
	_dt setTriggerActivation ["EAST", "PRESENT", false];
	_dt setTriggerStatements ["this","",""];

	//------------------------------------------ Spawn enemies
	sleep 1;	
	//_enemiesArray = [] call QS_fnc_AODefend;
//	
//---------- INFANTRY PATROLS RANDOM
for "_x" from 1 to 3 do {
	_patrolGroup = createGroup east;
	_randomPos = ["aoCircle_2",0,[],[],630] call SHK_pos_getPosMarker;	
	//
	_unit = _patrolGroup createUnit ["O_Soldier_TL_F", _randomPos, [], 0.5, "FORM"]; 
	
	_unit = _patrolGroup createUnit ["O_soldierU_AA_F", _randomPos, [], 0.5, "FORM"];  
	for "_y" from 1 to 2 do {					
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
//
	_gMarker = _patrolGroup addWaypoint [getMarkerPos "aoCircle_2", 0];
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
_Nbmax = 1 + random 1;
for "_x" from 1 to _nbmax do {
	
	_airGroup = createGroup east;
	_randomPos = [(getMarkerPos "aoCircle_2"), 1500, random 360] call BIS_fnc_relPos;	
	
	_air = [AIR_TYPE] call BIS_fnc_selectRandom createVehicle [_randomPos select 0,_randomPos select 1,1000];
	waitUntil{!isNull _air};
	_air engineOn true;
	_air setPos [(_randomPos select 0),(_randomPos select 1),300];

	_air spawn
	{
		private["_x"];
		for [{_x=0},{_x<=200},{_x=_x+1}] do
		{
			_this setVelocity [0,0,0];
			sleep 0.1;
		};
	};
	createVehicleCrew _air;
	_tGrp = crew _air;
	{[_x] joinSilent _airGroup;} count _tGrp;
	
//	[_airGroup, getMarkerPos "aoCircle_2", 800] call BIS_fnc_taskPatrol;
	_wp1 = _airGroup addWaypoint [(getMarkerPos "aoCircle_2"), 0];  
	_wp1 setWaypointSpeed "FULL";  
	_wp1 setWaypointType "SAD";

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

// ---- MRAP 

for "_x" from 0 to 1 do {
	_AOmrapGroup = createGroup east;
//	_randomPos = [[[getMarkerPos "aoCircle_2", PARAMS_AOSize],[]],["water"]] call BIS_fnc_randomPos;
	_randomPos = ["aoCircle_2",0,[],[],650] call SHK_pos_getPosMarker;	
	_AOmrap = [MRAP_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
	waitUntil {!isNull _AOmrap};
	createVehicleCrew _AOmrap;
	_tGrp = crew _AOmrap;
	{[_x] joinSilent _AOmrapGroup;} count _tGrp;
	
	[_AOmrapGroup, getMarkerPos "aoCircle_2", 600] call BIS_fnc_taskPatrol;
	_AOmrap lock 3;
	if (random 1 >= 0.3) then {
		_AOmrap allowCrewInImmobile true;
	};
	
	_enemiesArray = _enemiesArray + [_AOmrapGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_AOmrap];

	{
		_x addCuratorEditableObjects [[_AOmrap], false];
		_x addCuratorEditableObjects [units _AOmrapGroup, false];
	} foreach adminCurators;
};
//
	["aoCircle_2",2,true,false,1000] execVM "scripts\HeliDrop.sqf";
	["aoCircle_2",2,true,false,1200] execVM "scripts\HeliDrop.sqf";
//	
	waitUntil {sleep 5; count list _dt < PARAMS_EnemyLeftThreshhold};
	
	currentAOUp = false; publicVariable "currentAOUp";
	
	deleteVehicle _dt;
	[_enemiesArray] spawn QS_fnc_AOdelete;
	
	//----------------------------------------------------- MAINTENANCE
	
	_aoClean = [] execVM "scripts\misc\clearItemsAO.sqf";
	waitUntil {
		scriptDone _aoClean
	};
};