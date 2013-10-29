name "vagrant"
description "Vagrant"
default_attributes({
  "avahi" => {
    "deny_interfaces" => [ "eth0" ]
  },
  "mysql" => {
    "bind_address" => "0.0.0.0",
    "server_root_password" => "root",
    "server_debian_password" => "debpass",
    "server_repl_password" => "replpass",
    "tunable" => {
      "innodb_buffer_pool_size" => "128M",
      "key_buffer_size" => "16M"
    }
  }
})
