# -*- mode: ruby -*-
# vi: set ft=ruby :

var_box = "generic/rocky8"

Vagrant.configure("2") do |config|
  
  config.vm.define "node_aws_pgd" do |nodes|
    nodes.vm.box = var_box
    nodes.vm.hostname= "nodeawspgd"
    #MacOS workaround for VirtualBox 7
    nodes.vm.network "private_network", ip: "192.168.1.10", name: "HostOnly", virtualbox__intnet: true
    nodes.vm.provider "virtualbox" do |v|
      v.memory = "512"
      v.cpus = "1"
      v.name = "vm_aws_pgd"
    end
    
    nodes.vm.synced_folder ".", "/vagrant"
    nodes.vm.provision "shell", inline: <<-SHELL
      sudo sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
      echo -e "root\nroot" | passwd root
      sudo systemctl restart sshd
      echo "******************************************************************************"
      echo "Bat installation." `date`
      echo "https://www.geekpills.com/operating-system/linux/bat-advance-cat-in-linux"
      echo "******************************************************************************"
      rpm -ivh http://repo.openfusion.net/centos7-x86_64/bat-0.7.0-1.of.el7.x86_64.rpm 
      cat >~/.bash_profile<<EOF
alias cat="bat -pp"
EOF
    SHELL
  end
end
