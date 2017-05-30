/*
				***		ARMA3Alpha HELI PARADROP v1.0 - by SPUn / lostvar	***
	
					Spawns chopper which delivers paradrop group to scene
				
		Calling the script:
		
			default: 		nul = [this] execVM "scripts\heliParadrop.sqf";
			
			custom: 		nul = [spot, side, allowDamage, captive, distance, direction, flyby, fly height, jump distance,
								group size, jump delay, open height, smokes, flares, chems, patrol, target] execVM "vendor\lv\heliParadrop.sqf";
								
	Parameters:
	
spot 	= 	drop spot 		(name of marker or object or unit, or position array) 									DEFAULT: --
side 	= 	1 or 2 or 3		(1 = west, 2 = east, 3 = independent)													DEFAULT: 2
allowDamage = 	true/false	(allow or disallow damage for chopper)													DEFAULT: true
captive 	= 	true/false 	(if true, enemies wont notice chopper) 													DEFAULT: false
distance 	= 	number 		(from how far chopper comes from) 														DEFAULT: 1500
direction 	= 	"random" or 0-360 (direction where chopper comes from, use quotes with random!) 					DEFAULT: "random"
flyby	=	true/false		(true = chopper just flies thru target, false = stays still while dropping units)		DEFAULT: true
fly height	= number 		(how high chopper flies)																DEFAULT: 200
jump distance =	number 		(how many meters before target location units starts jumping out of heli)				DEFAULT: 150
group size	= number 		(how many units is in para drop group)													DEFAULT: 8
jump delay	= number 		(how many seconds is the delay between jumps)											DEFAULT: 0.5
open height = number		(in which height units opens their parachutes)											DEFAULT: 50
smokes	=	true/false		(will units throw cover smokes (on 10m height))											DEFAULT: false
flares	=	true/false		(will units throw flares (on 30m height))												DEFAULT: false	
chems	=	true/false		(will units throw chemlights (on 30m height))											DEFAULT: false
patrol 	= 	true/false 		(if false, units wont patrol in any way <- handy if you set (group player) as *group) 	DEFAULT: true
target 	= 	patrol target 	(patrolling target for infantry group, options:											DEFAULT: player
							unit 	= 	units name, ex: enemyunit1
							marker 	= 	markers' name, ex: "marker01" (remember quotes with markers!)
							marker array = array of markers in desired order, ex: ["marker01","marker02","marker03"]
							group	= 	groups name, ex: (group enemy1)	OR BlueGroup17
							group array, ex: [(group player), (group blue2)]
							["PATROL",center position,radius] = uses patrol-vD.sqf, ex: ["PATROL",(getPos player),150]										
						 
EXAMPLE: 	nul = [player, 2, false, true, 1000, "random", true, 500, 200, 6, 1, 50, true, false, true, true, player, false, 0.75, nil, nil, 1,false] execVM "vendor\lv\heliParadrop.sqf";
*/
if (!isServer)exitWith{};
private ["_mp","_grp","_heliType","_men","_grp2","_center","_man1","_man2","_landingSpot","_side","_flyHeight","_openHeight","_jumpDelay","_jumperAmount","_heliDistance","_heliDirection","_flyBy","_allowDamage","_BLUmen","_OPFmen","_INDmen","_BLUchopper","_OPFchopper","_INDchopper","_landingSpotPos","_spos","_heli","_crew","_dir","_flySpot","_jumpDistanceFromTarget","_captive","_smokes","_flares","_chems","_skls","_cPosition","_cRadius","_patrol","_target","_cycle","_skills","_customInit","_grpId","_wp0","_wp1","_doorHandling"];

//Extra settings:
_doorHandling = true;
//

_landingSpot = if (count _this > 0) then {_this select 0};
_side = if (count _this > 1) then {_this select 1}else{2};
_allowDamage = if (count _this > 2) then {_this select 2}else{true};
_captive = if (count _this > 3) then {_this select 3}else{false};
_heliDistance = if (count _this > 4) then {_this select 4}else{1500};
_heliDirection = if (count _this > 5) then {_this select 5}else{"random"};
_flyBy = if (count _this > 6) then {_this select 6}else{true};
_flyHeight = if (count _this > 7) then {_this select 7}else{200};
_jumpDistanceFromTarget = if (count _this > 8) then {_this select 8}else{300};
_jumperAmount = if (count _this > 9) then {_this select 9}else{8};
_jumpDelay = if (count _this > 10) then {_this select 10}else{0.5};
_openHeight = if (count _this > 11) then {_this select 11}else{50};
_smokes = if (count _this > 12) then {_this select 12}else{false};
_flares = if (count _this > 13) then {_this select 13}else{false};
_chems = if (count _this > 14) then {_this select 14}else{false};
_patrol = if (count _this > 15) then {_this select 15; }else{true;};
_target = if (count _this > 16) then {_this select 16; }else{_landingSpot;};

