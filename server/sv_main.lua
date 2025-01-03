ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('enterDimension')
AddEventHandler('enterDimension', function(dimensionID)
    local _source = source
    SetPlayerRoutingBucket(source, dimensionID)
    print('araiwa1')
end)

RegisterServerEvent('exitDimension')
AddEventHandler('exitDimension', function(dimensionID)
    local _source = source
    SetPlayerRoutingBucket(source, dimensionID)
    print('araiwa2')
end)