RegisterNetEvent('khalid:showStatusUI', function(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openUI",
        data = data
    })
end)

RegisterNUICallback("joinServer", function(_, cb)
    SetNuiFocus(false, false)
    -- يمكنك تنفيذ كود الانضمام هنا أو إعادة الاتصال
    cb("ok")
end)

RegisterNUICallback("closeUI", function(_, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)
