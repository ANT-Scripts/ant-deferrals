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