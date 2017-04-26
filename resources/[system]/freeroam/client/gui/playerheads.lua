Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        --323 x 324 c 321 space 320 v 326 lctrl
        --N_0xdea2b8283baa3944(p0) set_head_display_string
        --N_0x63bb75abedc1f6a0(p0, p1, p2) set_head_display_flag
        --N_0xbfefe3321a3f5015(p0, p1, p2, p3, p4, p5) creare_ped_head_display
        for i = 0,100 do
            if GetPlayerName(GetPlayerIndex()) ~= GetPlayerName(GetPlayerFromServerId(i)) and NetworkIsPlayerActive(GetPlayerFromServerId(i)) then
                ped = GetPlayerPed(GetPlayerFromServerId(i))
                headDisplayId = N_0xbfefe3321a3f5015(ped, GetPlayerName(GetPlayerFromServerId(i)), 0, 0, " ", 0)
                N_0x63bb75abedc1f6a0(headDisplayId, 0, 1)
            end
        end
 
    end
end)