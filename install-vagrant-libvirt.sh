#!/bin/bash
# Install kvm, vagrant and vagrant-libvirt plugin, and run a vm and connect to it
# execute: $ ssh root@<IP> 'curl -L http://bit.ly/16PJrrP | bash -s'

apt-get install -y kvm ubuntu-vm-builder libvirt-bin bridge-utils virtinst libvirt-dev libxslt-dev libxml2-dev

ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
wget http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.deb
dpkg -i vagrant_1.3.5_x86_64.deb
vagrant plugin install vagrant-libvirt
vagrant box add centos64 http://kwok.cz/centos64.box
mkdir test_libvirt
cd test_libvirt
cat > Vagrantfile << "EOF"
Vagrant.configure("2") do |config|

  # If you are still using old centos box, you have to setup root username for
  # ssh access. Read more in section 'SSH Access To VM'.
  config.ssh.username = "root"

  config.vm.define :test_vm do |test_vm|
    test_vm.vm.box = "centos64"
    test_vm.vm.network :private_network, :ip => '10.20.30.40'
  end

  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "qemu"
    libvirt.host = "localhost"
    libvirt.connect_via_ssh = true
    libvirt.username = "root"
    libvirt.storage_pool_name = "default"
  end
end
EOF
vagrant up --provider=libvirt
vagrant ssh
