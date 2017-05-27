/*
@filename: secureIntelUnit.sqf
Author:

	Quiksilver
	
Description:

	Recover intel from a unit

Status:
	
	29/04/2014
	Second pass
	
Notes / To Do:
	
	- known bug: detection trigger on _intelObj doesnt seem to recognize his position when he is in a cargo seat of a vehicle. Only detects once he gets out.
	
___________________________________________________________________________*/


#define CHOPPER_TYPE "Land_Wreck_Heli_Attack_01_F"
#define OBJUNIT_TYPES "O_V_Soldier_TL_hex_F","O_soldier_AA_F"
#define OBJUNIT_TYPES_INTEL "B_Helipilot_F"

private ["_x","_targetTrigger","_surrenderTrigger","_aGroup","_bGroup","_cGroup","_decoy1","_decoy2","_obj1","_obj2","_obj3","_intelDriver","_decoyDriver1","_decoyDriver2","_intelObj","_enemiesArray","_randomDir","_poi","_flatPos","_flatPos1","_flatPos2","_flatPos3","_position","_accepted","_fuzzyPos","_briefing","_escapeWP","_meetingPos"];

//-------------------------------------------------------------------------- FIND POSITION FOR MISSION

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];
			
		while {(count _flatPos) < 3} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];
		};
				
		if ((_flatPos distance (getMarkerPos "respawn_west")) > 3000 && (_flatPos distance (getMarkerPos currentAO)) > 3000) then {
			_accepted = true;
		};
	};
	
//-------------------------------------------------------------------------- NEARBY POSITIONS TO SPAWN STUFF (THEY SPAWN IN TRIANGLE SO NO ONE WILL KNOW WHICH IS THE OBJ. HEHEHEHE. 
	
	_flatPos1 = [_flatPos, 5, random 360] call BIS_fnc_relPos;
	_flatPos2 = [_flatPos, 8, random 360] call BIS_fnc_relPos;
	_flatPos3 = [_flatPos, 10, random 360] call BIS_fnc_relPos;

	
//-------------------- SPAWN CHOPPER

	_randomDir = (random 360);
	sideObj = [CHOPPER_TYPE] call BIS_fnc_selectRandom createVehicle _flatPos;
	waitUntil {!isNull sideObj};	


//-------------------------------------------------------------------------- CREATE GROUP, VEHICLE AND UNIT
	
	_aGroup = createGroup east;
	_bGroup = createGroup east;
	_cGroup = createGroup east;
	_surrenderGroup = createGroup west;
	
	//--------- INTEL OBJ

	
	[OBJUNIT_TYPES_INTEL] call BIS_fnc_selectRandom createUnit [_flatPos1, _aGroup];
	"O_V_Soldier_TL_hex_F" createUnit [_flatPos1, _aGroup];
	"O_V_Soldier_TL_hex_F" createUnit [_flatPos2, _bGroup];
	"O_V_Soldier_TL_hex_F" createUnit [_flatPos3, _cGroup];
	
	sleep 0.3;
	
	_intelObj = ((units _aGroup) select 0);
	_intelDriver = ((units _aGroup) select 1);
	[_intelObj] call vts_isHostage;	
	
	
	removeAllWeapons _intelObj;
	
	
	
//--------------------------------------------------------------------------- ADD ACTION TO OBJECTIVE. NOTE: NEEDS WORK STILL. avoid BIS_fnc_MP! Good enough for now though.
	
	sleep 0.1;
	[_intelObj,"QS_fnc_addActionRescueIntel",nil,true] spawn BIS_fnc_MP; 


	
//--------------------------------------------------------------------------- SPAWN GUARDS

	_enemiesArray = [_obj1] call QS_fnc_SMenemySYND;
	
//--------------------------------------------------------------------------- SPAWN AMBUSH

	/* WIP */
	
//--------------------------------------------------------------------------- BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];			
	sideMarkerText = "Sauver le pilote"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Side Mission: Sauver le pilote"; publicVariable "sideMarker"; 	
	_briefing = "<t align='center'><t size='2.2'>Nouvel objectif secondaire</t><br/><t size='1.5' color='#00B2EE'>Sauver le pilote</t><br/>____________________<br/>Un hélicoptère allié et son pilote sont tombés entre les mains des CSAT.<br/><br/>Le pilote a eu le temps d'activer sa balise de détresse mais les CSAT sont déjà sur place. Retrouver le pilote avant que les CSAT l'exécutent.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["NewSideMission", "Sauver le pilote"]; publicVariable "showNotification";
	sideMarkerText = "Sauver le pilote"; publicVariable "sideMarkerText";
	
	sleep 0.3;
	
	//----- Reset VARS for next time
	
	sideMissionUp = true; publicVariable "sideMissionUp";
	
	NOT_ESCAPING = true; publicVariable "NOT_ESCAPING";
	GETTING_AWAY = false; publicVariable "GETTING_AWAY";		// is this necessary public?
	HE_ESCAPED = false; publicVariable "HE_ESCAPED";			// is this necessary public?
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";
	HE_SURRENDERS = false; publicVariable "HE_SURRENDERS";
	
