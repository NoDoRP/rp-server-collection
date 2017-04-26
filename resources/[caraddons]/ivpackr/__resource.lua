resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

data_file 'HANDLING_FILE' 'commons/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'commons/vehicles.meta'
data_file 'CARCOLS_FILE' 'commons/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'commons/carvariations.meta'

files {
  'commons/handling.meta',
  'commons/vehicles.meta',
  'commons/carcols.meta',
  'commons/carvariations.meta',
}

client_script 'vehicle_names.lua'
