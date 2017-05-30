// by Bon_Inf*


//"Land_Wreck_Heli_Attack_01_F"

#define CHOPPER_TYPE "Land_Wreck_Heli_Attack_01_F"

#define rescue_type "B_Helipilot_F"
private ["_objPos","_flatPos","_accepted","_position","_randomDir","_hangar","_x","_enemiesArray","_briefing","_fuzzyPos","_unitsArray","_dummy","_object"];

_c4Message = ["Le pilote a ete ramener à bon port grace à vos exploits.","Le pilote et la donnée on ete ramener à bon port bien jouet soldat.","Bien joue soldat vous avez sauve notre pilote."] call BIS_fnc_selectRandom;




//-------------------- FIND SAFE POSITION FOR OBJECTIVE

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5,0,0.2,sizeOf "Land_TentHangar_V1_F",0,false];

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [5,0,0.2,sizeOf "Land_TentHangar_V1_F",0,false];
			};

		if ((_flatPos distance (getMarkerPos "respawn_west")) > 1000 && (_flatPos distance (getMarkerPos currentAO)) > 500) then
		{
			_accepted = true;
		};
	};
	
	_objPos = [_flatPos, 25, 35, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;


//-------------------- SPAWN OBJECTIVE

	_randomDir = (random 360);
	sideObj = [CHOPPER_TYPE] call BIS_fnc_selectRandom createVehicle _flatPos;
	waitUntil {!isNull sideObj};

//-------------------- SPAWN PILOT	
_grp = createGroup west;
_pilot = _grp createUnit [rescue_type, _flatPos, [], 0, "FORM"];
[_pilot,man] call vts_isHostage;

_pilot = pilot;
_pilot setIdentity "Ben_Kerry";	
_pilot allowDamage false;
_pilot setName ["Ben Kerry","Ben","Kerry"];



	{
		_x addCuratorEditableObjects [units _pilot, false];
	} foreach adminCurators;

//-------------------- SPAWN FORCE PROTECTION
	_enemiesArray = [sideObj] call QS_fnc_SMenemyEAST;
//-------------------- BRIEF

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Sauve le Pilot"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Objectif de Mission:Sauve le Pilot"; publicVariable "sideMarker";
	publicVariable "sideObj";

	_briefing = "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Sauve le Pilot</t><br/>____________________<br/>L'OPFOR a abattue une helicoptere de reconnaissance.Le pilote a eu le temps d'envoier un message donnant s'est coordonnée.Votre objectif et de retrouve le pilote et le ramener à la Base au médical EVAC LZ. </t>";
	GlobalHint = _briefing; hint parseText _briefing; publicVariable "GlobalHint";
	showNotification = ["Objectif de Mission", "Sauve le Pilot"]; publicVariable "showNotification";
	["rescuepilot",[Sauve le Pilot]] call bis_fnc_showNotification;
	sideMarkerText = "Sauve le Pilot"; publicVariable "sideMarkerText";

	
	//------------------------------------------- Set target start text
	
	_targetStartText = format
	[
		"<t align='center' size='2.2'>New Target</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>We did a good job with the last target, lads. I want to see the same again. Get yourselves over to %1 and take 'em all down!<br/><br/>Remember to take down that radio tower to stop the enemy from calling in CAS.",
		currentAO
	];

			showNotification = ["Rescuepilot","Blackfoot down !!!"]; publicVariable "showNotification";
			
_task =[player, "Rescuepilot", ["L'OPFOR a abattue une helicoptere de reconnaissance.Le pilote a eu le temps d'envoier un message donnant s'est coordonnée.Votre objectif et de retrouve le pilote et le ramener à la Base au Medical EVAC LZ.", "Sauve le Pilot", "sideMarker"], objNull, false] call BIS_fnc_taskCreate;
	
["Rescuepilot", "ASSIGNED"] call BIS_fnc_taskSetState;


		
	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";


while { sideMissionUp } do {

	if (!alive _pilot) exitWith {
		
		//-------------------- DE-BRIEFING Mission ECHOUE
		
		hqSideChat = "Le pilot est mort! Mission ECHOUE!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		[] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		sideMissionUp = false; publicVariable "sideMissionUp";
		
		//-------------------- DELETE
		
		{ _x setPos [-10000,-10000,0]; } forEach [_object,researchTable,_dummy];			// hide objective pieces
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,house];
		deleteVehicle nearestObject [getPos sideObj,"Land_TentHangar_V1_ruins_F"];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};		
		
		
		//-------------------- DE-BRIEFING Mission Reuusit		
	if ((pilot distance  MedivacLZ) < 30) exitWith {
//if ((player distance _t) < 3) then {	
	//(_pilot distance getMarkerPos "Medivac_LZ_marker" < 30 || !alive sideObj)&&(alive _pilot)
			hqSideChat = _c4Message;
			publicVariable "hqSideChat";
			[WEST,"HQ"] sideChat hqSideChat;
			pilot action ["eject",vehicle pilot];
			sleep 1;
			deleteVehicle pilot;
			deleteVehicle _wreck;
			sleep 1;
			deleteGroup _grp;
			
			
		//-------------------- DE-BRIEFING
		sideMissionUp = false; publicVariable "sideMissionUp";
		[] call QS_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";

	
		//--------------------- DELETE
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,house];
		deleteVehicle nearestObject [getPos sideObj,"Land_Wreck_Heli_Attack_01_F"];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};
};
/*__________________________________________________________________
	//-------------------------------------------- Show global target start hint
//http://forums.bistudio.com/archive/index.php/t-181676.html
	//--------------------------------------------
	
	GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
["NewSub", "Destroy the enemy radio tower."] call BIS_fnc_taskCreate;
	publicVariable "showNotification";
	showNotification = ["NewSub", "Destroy the enemy radio tower."] call bis_fnc_showNotification;;
	publicVariable "showNotification";		
player call showNotification;	
	["NewSub",["Disabled the nuke without triggering an alarm.",5]] call bis_fnc_showNotification;
	
[player, "objShootDown", ["description", "title", "marker"], objNull, false] call BIS_fnc_taskCreate;
["objShootDown", "Succeeded"] call BIS_fnc_taskSetState;	

[_pilot, "objShootDown", ["_targetStartText", "Sauve le Pilot", "sideMarker"], objNull, false] call BIS_fnc_taskCreate;
["objShootDown", "Succeeded"] call BIS_fnc_taskSetState;

task_1 = player createSimpleTask ["NewSub"];
task_1 setSimpleTaskDescription ["TASK DESCRIPTION","Example Task","WHAT WILL BE DISPLAYED ON THE MAP"];
task_1 setSimpleTaskDestination (getMarkerPos "sideMarker");
task_1 setTaskState "Assigned";
player setCurrentTask task_1;

["objTask1", "Succeeded"] call BIS_fnc_taskSetState;
______________________________________________*/











