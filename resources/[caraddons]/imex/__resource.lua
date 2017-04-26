resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

data_file 'VEHICLE_LAYOUTS_FILE' 'imex/vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'imex/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'imex/vehicles.meta'
data_file 'CARCOLS_FILE' 'imex/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'imex/carvariations.meta'

files {
  'imex/vehiclelayouts.meta',
  'imex/handling.meta',
  'imex/vehicles.meta',
  'imex/carcols.meta',
  'imex/carvariations.meta',
}

client_script 'vehicle_names.lua'
