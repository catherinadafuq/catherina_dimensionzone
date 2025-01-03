ESX = exports['es_extended']:getSharedObject()

local inZones = {}
local activeZone = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i, zone in ipairs(Config.Zones) do
            local distance = #(playerCoords - zone.center)

            if distance <= 100.0 then 
                Citizen.Wait(0) 

                if Config.OpenDrawMarker == true then
                    DrawMarker(43, zone.center.x, zone.center.y, zone.center.z - 0.0, 15.0, 8.0, 0.0, 0.0, 0.0, 0.0, zone.radius * 2, zone.radius * 2, 1.0, 0, 255, 0, 100, false, false, 2, false, nil, nil, false)
                end

                if distance <= zone.radius then
                    if not inZones[i] then
                        inZones[i] = true
                        playMusicFromConfig(zone)
                        applyZoneWeather(zone)
                        TriggerServerEvent('enterDimension', zone.dimensionID)
                    end
                else
                    if inZones[i] then
                        inZones[i] = false
                        TriggerServerEvent('exitDimension', 0)
                        SendNUIMessage({ action = 'showMusicPlayer', play = false })
                        stopMusic()
                        resetWeather()
                    end
                end
            end
        end
    end
end)

function applyZoneWeather(zone)
    if zone.weather then
        local weatherType = zone.weather.type
        local weatherPersist = zone.weather.persist or true 
        SetWeatherTypeNowPersist(weatherType) 
        if weatherPersist then
            Citizen.CreateThread(function()
                while activeZone and Config.Zones[activeZone] and Config.Zones[activeZone].weather.type == weatherType do
                    SetWeatherTypeNowPersist(weatherType)
                    Citizen.Wait(5000)
                end
            end)
        end
    end
end

function resetWeather()
    ClearWeatherTypePersist()
    SetWeatherTypeNowPersist('CLEAR') 
end

function playMusicFromConfig(zone)
    if zone.sounds and zone.sounds.enter then
        local soundFile = zone.sounds.enter.file
        local volume = zone.sounds.enter.volume
        SendNUIMessage({
            action = 'play',
            name = soundFile,
            volume = volume   
        })
    end
end


function stopMusic()
    SendNUIMessage({
        action = 'stop'
    })
end
