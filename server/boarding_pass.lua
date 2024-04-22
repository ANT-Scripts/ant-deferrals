local BoardingPassConfig = {
    ServerName = "ANT Scripts",
    ServerImage = "https://cdn.discordapp.com/attachments/1185999786260828250/1185999837607493732/antScripts.jpg?ex=662e89ec&is=661c14ec&hm=4df8803e9923dc416d7dcf33de34d397184f0433a7fae98bdfbbaf1c4feee886&",
    DiscordLink = "https://discord.gg/YDuUrSnH2W",
    FlightNumber = "ANT24",
    DepartureAirport = "IND (Indianapolis)",
    ArrivalAirport = "LSX (Los Santos)",
    DepartureTime = function()
        return os.date("%I:%M %p") -- Format: 12-hour, with AM/PM
    end,
    ArrivalTime = "<2 Minutes",
    SeatNumber = "12A",
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
                    {
                        type = 'Container',
                        style = 'default', -- Add emphasis style to make the header stand out
                        background = 'light',
                        items = {
                            CreateTextBlockElement("**Boarding Pass**", "Bolder", "Large", "Center"),
                        }
                    },
                    {
                        type = 'Container',
                        items = {
                            CreateImageElement(BoardingPassConfig.ServerImage, 'Large', 'Center') -- Server Image
                        }
                    },
                    {
                        type = 'Container',
                        style = 'default',
                        background = 'light',
                        items = {
                            CreateTextBlockElement("**Passenger Name:** " .. pName, "Lighter", "Medium", "Center"),
                            CreateTextBlockElement("**Flight:** " .. BoardingPassConfig.FlightNumber, "Lighter", "Medium", "Center"),
                            CreateTextBlockElement("**Seat:** " .. BoardingPassConfig.SeatNumber, "Lighter", "Medium", "Center")
                        }
                    },                    
                    {
                        type = 'Container',
                        style = 'default',
                        background = 'light',
                        items = {
                            CreateTextBlockElement("**Departure Location:** " .. BoardingPassConfig.DepartureAirport, "Lighter", "Medium", "Center"),
                            CreateTextBlockElement("**Departure Time:** " .. BoardingPassConfig.DepartureTime(), "Lighter", "Medium", "Center")
                        }
                    },
                    {
                        type = 'Container',
                        style = 'default',
                        background = 'light',
                        items = {
                            CreateTextBlockElement("**Arrival Location:** " .. BoardingPassConfig.ArrivalAirport, "Lighter", "Medium", "Center"),
                            CreateTextBlockElement("**Arrival Time:** " .. BoardingPassConfig.ArrivalTime, "Lighter", "Medium", "Center")
                        }
                    },
                    {
                        type = 'ActionSet',
                        horizontalAlignment = 'Center',
                        actions = {
                            CreateActionSubmit('accept_boarding', "Check-In"),
                            CreateActionOpenURL('open_discord', "Join Discord", BoardingPassConfig.DiscordLink)
                        }
                    }
                }
            }            
            pDeferrals.presentCard(card, function(pData, pRawData)
                if pData.submitId == 'accept_boarding' then
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