# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Box
  config.vm.box = "squeeze32-vanilla"
  config.vm.box_url = "https://dl.dropbox.com/u/2289657/squeeze32-vanilla.box"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # Make sure Chef is the latest version.
  config.omnibus.chef_version = :latest

  config.vm.hostname = "jrdev"
  config.vm.network :private_network, ip: "192.168.47.100"

  # Share the sites directory over NFS (if possible)
  sites_dir = "~/Sites"
  sites_mount_dir = "/mnt/sites"
  config.vm.synced_folder sites_dir, sites_mount_dir, :nfs => (RUBY_PLATFORM =~ /linux/ or RUBY_PLATFORM =~ /darwin/)

  # Provider config
  config.vm.provider "virtualbox" do |vb|
    # Set the memory size
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # Provisoning
  config.vm.provision "chef_solo" do |chef|
    chef.log_level = :debug if !(ENV['CHEF_DEBUG']).nil?
    chef.data_bags_path = "data_bags" if File.directory?(File.expand_path(File.dirname(__FILE__)) + "/data_bags")
    chef.run_list = [
      # Base
      "recipe[apt]",
      # Custom
      "recipe[jrdevsetup]"
    ]
    chef.json = {
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
    }
  end
end
