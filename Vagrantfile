# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
  else
    config.vm.synced_folder ".", "/vagrant"
  end
  config.vm.define "gfcdh1" do |d|
    d.vm.box = "bento/centos-7.6" 
    d.vm.hostname = "gfcdh1"
    d.vm.network "private_network", ip: "107.70.38.211"        
    d.vm.provider "virtualbox" do |v|        
      v.memory = 4096
      v.cpus = 1
    end
    d.vm.provision "shell", inline: <<-SHELL
         sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
         sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config 
         sudo yum clean all
         sudo yum clean metadata
         sudo yum clean dbcache
         sudo yum makecache
      SHELL
    d.vm.provision :shell, path: "scripts/post-deploy.sh" 
  end
  (2..3).each do |i|
    config.vm.define "gfcdh#{i}" do |d|
 #    d.vm.box = "bento/centos-7.6"
      d.vm.box = "robert0714/cdh-6.1.1-namenode"
      d.vm.hostname = "gfcdh#{i}"
      d.vm.network "private_network", ip: "107.70.38.21#{i}"
  #    d.vm.provision :shell, inline: "sudo apt-get install -y python"
      d.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 1
      end
      d.vm.provision "shell", inline: <<-SHELL
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config    
      SHELL
      d.vm.provision :shell, path: "scripts/post-deploy-namenode.sh" 
    end
  end  
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.no_install = true
    config.vbguest.no_remote = true
  end
end
