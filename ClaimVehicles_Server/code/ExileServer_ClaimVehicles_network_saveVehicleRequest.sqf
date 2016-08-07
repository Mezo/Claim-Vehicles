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
        throw "You must be alive to claim a vehicle!";
    };
    if !(_vehicle isKindOf "AIR" || _vehicle isKindOf "CAR" || _vehicle isKindOf "TANK") then
    {
        throw "That's not a vehicle!";
    };
    if (_vehicle getVariable ["ExileIsPersistent", true]) then
    {
        throw "This vehicle is already claimed!";
    };
    if !(isNil {_vehicleObj getVariable "SC_drivenVehicle"}) then
    {
        throw "This vehicle is owned by the server!";
    };
    if !(count _pinCode == 4) then
    {
        throw "Your pincode must be 4 digits!";
    };

    _playerObject removeMagazineGlobal "Exile_Item_CodeLock";

    _vehicle setVariable ["ExileIsLocked",-1];
    _vehicle setVariable ["ExileOwnerUID", _ownerUID];
    _vehicle setVariable ["ExileAccessCode", _pinCode];
    _vehicle setVariable ["ExileIsPersistent", true];

    _vehicle lock 0;

    _vehicle call ExileServer_object_vehicle_database_insert;
    _vehicle call ExileServer_object_vehicle_database_update;


    [_sessionID, "toastRequest", ["SuccessTitleOnly", ["You're now the owner of this vehicle!"]]] call ExileServer_system_network_send_to;

}
catch
{
    [_sessionID, "toastRequest", ["ErrorTitleAndText", ["Claim Vehicles", _exception]]] call ExileServer_system_network_send_to;
    _vehicle lock 0; //Make sure the vehicle is unlocked if this stuff fails. Cheers John ;)
};