//Classnames:
_BLUmen = ["B_Soldier_A_F","B_soldier_AR_F","B_medic_F","B_engineer_F","B_soldier_exp_F","B_Soldier_GL_F","B_soldier_M_F","B_soldier_AA_F","B_soldier_AT_F","B_officer_F","B_soldier_repair_F","B_Soldier_F","B_soldier_LAT_F","B_Soldier_lite_F","B_Soldier_SL_F","B_Soldier_TL_F","B_recon_exp_F","B_recon_JTAC_F","B_recon_M_F","B_recon_medic_F","B_recon_F","B_recon_LAT_F","B_recon_TL_F","B_soldier_AAR_F","B_soldier_AAA_F","B_soldier_AAT_F"];
_OPFmen = ["O_Soldier_A_F","O_soldier_AR_F","O_medic_F","O_engineer_F","O_soldier_exp_F","O_Soldier_GL_F","O_soldier_M_F","O_soldier_AA_F","O_soldier_AT_F","O_officer_F","O_soldier_repair_F","O_Soldier_F","O_soldier_LAT_F","O_Soldier_lite_F","O_Soldier_SL_F","O_Soldier_TL_F","O_recon_exp_F","O_recon_JTAC_F","O_recon_M_F","O_recon_medic_F","O_recon_F","O_recon_LAT_F","O_recon_TL_F","O_soldier_AAR_F","O_soldier_AAA_F","O_soldier_AAT_F"];
_INDmen = ["I_Soldier_A_F","I_soldier_AR_F","I_medic_F","I_engineer_F","I_soldier_exp_F","I_Soldier_GL_F","I_soldier_M_F","I_soldier_AA_F","I_soldier_AT_F","I_officer_F","I_soldier_repair_F","I_Soldier_F","I_soldier_LAT_F","I_Soldier_lite_F","I_Soldier_SL_F","I_Soldier_TL_F","I_soldier_AAR_F","I_soldier_AAA_F","I_soldier_AAT_F"];
_BLUchopper = "B_Heli_Transport_01_F";
_OPFchopper = "O_Heli_Light_02_unarmed_F";
_INDchopper = "I_Heli_Transport_02_F";

//Side related group creation:
switch(_side)do{
	case 1:{
		_grp = createGroup west;
		_grp2 = createGroup west;
		_men = _BLUmen;
		_heliType = _BLUchopper;
	};
	case 2:{
		_grp = createGroup east;
		_grp2 = createGroup east;
		_men = _OPFmen;
		_heliType = _OPFchopper;
	};
	case 3:{
		_grp = createGroup resistance;
		_grp2 = createGroup resistance;
		_men = _INDmen;
		_heliType = _INDchopper;
	};
};

//Check if target is marker/object/position
if(_landingSpot in allMapMarkers)then{
	_landingSpotPos = getMarkerPos _landingSpot;
}else{
	if (typeName _landingSpot == "ARRAY") then{
		_landingSpotPos = _landingSpot;
	}else{
		_landingSpotPos = getPos _landingSpot;
	};
};

//Spawn chopper
if(typeName _heliDirection == "STRING")then{_heliDirection = random 360;};
_spos = [(_landingSpotPos select 0) + (sin _heliDirection) * _heliDistance, (_landingSpotPos select 1) + (cos _heliDirection) * _heliDistance, _flyHeight];
_heli = createVehicle [_heliType, _spos, [], 0, "FLY"];
//_heli allowDamage true;
_crew = [_heli,_grp] call bis_fnc_spawncrew;
if(_captive)then{
	_heli setCaptive true;
	{ _x setCaptive true; } forEach units _grp;
};

