#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "httpd" do 
	action :install
end	

#cookbook_file "/var/www/html/index.html" do 
#    source node["apache"]["indexfile"]
#    mode "0644" 
#end 	

#Use execute resource to stop Default Web site if running 
execute "mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.disabled" do 
  only_if do
    File.exist?("/etc/httpd/conf.d/welcome.conf")
  end
  notifies :restart, "service[httpd]"
end

#ruby loop through attributes define in /cookbooks/apache/attributes/default.rb
#default["apache"]["sites"]["clowns"] = { "port" => 80 }
#default["apache"]["sites"]["bears"] = { "port" => 81 }
# To reference a variable  => #{variable}
#site_name = "clowns"/ site_name="bears"  
# #{site_name} to reference variable content:   "clowns" , "bears"
#site_data = { "port" => 80 }/site_data =  { "port" => 81 }
# site_data["port"] to reference hash value: 80, 81
node["apache"]["sites"].each do |site_name, site_data|
    document_root = "/srv/apache/#{site_name}"

    #create a directory 
    #chmod  -r 755 <new directory> 
    directory document_root do
        mode "0755"
        recursive true
    end

    # Add a template for Apache virtual host configuration
    # define template variable: :document_root, :port  
    template "/etc/httpd/conf.d/#{site_name}.conf" do
     source "custom.erb"
     mode "0644"
     variables(
      :document_root => document_root,
      :port => site_data["port"]
     )
     notifies :restart, "service[httpd]"
    end
    
    # Add a template resource for the virtual hosts's web page index.html
    template "#{document_root}/index.html" do
    source "index.html.erb"
    mode "0644"
    variables(
      :site_name => site_name,
      :port => site_data["port"]
    )
  end
end

service "httpd" do 
	action [ :enable, :start ]
end
