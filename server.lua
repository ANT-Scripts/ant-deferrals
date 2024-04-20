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
                    {
                        type = 'Container',
                        items = {
                            createImageElement('https://logos-world.net/wp-content/uploads/2021/03/FiveM-Logo.png', 'large', 'center'),
                            createTextBlockElement(('Welcome, %s'):format(pName), 'Light', 'large', 'center'),
                            {
                                type = 'ActionSet',
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