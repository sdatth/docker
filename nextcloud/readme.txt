Under ./data/config/config.php make sure these lines are there

'trusted_domains' =>
  array (
    0 => 'nc.home.example.com',
    1 => 'nc.home.example.com:91',
    2 => 'nc.www.example.com',
  ),

'trusted_proxies' =>
  array (
    0 => 'traefik',
    1 => 'pangolin',
  ),

'forwarded_for_headers' =>
  array (
    0 => 'HTTP_X_FORWARDED_FOR',
    1 => 'HTTP_X_FORWARDED_PROTO',
    2 => 'HTTP_X_FORWARDED_HOST',
  ),

'overwriteprotocol' => 'https',

// IMPORTANT: remove overwritehost
// IMPORTANT: remove overwrite.cli.url
