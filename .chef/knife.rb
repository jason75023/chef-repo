# See http://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "jw7698"
client_key               "#{current_dir}/jw7698.pem"
validation_client_name   "attchefpractice-validator"
validation_key           "#{current_dir}/attchefpractice-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/attchefpractice"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
