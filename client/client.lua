ESX = nil
ESX = exports['es_extended']:getSharedObject()

_menuPool = NativeUI.CreatePool()

CreateThread(function()
    while true do
        Wait(1)
        if _menuPool:IsAnyMenuOpen() then
            _menuPool:ProcessMenus()
        else
            Wait(150)
        end
    end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Blip) do 
        local blip = AddBlipForCoord(Config.Position.x, Config.Position.y, Config.Position.z)
        SetBlipSprite(blip, v.BlipNumber)
        SetBlipScale (blip, 0.7)
        SetBlipColour(blip, v.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(v.BlipLabel)
        EndTextCommandSetBlipName(blip)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 
        local playerPed = PlayerPedId()
        local playercoords = GetEntityCoords(playerPed)
        local distance = Vdist(playercoords, Config.Position.x, Config.Position.y, Config.Position.z)
        if distance < 12 then 
            DrawMarker(1, Config.Position.x, Config.Position.y, Config.Position.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.5, 0, 191, 255, 100, false, true, 2, false, nil, nil, false)
            if distance < 2.0 then 
                ESX.ShowHelpNotification(Translation[Config.Locale]['showhelp'], true)
                if IsControlJustReleased(0, 38) then
                    if distance < 1.0 then
                        OpenMenu()
                    end
                end
            end
        end
    end
end)

function OpenMenu()
     mainmenu = NativeUI.CreateMenu('Job-Center', 'Script by AMS-Modding')
    
    _menuPool:Add(mainmenu)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    mainmenu:Visible(true)
    local item = NativeUI.CreateItem("Job Liste", "")
    item.Activated = function(sender, index)
        _menuPool:CloseAllMenus()
        OpenLogistikMenu()
    end
    item:RightLabel('>>>')
    mainmenu:AddItem(item)
end

function OpenLogistikMenu()
     mainmenu = NativeUI.CreateMenu('Jobliste', 'Jobcenter by KxinMensch')
    
    _menuPool:Add(mainmenu)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    mainmenu:Visible(true)

    local deny = NativeUI.CreateItem("~r~Derzeitigen Job kündigen!", "Kündige deinen derzeitigen Job")
    deny.Activated = function(sender, index)
        TriggerServerEvent('kxin_jobcentre:setJob', 'unemployed', '0')
        if Config.useESX then
            ESX.ShowNotification(Translation[Config.Locale]['unemployed'])
        else
            notify(Translation[Config.Locale]['unemployed'])
        end
    end
    mainmenu:AddItem(deny)

    for k, v in pairs(Config.Jobs) do
        local jobs = NativeUI.CreateItem("" .. v.Label .. "", "" .. v.Description .. "")
        jobs.Activated = function(sender, index)
            TriggerServerEvent('kxin_jobcentre:setJob', v.Value, v.grade)
            if Config.Locale == 'de' then
                ESX.ShowNotification('Du hast jetzt den Job ~y~' .. v.Label .. '!')
            else
                notify('You have now the Job: ~y~' .. v.Label .. '!')
            end
        end
        mainmenu:AddItem(jobs)
    end

end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true,false)
end