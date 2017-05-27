/*
@filename: fn_vSetup02.sqf
Author:

	???
	
Last modified:

	22/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Apply code to vehicle
	vSetup02 deals with code that is already applied where it should be.
_______________________________________________*/

//============================================= CONFIG

private ["_u","_t","_theTexture"];

_u = _this select 0;
_t = typeOf _u;

if (isNull _u) exitWith {};
//
MFRETEXTURING=isClass (configFile >> "CfgPatches" >> "MF_Retexture");
//
//============================================= ARRAYS

_ghosthawk = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"]; 			// ghosthawk
_mobileArmory = ["B_Truck_01_ammo_F","B_APC_Tracked_01_CRV_F"];					// Mobile Armory
_ammoboxArmory = ["B_CargoNet_01_ammo_F","B_supplyCrate_F"];											// Mobile Armory
_noAmmoCargo = ["B_APC_Tracked_01_CRV_F","B_Truck_01_ammo_F"];					// Bobcat CRV
_dropHeli = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"]; 			// drop capable
_uav = ["B_UAV_02_CAS_F","B_UAV_02_F","B_UGV_01_F","B_UGV_01_rcws_F"];			// UAVs
_arty = ["B_MBT_01_arty_F"];			                                        // arty

//============================================= SORT
//===== Add to Zeus

{_x addCuratorEditableObjects [[_u],false];} count allCurators;


//===== remove ammo cargo
if (PARAMS_VehicleAmmoCargo == 0) then {
	if (_t in _noAmmoCargo) then {
		_u setAmmoCargo 0;
	};
};

//===== Mobile VAS/Arsenal
if (_t in _mobileArmory) then {
		[_u] execVM "MF\mf_vab.sqf";
		0 = [_u] execVM "scripts\VAserver.sqf";
};

//===== ammobox VAS/Arsenal
if (_t in _ammoboxArmory) then {
		[_u] execVM "MF\mf_vab.sqf";
		0 = [_u] execVM "scripts\VAserver.sqf";		
};


//===== Airdrop
if (_t in _dropHeli) then {
	_u setVariable ["airdrop_veh",TRUE,TRUE];
};

//===== Ghosthawk specific, animated doors, and turret locking system
if (_t in _ghosthawk) then {
	_u setVariable ["turretL_locked",FALSE,TRUE];
	_u setVariable ["turretR_locked",FALSE,TRUE];
	[_u] execVM "scripts\vehicle\animate\ghosthawk.sqf";
};

//===== UAV respawn fixer
if (_t in _uav) then {
	{deleteVehicle _x;} count (crew _u);
	_u setVehicleAmmo 0;
	[_u] spawn {
		_u = _this select 0;
		sleep 2;
		createVehicleCrew _u;
	};
};

[_u] execVM "MF\mf_unitSetup.sqf";
