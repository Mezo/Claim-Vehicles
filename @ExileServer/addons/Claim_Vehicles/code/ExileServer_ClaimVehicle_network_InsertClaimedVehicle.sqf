/*

 	Name: ExileServer_ClaimVehicle_network_InsertClaimedVehicle.sqf

 	Author: MezoPlays
    Copyright (c) 2016 MezoPlays

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0

*/
private["_sessionID","_package","_objectNetID","_pinCode","_ownerUID","_vehicle"];
_sessionID = _this select 0;
_package = _this select 1;
_objectNetID = _package select 0;
_pinCode = _package select 1;

_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
_ownerUID = getPlayerUID _playerObject;
_vehicle = objectFromNetId _objectNetID;

try
{
    if !(alive _playerObject) then
    {
        throw "Arma is aids and it gave a player a scroll action while they were dead.";
    };
    if !(_vehicle isKindOf "AIR" || _vehicle isKindOf "CAR" || _vehicle isKindOf "TANK") then
    {
        throw "Somebody tried to claim a chicken or some other shit.";
    };
    if (_vehicle getVariable "ExileIsPersistent") then
    {
        throw "We no let you take other pee-pole vehicle bruh.";
    };
    if !(count _pinCode == 4) then {
        throw "One of your players cannot count to 4 :) I didn't even send the client a response because I don't think they deserve it";
    };
    _vehicle setVariable ["ExileIsLocked",1];
    _vehicle setVariable ["ExileOwnerUID", _ownerUID];
    _vehicle setVariable ["ExileAccessCode", _pinCode];
    _vehicle setVariable ["ExileIsPersistent", true, true];
    _vehicle lock 2;
    _vehicle call ExileServer_object_vehicle_database_insert;
    _vehicle call ExileServer_object_vehicle_database_update;
}
catch
{
    _exception call ExileServer_util_log;
};
