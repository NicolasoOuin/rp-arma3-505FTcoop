/*
Author:

	Quiksilver
	
Last modified:

	24/04/2014
	
Description:

	Secure HQ supplies before destroying it.

____________________________________*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_object","_SMveh","_SMaa","_tower1","_tower2","_tower3","_flatPos1","_flatPos2","_flatPos3"];

_c4Message = ["Les charges sont posées, 15 secondes avant explosion du laboratoire!","Dégagez la zone! Les charges vont exploser dans 15 secondes!","Le laboratoire est plastiqué! 15 secondes avant mise à feu!"] call BIS_fnc_selectRandom;


//-------------------- FIND POSITION FOR OBJECTIVE

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];
		};

		if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700 && (_flatPos distance (getMarkerPos currentAO)) > 500) then {
			_accepted = true;
		};
	};
	
	_flatPos1 = [_flatPos, 100, 150] call BIS_fnc_relPos;
	_flatPos2 = [_flatPos, 30, 60] call BIS_fnc_relPos;
	_flatPos3 = [_flatPos, 70, 100] call BIS_fnc_relPos;

//-------------------- SPAWN OBJECTIVE

	_objDir = random 360;

	sideObj = "Land_Medevac_HQ_V1_F" createVehicle _flatPos;
	waitUntil {alive sideObj};
	sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), (getPos sideObj select 2)];
	sideObj setVectorUp [0,0,1];
	sideObj setDir _objDir;
	
	_object = [indCrate1,indCrate2] call BIS_fnc_selectRandom;
	_object setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 2)];
	
	truck1 = "Land_Cargo_Patrol_V2_F" createVehicle _flatPos1;
	truck2 = "Land_Cargo_Patrol_V2_F" createVehicle _flatPos2;
	truck3 = "Land_Cargo_Patrol_V2_F" createVehicle _flatPos3;
	
	{ _x setDir random 360 } forEach [truck1,truck2,truck3];
	{ _x lock 3 } forEach [truck1,truck2,truck3];


	
	
//-------------------- SPAWN FORCE PROTECTION

	_enemiesArray = [sideObj] call QS_fnc_SMenemySYND;

//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Neutraliser le laboratoire"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Mission secondaire: plastiquer le laboratoire"; publicVariable "sideMarker";
	publicVariable "sideObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvel objectif secondaire</t><br/><t size='1.5' color='#00B2EE'>Neutraliser le laboratoire</t><br/>____________________<br/>Les Syndicates disposent d'un laboratoire qui leur permet de produire la drogue qu'ils écoulet sur Altis.<br/><br/>Les satellites alliés ont détecté l'emplacement du laboratoire et du laboratoire de drogue; plastiquer le laboratoire afin de ralentir le circuit de distribution de drogue.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["NouvelObjectifSecondaire", "Neutraliser le laboratoire"]; publicVariable "showNotification";
	sideMarkerText = "Neutraliser le laboratoire"; publicVariable "sideMarkerText";
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {

	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]

	if (!alive sideObj) exitWith {
		
		//-------------------- DE-BRIEFING
		
		sideMissionUp = false; publicVariable "sideMissionUp";
		hqSideChat = "Laboratoire détruit! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		[] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		
		//-------------------- DELETE
		
		_object setPos [-10000,-10000,0];
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,truck1,truck2,truck3];
		deleteVehicle nearestObject [getPos sideObj,"Land_Medevac_HQ_V1_ruins_F"];
		{ [_x] spawn QS_fnc_SMdelete } forEach [_unitsArray,_enemiesArray];
	};
	
	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]
	
	if (SM_SUCCESS) exitWith {
		
		hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
		//-------------------- BOOM!
	
		sleep 12;											
		"Bo_Mk82" createVehicle getPos _object; 			
		sleep 0.1;
		_object setPos [-10000,-10000,0];
	
		//-------------------- DE-BRIEFING

		sideMissionUp = false; publicVariable "sideMissionUp";
		[] call QS_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
	
		//--------------------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,truck1,truck2,truck3];
		deleteVehicle nearestObject [getPos sideObj,"Land_Medevac_HQ_V1_ruins_F"];
		{ [_x] spawn QS_fnc_SMdelete } forEach [_unitsArray,_enemiesArray];
	};
};