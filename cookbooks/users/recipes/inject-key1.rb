search(:users, "*:*").each do |u|
  home_dir=u['home']
   if u['ssh_keys'] != "/dev/null"
        template "#{home_dir}/.ssh/authorized_keys" do
          source "authorized_keys.erb"
          owner u['id']
          group u['gid'] || u['id']
          mode "0600"
          variables(
          	:ssh_key => u['ssh_keys']
          ) 
        end
   end
end