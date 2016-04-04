//add this to the top of config.cpp
class CfgNetworkMessages
{
    class InsertClaimedVehicle
    {
        module = "ClaimVehicle";
        parameters[] = {"STRING","STRING"};
    };
};

//copy pasta this into class "AIR"/"CAR"/"TANK"
class ClaimVehicle: ExileAbstractAction
{
    title = "Claim Ownership";
    condition = "!(ExileClientInteractionObject getVariable ['ExileIsPersistent', false])";
    action = "execVM 'Claim_Vehicles\Claim_Vehicles_sendRequest.sqf';";
};

//Add these to customCode bruh.
class CfgExileCustomCode
{
	ExileServer_object_vehicle_createNonPersistentVehicle =	"Claim_Vehicles\Overwrites\ExileServer_object_vehicle_createNonPersistentVehicle.sqf";
    ExileServer_object_vehicle_createPersistentVehicle    = "Claim_Vehicles\Overwrites\ExileServer_object_vehicle_createPersistentVehicle.sqf";
};
