require_relative 'duck.rb'


def liked?(user_id)
    sql = "select * from likes where user_id = $1 and duck_id = $2"
    result = db_query(sql, [current_user.id, duck['id']])
    if result.count > 0 
        return true
    else
        return false
    end
end

