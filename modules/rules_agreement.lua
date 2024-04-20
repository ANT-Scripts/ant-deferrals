local Config = {
    ServerName = "ANT Scripts",
    ServerImage = "https://cdn.discordapp.com/attachments/1185999786260828250/1185999837607493732/antScripts.jpg?ex=662e89ec&is=661c14ec&hm=4df8803e9923dc416d7dcf33de34d397184f0433a7fae98bdfbbaf1c4feee886&",
    Rules = "By clicking \"Agree to Rules\" you are affirming that you have read and understand \nthe Community Rules & Guidelines posted in our Discord Server. Faulure to abide by the \nCommunity Rules & Guidelines could result in your dismissal form this community.",
    DiscordLink = "https://discord.gg/YDuUrSnH2W",
    ActionText = "Agree to Rules",
    ActionText2 = "Join Discord",
}

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

local function createActionOpenURL(id, title, url)
    return {
        type = 'Action.OpenUrl',
        id = id,
        title = title,
        url = url
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
                    createImageElement(Config.ServerImage, 'Large', 'center'), -- Change 'small' for smaller size
                    {
                        type = 'Container',
                        height = '100px', -- Adjust the height as needed
                        items = {} -- Empty container to create space
                    },
                    {
                        type = 'Container',
                        items = {
                            createTextBlockElement("**Rules Agreement**", "Bolder", "Medium", "Center")
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
                                            createTextBlockElement(Config.Rules, "Lighter", "Medium", "Center")
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
                            createActionSubmit('accept_rules', Config.ActionText),
                            createActionOpenURL('open_discord', Config.ActionText2, Config.DiscordLink)
                        }
                    }
                }
            }
    
            pDeferrals.presentCard(card, function(pData, pRawData)
                if pData.submitId == 'accept_rules' then
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