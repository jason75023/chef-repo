search(:groups, "*:*").each do |group_data|
    group group_data["id"] do 
        action :remove       
    end 
end
