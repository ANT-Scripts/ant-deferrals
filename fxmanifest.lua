fx_version 'cerulean'
game 'gta5'

author 'ANT Scripts'
version '1.0.0'

server_scripts {
    'functions.lua',
    'modules/rules_agreement.lua',
    --'modules/boarding_pass.lua'
}

escrow_ignore {
    'modules/*.lua',
    'functions.lua'
}