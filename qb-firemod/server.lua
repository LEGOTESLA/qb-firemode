-- server.lua

local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-weaponfiremode:syncFireMode')
AddEventHandler('qb-weaponfiremode:syncFireMode', function(fireMode)
    local src = source
    TriggerClientEvent('qb-weaponfiremode:syncFireMode', src, fireMode)
end)
