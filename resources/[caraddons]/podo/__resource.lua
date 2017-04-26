resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

data_file 'HANDLING_FILE' 'podo/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'podo/vehicles.meta'
data_file 'CARCOLS_FILE' 'podo/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'podo/carvariations.meta'

files {
  'podo/handling.meta',
  'podo/vehicles.meta',
  'podo/carcols.meta',
  'podo/carvariations.meta',
}

client_script 'vehicle_name.lua'
