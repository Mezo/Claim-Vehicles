class ClaimVehicle: ExileAbstractAction
{
    title = "Claim Ownership";
    condition = "true";
    action = "call ExileClient_ClaimVehicles_network_claimRequestSend";
};
