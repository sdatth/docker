Under ./data/config/config.php make sure these lines are there

For port 91
'overwriteprotocol' => 'https',
'overwritehost' => 'nextcloud.example.com:91',
'overwrite.cli.url' => 'https://nextcloud.example.com:91',

For port 443
'overwriteprotocol' => 'https',
'overwritehost' => 'nextcloud.example.com',
'overwrite.cli.url' => 'https://nextcloud.example.com:443',
