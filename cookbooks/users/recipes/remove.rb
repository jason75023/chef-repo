search(:users, "*:*").each do |user_data|
    user user_data["id"] do 
        action :remove        
    end 
end

include_recipe "users::groups-remove"