
Vagrant.configure("2") do |config|
	
	config.vm.define "Linux14" do |node|
		node.vm.box= "ubuntu/trusty64"
		node.vm.hostname = "linux14"
		node.vm.provider "virtualbox" do |vb|
			vb.memory="1024"
		end
      node.vm.provision :shell, path: "bootstrap14.sh"
	end
	
	config.vm.define "Linux12" do |node|
		node.vm.box= "ubuntu/precise64"
		node.vm.hostname = "linux12"
		node.vm.provider "virtualbox" do |vb|
			vb.memory="1024"
		end
      node.vm.provision :shell, path: "bootstrap12.sh"
	end
	
	config.vm.define "Linux16" do |node|
		node.vm.box= "ubuntu/xenial64"
		node.vm.hostname = "linux16"
		node.vm.provider "virtualbox" do |vb|
			vb.memory="1024"
		end
      node.vm.provision :shell, path: "bootstrap16.sh"	  
	end
end
