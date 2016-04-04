class CfgPatches {
    class Claim_Vehicles {
        requiredAddons[]=
        {
            "exile_client"
        };
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
