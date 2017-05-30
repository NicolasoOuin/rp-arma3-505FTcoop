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
		_currentMission = execVM format ["Objectives\side\missions\%1.sqf", _mission];

		waitUntil {
			sleep 3;
			scriptDone _currentMission
		};

		sleep _delay;

		SM_SWITCH = true; publicVariable "SM_SWITCH";
	};
	sleep _loopTimeout;
};
