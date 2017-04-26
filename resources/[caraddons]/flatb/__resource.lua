resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

data_file 'HANDLING_FILE' 'flat/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'flat/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'flat/carvariations.meta'

files {
  'flat/handling.meta',
  'flat/vehicles.meta',
  'flat/carvariations.meta',
}

client_script 'vehicle_names.lua'
