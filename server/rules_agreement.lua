local ANTConfig = {
    ServerName = "ANT Scripts",
    ServerImage = "https://cdn.discordapp.com/attachments/1185999786260828250/1185999837607493732/antScripts.jpg?ex=662e89ec&is=661c14ec&hm=4df8803e9923dc416d7dcf33de34d397184f0433a7fae98bdfbbaf1c4feee886&",
    Rules = "By clicking \"Agree to Rules\" you are affirming that you have read and understand \nthe Community Rules & Guidelines posted in our Discord Server. Failure to abide by the \nCommunity Rules & Guidelines could result in your dismissal from this community.",
    DiscordLink = "https://discord.gg/YDuUrSnH2W",
    ActionText = "Agree to Rules",
    ActionText2 = "Join Discord",
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
                    CreateImageElement(ANTConfig.ServerImage, 'Large', 'center'), -- Change 'small' for smaller size
                    {
                        type = 'Container',
                        height = '100px', -- Adjust the height as needed
                        items = {} -- Empty container to create space
                    },
                    {
                        type = 'Container',
                        items = {
                            CreateTextBlockElement("**Rules Agreement**", "Bolder", "Medium", "Center")
                        }
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
                                            CreateTextBlockElement(ANTConfig.Rules, "Lighter", "Medium", "Center")
                                        }
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
                        type = 'ActionSet',
                        horizontalAlignment = 'Center',
                        actions = {
                            CreateActionSubmit('accept_rules', ANTConfig.ActionText),
                            CreateActionOpenURL('open_discord', ANTConfig.ActionText2, ANTConfig.DiscordLink)
                        }
                    }
                }
            }
    
            pDeferrals.presentCard(card, function(pData, pRawData)
                if pData.submitId == 'accept_rules' then
                    pDeferrals.update('✅ Connecting to server...')
                    Wait(1000)
                    pDeferrals.done()
                    playerConnect(src, pDeferrals)
                    print(('%s is connecting to the server'):format(pName))
                    breakLoop = true
                end
            end)

            if breakLoop then 
                break
            end
            Wait(1000)
        end
    end)
end)