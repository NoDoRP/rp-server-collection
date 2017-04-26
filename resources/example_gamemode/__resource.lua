resource_type 'gametype' { name = 'es_example_gamemode' }

-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Requiring essentialmode
dependency 'essentialmode'

-- General
client_script 'client.lua'
server_script 'server.lua'