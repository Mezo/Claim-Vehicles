/*
    Claim vehicle and insert to DB.
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
    ["Whoops",["That's not a vehcile... derp"]] call ExileClient_gui_notification_event_addNotification;
};