//Count angle between chopper and target, and end spot for chopper
_dir = ((_landingSpotPos select 0) - (_spos select 0)) atan2 ((_landingSpotPos select 1) - (_spos select 1));
_flySpot = [(_landingSpotPos select 0) + (sin _dir) * _heliDistance, (_landingSpotPos select 1) + (cos _dir) * _heliDistance, _flyHeight];

//Heli to go
if(_flyBy)then{
	_wp0 = _grp addWaypoint [_landingSpotPos, 0, 1];
	[_grp,0] setWaypointBehaviour "CARELESS";
	[_grp,0] setWaypointCompletionRadius 60;
	_wp1 = _grp addWaypoint [_flySpot, 0, 2];
	[_grp,1] setWaypointBehaviour "CARELESS";
	[_grp,1] setWaypointCompletionRadius 60;
}else{
	_wp0 = _grp addWaypoint [_landingSpotPos, 0, 1];
	[_grp,0] setWaypointBehaviour "CARELESS";
	[_grp,0] setWaypointCompletionRadius 60;
};
_heli flyInHeight _flyHeight;

{
	_x addCuratorEditableObjects [[_grp], false];
} foreach adminCurators;

//Make heli & crew dissapear if something goes wrong or if heli is at its end spot
[_heli,_grp,_flySpot,_landingSpotPos,_heliDistance] spawn {
	private ["_heli","_grp","_flySpot","_landingSpotPos","_heliDistance"];
	_heli = _this select 0;
	_grp = _this select 1;
	_flySpot = _this select 2;
	_landingSpotPos = _this select 3;
	_heliDistance = _this select 4;
	while{([_heli, _flySpot] call BIS_fnc_distance2D)>200}do{
		if(!alive _heli || !canMove _heli)exitWith{};
		sleep 5;
	};
	waitUntil{([_heli, _landingSpotPos] call BIS_fnc_distance2D)>(_heliDistance * .5)};
	{ deleteVehicle _x; } forEach units _grp;
	deleteVehicle _heli;
};

//Wait till it's close enough
waitUntil{([_heli, _landingSpotPos] call BIS_fnc_distance2D)<_jumpDistanceFromTarget};

//Create para group
for "_i" from 1 to _jumperAmount step 1 do{
	_man1 = _men select (floor(random(count _men)));
	_man2 = _grp2 createUnit [_man1, [(getPos _heli) select 0,(getPos _heli) select 1, ((getPos _heli) select 2) - 3], [], 0, "NONE"];
	_man2 setPos [(getPos _heli) select 0,(getPos _heli) select 1, ((getPos _heli) select 2) - 3];
	
	[_man2,_heli,_openHeight,_smokes,_flares,_chems] spawn{
		private ["_man2","_heli","_openHeight","_para","_smokes","_flares","_chems","_smoke","_flare","_chem"];
		_man2 = _this select 0;
		_heli = _this select 1;
		_openHeight = _this select 2;
		_smokes = _this select 3;
		_flares = _this select 4;
		_chems = _this select 5;
		waitUntil{((getPos _man2)select 2)<_openHeight};
		_para = createVehicle ["NonSteerable_Parachute_F", position _man2, [], ((direction _heli)-25+(random 50)), 'NONE'];
		_para setPos (getPos _man2);
		_man2 moveInDriver _para;
		
		if(_smokes)then{
			waitUntil{((getPos _man2)select 2)<10};
			_smoke = "SmokeShell" createVehicle (getPos _man2);
		};
		if(_flares)then{
			waitUntil{((getPos _man2)select 2)<30};
			_flare = "F_40mm_Red" createVehicle [(getPos _man2) select 0,(getPos _man2) select 1,0]; //Chemlight_red
		};
		if(_chems)then{
			waitUntil{((getPos _man2)select 2)<30};
			_chem = "Chemlight_red" createVehicle (getPos _man2);
		};
	};
	_man2 allowFleeing 0;
	sleep _jumpDelay;
};
	{
		_x addCuratorEditableObjects [units _grp2, false];
	} foreach adminCurators;

[(units _grp2)] call QS_fnc_setSkill2;


//If it wasnt flyby, send heli to its end spot
if(!_flyBy)then{ 
	_wp1 = _grp addWaypoint [_flySpot, 0, 2];
	[_grp,1] setWaypointBehaviour "CARELESS";
	[_grp,1] setWaypointCompletionRadius 60;
};

[_grp2, getMarkerPos _landingSpot, 150] call BIS_fnc_taskPatrol;
