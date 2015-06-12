
guest_port        = 80                    # Guest port
host_port         = 8080                  # Host port
vm_name           = "Bolt-vagrant"        # VM Name
vm_ram            = "384"                 # VM RAM
db_password       = "root"                # Database password

Vagrant.configure("2") do |config|

  # Imagen de vagrant
  config.vm.box = "primalskill/ubuntu-trusty64"

  # Network config
  config.vm.network :forwarded_port, guest: guest_port, host: host_port, auto_correct: true
  config.vm.network :forwarded_port, guest: 8000, host: 8000, auto_correct: true

  # Shared folder config
  config.vm.synced_folder "./", "/var/www", create: true, group: "www-data", owner: "vagrant", mount_options: ['dmode=777', 'fmode=666']

  # Name, id and VM's RAM memory
  config.vm.provider "virtualbox" do |v|
    v.name = vm_name
    v.customize ["modifyvm", :id, "--memory", vm_ram]
  end

  #config.vm.provision "shell" do |s|
  #  s.path = "provision/setup.sh"
  #end

  config.vm.provision "shell", path: "provision/components/init.sh"
  config.vm.provision "shell", path: "provision/components/git.sh"
  config.vm.provision "shell", path: "provision/components/curl.sh"
  config.vm.provision "shell", path: "provision/components/php.sh"
  config.vm.provision "shell", path: "provision/components/nginx.sh"
  config.vm.provision "shell", path: "provision/components/mysql.sh",       args: [db_password]
  config.vm.provision "shell", path: "provision/components/phpmyadmin.sh",  args: [db_password]
  config.vm.provision "shell", path: "provision/components/zip.sh"
  config.vm.provision "shell", path: "provision/components/composer.sh"
  config.vm.provision "shell", path: "provision/components/bolt.sh"
  config.vm.provision "shell", path: "provision/components/postinstall.sh"

end
