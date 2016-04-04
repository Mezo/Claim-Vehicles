class CfgPatches {
    class Claim_Vehicles {
        requiredVersion = 0.1;
        requiredAddons[]=
        {
            "exile_client"
        };
        units[] = {};
        weapons[] = {};
    };
};
class CfgFunctions {
    class Claim_Vehicles {
        class main {
            file="Claim_Vehicles\bootstrap";
            class preInit {
                preInit = 1;
            };
            class postInit {
                postInit = 1;
            };
        };
    };
};
