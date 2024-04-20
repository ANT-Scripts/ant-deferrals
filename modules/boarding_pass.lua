local Config = {
    ServerImage = "https://cdn.discordapp.com/attachments/1185999786260828250/1185999837607493732/antScripts.jpg?ex=662e89ec&is=661c14ec&hm=4df8803e9923dc416d7dcf33de34d397184f0433a7fae98bdfbbaf1c4feee886&",

    Seat = "12A",
    Gate = "B12",
    Departure = "JFK",
    Destination = "LSX",
    DepartureTime = "<1 Minute",
    ActionText = "Join ANT Scripts",
}

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
                    CreateImageElement(Config.ServerImage, 'Large', 'center'), -- Change 'small' for smaller size
                    {
                        type = 'Container',
                        height = '100px', -- Adjust the height as needed
                        items = {} -- Empty container to create space
                    },
                    {
                        type = 'Container',
                        height = '100px', -- Adjust the height as needed
                        items = {} -- Empty container to create space
                    },
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
                                                text = string.format("**Seat:** %s", Config.Seat),
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            },
                                            {
                                                type = 'TextBlock',
                                                text = string.format("**Gate:** %s", Config.Gate),
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
                                                text = string.format("**Departure:** %s", Config.Departure),
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            },
                                            {
                                                type = 'TextBlock',
                                                text = string.format("**Destination:** %s", Config.Destination),
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            },
                                            {
                                                type = 'TextBlock',
                                                text = string.format("**Departure Time:** %s", Config.DepartureTime),
                                                weight = 'Lighter',
                                                size = 'Medium',
                                                horizontalAlignment = 'Left'
                                            }
                                        }
                                    }
                                }
                            },
                            {
                                type = 'Container',
                                height = '100px', -- Adjust the height as needed
                                items = {} -- Empty container to create space
                            },
                            {
                                type = 'Container',
                                height = '100px', -- Adjust the height as needed
                                items = {} -- Empty container to create space
                            },
                            {
                                type = 'ActionSet',
                                horizontalAlignment = 'Center',
                                actions = {
                                    CreateActionSubmit('submit_join', string.format("%s", Config.ActionText))
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