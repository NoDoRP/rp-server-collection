resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

data_file 'HANDLING_FILE' 'tyrus/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'tyrus/vehicles.meta'
data_file 'CARCOLS_FILE' 'tyrus/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'tyrus/carvariations.meta'

files {
  'tyrus/handling.meta',
  'tyrus/vehicles.meta',
  'tyrus/carcols.meta',
  'tyrus/carvariations.meta',
}

client_script 'vehicle_name.lua'
