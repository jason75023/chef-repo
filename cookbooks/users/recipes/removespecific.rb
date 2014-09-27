#only search data bag with "remove" defined and remove it 
search(:users, "*:remove").each do |user_data|
    user user_data["id"] do 
        action :remove        
    end 
end
