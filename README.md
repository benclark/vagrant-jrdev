# jrdev Vagrant

This is a template for a Vagrant setup that can be used in two different modes, either within a single project, or a standalone configuration that supports multiple projects.

# Requirements

* [VirtualBox](http://www.virtualbox.org) (4.3.0 or better)
* [Vagrant](http://www.vagrantup.com) (1.3.5 or better)
* [Berkshelf](http://berkshelf.com) (2.0.10 or better)

The following Vagrant plugins are expected:

* [vagrant-berkshelf](https://github.com/riotgames/vagrant-berkshelf) (1.3.3 or better)
* [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus) (1.1.1 or better)

# Usage

## Single project

Add the following files from this repo to your Drupal project's root directory:

* `Vagrantfile`
* `Berksfile`

At a minimum, make the following edits to your `Vagrantfile` to customize it to your project:

    # Replace "jrdev" with a hostname-safe name for your project.
    config.vm.hostname = "YOURPROJECT"

    chef.json["jrdevsetup"] = {
      # Set "domain_name" to a hostname-safe name (will be used by Avahi)
      "domain_name" => "YOURPROJECT.local",
      "docroot" => "/var/www/vhosts/default"
    }

Run the following:

    $ vagrant up --provision

## Multi-project

Clone this repo:

    $ git clone https://github.com/JacksonRiver/vagrant-jrdev.git

Create a `data_bags` directory, and populate it with JSON data:

    $ mkdir data_bags
    $ cat - > example.json
    {
      "id": "example",
      "domain_name": "example.local",
      "domain_aliases": [ "example1.local", "example2.local" ],
      "docroot": "/mnt/sites/example/repo",
      "db_name": "example"
    }
    ^D

You can create any number of JSON files.

Make sure that the `sites_dir` in the `Vagrantfile` points to a directory where all your Drupal sites reside. Using the `example.json` project defined above, if your directory structure looks like this:

    /Users
      /exampleuser
        /Sites
          /example
            /repo
              # Drupal root

Then you would modify the `Vagrantfile` accordingly:

    sites_dir = "/Users/exampleuser/Sites"

Run the following:

    $ vagrant up --provision

# Author

Author:: Ben Clark (benjamin.clark@jacksonriver.com)
