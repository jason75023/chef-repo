#search for data bags: users
search(:users, "*:*").each do |u|
  home_dir=u['home']
  if u['home'] != "/dev/null"
      directory "#{home_dir}/.ssh" do
        owner u['id']
        group u['gid'] || u['id']
        mode "0700"
      end
  end 
end

include_recipe "users::inject-key1"