//-------------------------- [ CORE LOOPS ] ----------------------------- [ CORE LOOPS ] ---------------------------- [ CORE LOOPS ]
	
while { sideMissionUp } do {

	sleep 0.3;

	//------------------------------------------ IF VEHICLE IS DESTROYED [FAIL]
	
	if (!alive _intelObj) exitWith {
	
		sleep 0.3;
		
		//---------- DE-BRIEF
		
		hqSideChat = "Objective destroyed! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		sideMissionUp = false; publicVariable "sideMissionUp";
		[] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		
		//---------- REMOVE ACTION
		
		[_intelObj,"QS_fnc_removeAction",nil,true] spawn BIS_fnc_MP; 
		
		//---------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [_targetTrigger,_intelObj,_decoy1,_decoy2,_intelDriver,_obj1,_obj2,_obj3,_decoyDriver1,_decoyDriver2];
		[_enemiesArray] spawn QS_fnc_SMdelete;
		
	};
	
	//----------------------------------------- IS THE ENEMY TRYING TO ESCAPE? 
	
	if (NOT_ESCAPING) then {
	
		//---------- NO? then LOOP until YES or an exitWith {}.
	
		sleep 0.3;
	
		if (_intelObj call BIS_fnc_enemyDetected) then {
		
			sleep 0.3;
		
			hqSideChat = "Vous avez été repérés ! Les CSAT emmène le prisonnier pour l'exécuter ! Arrêtez-les !"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		
			//---------- WHERE TO / HOW WILL THE OBJECTIVES ESCAPE?
			
			{
				_escape1WP = _x addWaypoint [getMarkerPos currentAO, 100];	
				_escape1WP setWaypointType "MOVE";
				_escape1WP setWaypointBehaviour "CARELESS";
				_escape1WP setWaypointSpeed "FULL";
			} forEach [_aGroup,_bGroup,_cGroup];
				
			sleep 0.3;
			
			//---------- SET GETTING AWAY TO TRUE TO DETECT IF HE'S ESCAPED.
			
			GETTING_AWAY = true; publicVariable "GETTING_AWAY";
			
			//---------- END THE NOT ESCAPING LOOP
		
			NOT_ESCAPING = false; publicVariable "NOT_ESCAPING";
		};
	};
	
	//-------------------------------------------- THE ENEMY IS TRYING TO ESCAPE
	
	if (GETTING_AWAY) then {
	
		sleep 5;  // too long?
			
		//_targetTrigger attachTo [_intelObj,[0,0,0]];
	
		if (count list _targetTrigger < 1) then {
	
			sleep 0.3;
		
			HE_ESCAPED = true; publicVariable "HE_ESCAPED";
			
			sleep 0.3;
			
			GETTING_AWAY = false; publicVariable "GETTING_AWAY";
		};
		
		//---------- DETECT IF HE SURRENDERS
	
		if (HE_SURRENDERS) then {

			sleep 0.3;
		
			removeAllWeapons _intelObj;
			_intelObj playAction "Surrender";
			_intelObj disableAI "ANIM";	
			[_intelObj] joinSilent _surrenderGroup;
			
			//----- REMOVE 'SURRENDER' ACTION
			
			[_intelObj,"QS_fnc_removeAction1",nil,true] spawn BIS_fnc_MP; 
		};
		
	};
	
	//------------------------------------------- THE ENEMY ESCAPED [FAIL]
	
	if (HE_ESCAPED) exitWith {
			
			//---------- DE-BRIEF
			
			hqSideChat = "Le pilote a été exécuté! Mission Failed !"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
			sideMissionUp = false; publicVariable "sideMissionUp";
			[] spawn QS_fnc_SMhintFAIL;
			{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
			
			//---------- DELETE
			
			{ deleteVehicle _x } forEach [_targetTrigger,_intelObj,_decoy1,_decoy2,_intelDriver,_obj1,_obj2,_obj3,_decoyDriver1,_decoyDriver2];
			sleep 120;
			[_enemiesArray] spawn QS_fnc_SMdelete;
	};
	
	//-------------------------------------------- THE INTEL WAS RECOVERED [SUCCESS]
	
	if (SM_SUCCESS) exitWith {
	
		sleep 0.3;
		
		//---------- DE-BRIEF
		
		hqSideChat = "Le pilote est sécurisé ! Mission Accomplie !"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		sideMissionUp = false; publicVariable "sideMissionUp";
		[] spawn QS_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		
		//---------- REMOVE 'GET INTEL' ACTION
		
		[_intelObj,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP; 
		
		//---------- DELETE

		sleep 120;
		{ deleteVehicle _x } forEach [_targetTrigger,_intelObj,_decoy1,_decoy2,_intelDriver,_obj1,_obj2,_obj3,_decoyDriver1,_decoyDriver2,sideObj];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};	
};

