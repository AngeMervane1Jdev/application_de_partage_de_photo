server '44.195.63.242', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/ange/.ssh/id_rsa'