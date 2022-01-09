require_relative 'duck.rb'


def like_duck(user_id, duck_id)
    duck_sql = "update ducks set likes_count = likes_count +1 where id = $1;" #CAN experiment cutting this down to one line later, adding this to the like_sql and just using $2
    db_query(duck_sql, [duck_id])
    like_sql = "insert into likes (user_id, duck_id) values ($1, $2);"
    db_query(like_sql, [user_id, duck_id])
end

def unlike_duck(user_id, duck_id)
    duck_sql = "update ducks set likes_count = likes_count -1 where id = $1;"
    db_query(duck_sql,[duck_id])
    unlike_sql = "delete from likes where user_id = $1 and duck_id = $2"
    db_query(unlike_sql, [user_id, duck_id])
end

def liked?(user_id, duck_id)
    sql = "select * from likes where user_id = $1 and duck_id = $2;"
    result = db_query(sql, [user_id, duck_id])
    if result.count > 0 
        return true
    else
        return false
    end
end

def not_liked?(user_id, duck_id) #i know this is redundant but I was scared about what was said about ruby not wanting to deal with ! statements
    sql = "select * from likes where user_id = $1 and duck_id = $2;"
    result = db_query(sql, [user_id, duck_id])
    if result.count > 0 
        return false
    else
        return true
    end
end


