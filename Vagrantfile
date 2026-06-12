# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

NODES = [
  { name: "appserver", ip: "192.168.56.10", memory: 1024, cpus: 2, disk: "appserver-disk.qcow2" },
  { name: "monitoring",       ip: "192.168.56.11", memory: 1024, cpus: 1, disk: "monitoring-disk.qcow2"       },
  { name: "cicd",       ip: "192.168.56.12", memory: 1024, cpus: 1, disk: "cicd-disk.qcow2"       },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.box_check_update = false

  NODES.each do |node|
    config.vm.define node[:name] do |vm|
      vm.vm.hostname = node[:name]
      vm.vm.network "private_network", ip: node[:ip]

      vm.vm.provider :libvirt do |lv|
        lv.memory   = node[:memory]
        lv.cpus     = node[:cpus]
        lv.disk_bus = "virtio"
        lv.storage :file, size: "20G", path: node[:disk]
      end

      if node[:name] == "appserver"
        vm.vm.synced_folder "/home/gibril/ansible_pub",
          "/vagrant/ssh-keys",
          type: "rsync",
          rsync__exclude: [".git/"]

        vm.vm.synced_folder "/home/gibril/DevOps/devops-lab",
          "/home/vagrant/devops-lab",
          type: "rsync",
          rsync__exclude: [".git/"]

        vm.vm.network "forwarded_port", guest: 80,   host: 8090
        vm.vm.network "forwarded_port", guest: 8080, host: 8095
        vm.vm.provision "shell", path: "install-docker.sh"
      end

    end
  end
end
