fx_version 'cerulean'
game 'gta5'

name "shabado_itemsell"
description 'sell locatios for any item'
author "Shabado"
version '1.0.0'

shared_script 'config.lua'

client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'qb-core',
    'qb-target',
    'qb-menu'
}