local webhookURL = "https://discord.com/api/webhooks/xxxx/xxxx"

-- وظيفة ترسل حالة السيرفر
local function SendServerStatus()
    local players = GetPlayers()
    local police, ambulance = 0, 0

    for _, id in pairs(players) do
        local xPlayer = QBCore.Functions.GetPlayer(tonumber(id))
        if xPlayer then
            local job = xPlayer.PlayerData.job.name
            if job == "police" then
                police = police + 1
            elseif job == "ambulance" then
                ambulance = ambulance + 1
            end
        end
    end

    local total = #players
    local civilians = total - police - ambulance

    local data = {
        total = total,
        police = police,
        ambulance = ambulance,
        civilians = civilians,
        discord = "https://discord.gg/xxxxx",
    }

    -- إرسال لكل اللاعبين
    for _, id in pairs(players) do
        TriggerClientEvent('khalid:showStatusUI', tonumber(id), data)
    end

    -- إرسال إلى Webhook
    PerformHttpRequest(webhookURL, function() end, 'POST', json.encode({
        username = "📡 QBCore Server Monitor",
        avatar_url = "https://i.imgur.com/2nCt3Sbl.png",
        embeds = {{
            title = "📊 اسم سيرفرك ",
            description = "تم تحديث معلومات السيرفر تلقائيًا كل 5 دقائق.",
            color = 65280,
            fields = {
                { name = "👥 عدد اللاعبين", value = tostring(total), inline = true },
                { name = "👮 الشرطة", value = tostring(police), inline = true },
                { name = "🚑 الإسعاف", value = tostring(ambulance), inline = true },
                { name = "🧑‍🤝‍🧑 المدنيين", value = tostring(civilians), inline = true },
                { name = "🔗 رابط السيرفر", value = "[اضغط هنا للدخول](fivem://connect/your-server-ip:port)", inline = false }
            },
            footer = {
                text = "🕒 التحديث في: " .. os.date("%Y/%m/%d %H:%M:%S")
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }), {
        ['Content-Type'] = 'application/json'
    })
end

-- حلقة كل 5 دقائق
CreateThread(function()
    while true do
        Wait(300000) -- 5 دقائق = 300,000 مللي ثانية
        SendServerStatus()
    end
end)

-- (اختياري) عند دخول لاعب، حدث له مباشرة
AddEventHandler('playerConnecting', function()
    SetTimeout(10000, function() -- أعطه 10 ثواني حتى يدخل تماماً
        SendServerStatus()
    end)
end)