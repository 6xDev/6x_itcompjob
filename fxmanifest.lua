fx_version 'bodacious'
games { 'gta5' }
lua54 'yes'

author '6X Development'
description '[QB] 6x_itcompjob'
version '1.0.1'

client_scripts{
    'client/client.lua',
    'client/delivery.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua'
}