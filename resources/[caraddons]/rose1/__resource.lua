resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

data_file 'HANDLING_FILE' 'rose/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'rose/vehicles.meta'
data_file 'CARCOLS_FILE' 'rose/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rose/carvariations.meta'

files {
  'rose/handling.meta',
  'rose/vehicles.meta',
  'rose/carcols.meta',
  'rose/carvariations.meta',
}

client_script 'vehicle_names.lua'
