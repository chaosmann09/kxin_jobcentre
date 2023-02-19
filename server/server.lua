ESX = nil
ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('kxin_jobcentre:setJob')
AddEventHandler('kxin_jobcentre:setJob', function(job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setJob(job, grade)
end) 
