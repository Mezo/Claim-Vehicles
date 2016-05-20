class CfgPatches
{
	class ClaimVehicles_Server
	{
		requiredVersion = 0.1;
		requiredAddons[] = {"exile_client","exile_assets","exile_server_config"};
		units[] = {};
		weapons[] = {};
		magazines[] = {};
		ammo[] = {};
	};
};
class CfgFunctions
{
    class ClaimVehicles_Server
    {
        class Bootstrap
        {
            file = "ClaimVehicles_Server\bootstrap";
            class preInit
            {
                preInit = 1;
            };
            class postInit
            {
                postInit = 1;
            };
        };
    };
};
class CfgNetworkMessages
{
    class saveVehicleRequest
    {
        module = "ClaimVehicles";
        parameters[] = {"STRING","STRING"};
    };
};
