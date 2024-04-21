local playerQueue = {} -- Queue to hold players attempting to connect
local isProcessingQueue = false -- Flag to indicate if the queue is being processed

function CreateImageElement(url, size, horizontalAlignment)
    return {
        type = 'Image',
        url = url,
        size = size,
        horizontalAlignment = horizontalAlignment
    }
end

function CreateTextBlockElement(text, weight, size, horizontalAlignment)
    return {
        type = 'TextBlock',
        text = text,
        weight = weight,
        size = size,
        horizontalAlignment = horizontalAlignment
    }
end

function CreateActionSubmit(id, title)
    return {
        type = 'Action.Submit',
        id = id,
        title = title
    }
end

function CreateActionOpenURL(id, title, url)
    return {
        type = 'Action.OpenUrl',
        id = id,
        title = title,
        url = url
    }
end

-- Function to process the player queue
function processQueue()
    isProcessingQueue = true
    while #playerQueue > 0 do
        local player = table.remove(playerQueue, 1) -- Remove the first player from the queue
        local pName, pDeferrals = player.name, player.deferrals
        pDeferrals.defer()
        Wait(1000)
        presentCard(pName, pDeferrals) -- Present the adaptive card to the player
        Wait(1000)
    end
    isProcessingQueue = false
end

-- Function to add a player to the queue
function addToQueue(pName, pDeferrals)
    local maxPlayers = GetConvarInt("sv_maxclients", 30) -- Get the maximum number of players allowed on the server
    local currentPlayers = #GetPlayers() -- Get the current number of players on the server

    if currentPlayers <= maxPlayers then
        pDeferrals.done("❌ Server is at maximum capacity.") -- Inform the player that the server is at maximum capacity
        return
    end

    table.insert(playerQueue, {name = pName, deferrals = pDeferrals})
    if not isProcessingQueue then
        processQueue() -- Start processing the queue if it's not being processed already
    end
end