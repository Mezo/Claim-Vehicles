/*

 	Name: ExileServer_ClaimVehicle_network_InsertClaimedVehicle.sqf

 	Author: MezoPlays
    Copyright (c) 2016 MezoPlays

    This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
    To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0

*/
_object = cursorTarget;
_vehicleObj = _object;
_objectNetId = netId _object;
_object = typeOf _object;

if (_object isKindOf "AIR" || _object isKindOf "CAR" || _object isKindOf "TANK") then
{
    if ("Exile_Item_Codelock" in (player call ExileClient_util_playerCargo_list)) then
    {
        if !(_vehicleObj getVariable ["ExileIsPersistent", false]) then
        {
            _pincode = 4 call ExileClient_gui_keypadDialog_show;
            if (count _pinCode == 4) then
            {
                player removeMagazine "Exile_Item_CodeLock";
                ["InsertClaimedVehicle",[_objectNetId,_pinCode]] call ExileClient_system_network_send;
                ["Success",[format["Your pincode is: %1",_pinCode]]] call ExileClient_gui_notification_event_addNotification;
                _vehicleObj lock 2;
            } else {
                ["Whoops",["Your pincode must be 4 digits!"]] call ExileClient_gui_notification_event_addNotification;
            };
        } else {
            ["Whoops",["This Vehicle is already owned..."]] call ExileClient_gui_notification_event_addNotification;
        };
    } else {
        ["Whoops",["You need a codelock to do that!"]] call ExileClient_gui_notification_event_addNotification;
    };
} else {
    ["Whoops",["That's not a Vehicle... derp"]] call ExileClient_gui_notification_event_addNotification;
};
