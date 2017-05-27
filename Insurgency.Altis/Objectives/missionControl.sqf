/*
Author: 

	Quiksilver

Last modified: 

	12/05/2014

Description:

	Main AO mission control
		
______________________________________________*/

private ["_mission","_missionList","_currentMission","_nextMission","_loopTimeout"];

_loopTimeout = 20;

_missionList = [
	"regionNW",
	"regionNE",
	"regionSW",
	"regionSE",
	"regionSUB",
	"regionCE"
];

//if (PARAMS_AOReinforcementJet == 1) then {_null = [] execVM "Objectives\mission\main\CAS.sqf";};		

/*
_currentMission = execVM "Objectives\mission\main\region\regionCE.sqf";

waitUntil {
	sleep 5;
	scriptDone _currentMission
};
*/

while { true } do {	
	
	_mission = _missionList call BIS_fnc_selectRandom;
	_currentMission = execVM format ["Objectives\mission\main\region\%1.sqf", _mission];
	
	waitUntil {
		sleep 5;
		scriptDone _currentMission
	};
	sleep _loopTimeout;
};
	
	
/*
Author: 

	Quiksilver

Last modified: 

	1/05/2014

Description:

	Mission control

To do:

	Rescue/capture/HVT missions
______________________________________________*/

private ["_mission","_missionList","_currentMission","_nextMission","_delay","_loopTimeout"];

_delay = 300 + (random 600);
_loopTimeout = 10 + (random 10);

//	"LABsyn",
//	"destroyUrban",
//	"HQcoast",
//	"HQfia",
//	"HQind",
//	"HQresearch",
//	"priorityAA",	
//	"priorityARTY",
//	"secureChopper",
//	"secureIntelUnit",
//	"secureIntelVehicle",
//	"secureRadar",
//	"ArmeChimique",
//	"underWater"

_missionList = [	
	"LABsyn",
	"destroyUrban",
	"HQcoast",
	"HQfia",
	"HQind",
	"HQresearch",
	"priorityAA",	
	"priorityARTY",
	"secureChopper",
	"secureIntelUnit",
	"secureIntelVehicle",
	"secureRadar",
	"ArmeChimique",
	"underWater"
];

SM_SWITCH = true; publicVariable "SM_SWITCH";
	
while { true } do {

	if (SM_SWITCH) then {
	
		hqSideChat = "Nouvel Objectif Secondaire..."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
		sleep 3;
	
		_mission = _missionList call BIS_fnc_selectRandom;
		_currentMission = execVM format ["Obejectives\mission\side\missions\%1.sqf", _mission];
	
		waitUntil {
			sleep 3;
			scriptDone _currentMission
		};
	
		sleep _delay;
		
		SM_SWITCH = true; publicVariable "SM_SWITCH";
	};
	sleep _loopTimeout;
};


	
