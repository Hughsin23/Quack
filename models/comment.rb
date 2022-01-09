require_relative 'duck.rb'

def create_comment(content, user_id, duck_id) 
    duck_sql = "update ducks set comments_count = comments_count +1 where id = $1;"
    db_query(duck_sql, [duck_id])
    comment_sql = "insert into comments (content, user_id, duck_id) values ($1, $2, $3)"
    db_query(comment_sql, [content, user_id, duck_id])
end