fx_version 'bodacious'
game 'common'

server_script "server/sv_queue_config.lua"
server_script "connectqueue.lua"
server_script "functions.lua"
server_script "shared/sh_queue.lua"

client_script "shared/sh_queue.lua"

-- Uncomment the deferral you wish to use
--server_script "server/rules_agreement.lua"
server_script "server/boarding_pass.lua"