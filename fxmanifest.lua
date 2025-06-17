fx_version 'cerulean'
game 'gta5'

author 'LeXarDev'
description 'QBCore Server Status UI'
version '1.0.0'

shared_script '@qb-core/shared/locale.lua'

client_script 'client.lua'
server_script 'server.lua'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}