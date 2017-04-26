resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

data_file 'HANDLING_FILE' 'ndo/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'ndo/vehicles.meta'
data_file 'CARCOLS_FILE' 'ndo/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'ndo/carvariations.meta'

files {
  'ndo/handling.meta',
  'ndo/vehicles.meta',
  'ndo/carcols.meta',
  'ndo/carvariations.meta',
}

client_script 'vehicle_name.lua'
