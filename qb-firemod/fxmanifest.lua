-- fxmanifest.lua

fx_version 'cerulean'
game 'gta5'

description 'QB Core Weapon Firemode Script'
version '1.0.0'

shared_script '@qb-core/import.lua'

client_scripts {
    'qb-weaponfiremode.lua'
}

server_scripts {
    'server.lua'
}

lua54 'yes'
