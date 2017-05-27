
IF (isnil "server")then{hint "YOU MUST PLACE A GAME LOGIC NAMED SERVER!";};
eos1_fnc_spawnvehicle=compile preprocessfilelinenumbers "eos1\functions1\eos1_SpawnVehicle.sqf";
eos1_fnc_grouphandlers=compile preprocessfilelinenumbers "eos1\functions1\setSkill1.sqf";
eos1_fnc_findsafepos=compile preprocessfilelinenumbers "eos1\functions1\findSafePos1.sqf";
eos1_fnc_spawngroup= compile preprocessfile "eos1\functions1\infantry1_fnc.sqf";
eos1_fnc_setcargo = compile preprocessfile "eos1\functions1\cargo1_fnc.sqf";
eos1_fnc_taskpatrol= compile preprocessfile "eos1\functions1\shk1_patrol.sqf";
SHK1_pos= compile preprocessfile "eos1\functions1\shk1_pos.sqf";
shk1_fnc_fillhouse = compile preprocessFileLineNumbers "eos1\Functions1\SHK1_buildingpos.sqf";
eos1_fnc_getunitpool= compile preprocessfilelinenumbers "eos1\UnitPools1.sqf";
call compile preprocessfilelinenumbers "eos1\AI1_Skill.sqf";

EOS1_Deactivate = {
	private ["_mkr"];
		_mkr=(_this select 0);
	{
		_x setmarkercolor "colorblack";
		_x setmarkerAlpha 0;
	}foreach _mkr;
};

EOS1_debug = {
private ["_note"];
_mkr=(_this select 0);
_n=(_this select 1);
_note=(_this select 2);
_pos=(_this select 3);

_mkrID=format ["%3:%1,%2",_mkr,_n,_note];
deletemarker _mkrID;
_debugMkr = createMarker[_mkrID,_pos];
_mkrID setMarkerType "Mil_dot";
_mkrID setMarkercolor "colorBlue";
_mkrID setMarkerText _mkrID;
_mkrID setMarkerAlpha 0.5;
};
