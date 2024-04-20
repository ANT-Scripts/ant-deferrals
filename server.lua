local function createImageElement(url, size, horizontalAlignment)
    return {
        type = 'Image',
        url = url,
        size = size,
        horizontalAlignment = horizontalAlignment
    }
end

local function createTextBlockElement(text, weight, size, horizontalAlignment)
    return {
        type = 'TextBlock',
        text = text,
        weight = weight,
        size = size,
        horizontalAlignment = horizontalAlignment
    }
end

local function createActionSubmit(id, title)
    return {
        type = 'Action.Submit',
        id = id,
        title = title
    }
end

AddEventHandler('playerConnecting', function(pName, pKickReason, pDeferrals)
    local src = source
    
    pDeferrals.defer()

    Wait(1000)
    CreateThread(function()
        local breakLoop = false
        while true do
            local card = {
                type = 'AdaptiveCard',
                body = {
                    createImageElement('https://logos-world.net/wp-content/uploads/2021/03/FiveM-Logo.png', 'large', 'center'), -- Change 'small' for smaller size
                    {
                        type = 'Container',
                        items = {
                            {
                                type = 'ColumnSet',
                                columns = {
                                    {
                                        type = 'Column',
                                        width = 'stretch',
                                        items = {
                                            -- Left column content
                                            {
                                                type = 'TextBlock',
                                                text = string.format("**Passenger:** %s", pName),
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            },
                                            {
                                                type = 'TextBlock',
                                                text = '**Seat:** 12A',
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            },
                                            {
                                                type = 'TextBlock',
                                                text = '**Gate:** B12',
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            }
                                        }
                                    },
                                    {
                                        type = 'Column',
                                        width = 'stretch',
                                        items = {
                                            -- Right column content
                                            {
                                                type = 'TextBlock',
                                                text = '**Departure:** JFK',
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            },
                                            {
                                                type = 'TextBlock',
                                                text = '**Destination:** LAX',
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            },
                                            {
                                                type = 'TextBlock',
                                                text = '**Departure Time:** 10:00 AM',
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            }
                                        }
                                    }
                                }
                            },
                            {
                                type = 'ActionSet',
                                horizontalAlignment = 'Center',
                                actions = {
                                    createActionSubmit('submit_join', 'Join')
                                }
                            }
                        }
                    }
                }
            }
    
            pDeferrals.presentCard(card, function(pData, pRawData)
                if pData.submitId == 'submit_join' then
                    pDeferrals.update('✅ Connecting to server...')
                    Wait(1000)
                    pDeferrals.done()
                    print(('%s is connecting to the server'):format(pName))
                    breakLoop = true
                end
            end)

            if breakLoop then break end
    
            Wait(1000)
        end
    end)
end)