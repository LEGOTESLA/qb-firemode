-- qb-weaponfiremode.lua

local QBCore = exports['qb-core']:GetCoreObject()

local fireModes = {
    single = {label = "Single Shot", rate = 1},
    burst = {label = "Burst Fire", rate = 3},
    auto = {label = "Automatic", rate = 10}
}

local currentFireMode = 'auto'

local function toggleFireMode()
    if currentFireMode == 'auto' then
        currentFireMode = 'single'
    elseif currentFireMode == 'single' then
        currentFireMode = 'burst'
    else
        currentFireMode = 'auto'
    end
    QBCore.Functions.Notify("Fire mode switched to: " .. fireModes[currentFireMode].label)
end

local function fireWeapon()
    local playerPed = PlayerPedId()
    local weaponHash = GetSelectedPedWeapon(playerPed)
    local fireRate = fireModes[currentFireMode].rate

    if currentFireMode == 'single' then
        Citizen.Wait(1000 / fireRate)
        SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
    elseif currentFireMode == 'burst' then
        Citizen.Wait(1000 / fireRate)
        SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
    elseif currentFireMode == 'auto' then
        SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
    end

    TriggerServerEvent('qb-weaponfiremode:syncFireMode', currentFireMode)
end

RegisterCommand('firemode', function()
    toggleFireMode()
end, false)

AddEventHandler('weaponFireMode:fireWeapon', function()
    fireWeapon()
end)

RegisterNetEvent('qb-weaponfiremode:syncFireMode')
AddEventHandler('qb-weaponfiremode:syncFireMode', function(fireMode)
    currentFireMode = fireMode
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedShooting(PlayerPedId()) then
            TriggerEvent('weaponFireMode:fireWeapon')
        end
    end
end)
