require 'pg'

def db_query(sql, params = [])
    conn = PG.connect(ENV['DATABASE_URL'] || {dbname: 'show_us_your_quack'})
  
    result = conn.exec_params(sql, params) # exec_params will always return an array
    conn.close
    return result
end

def show_all_ducks 
    db_query('select * from ducks order by id;')
end

def create_duck(name, image_url, location_spotted, user_id, likes_count, comments_count)

    sql = "INSERT INTO ducks (name, image_url, location_spotted, user_id, likes_count, comments_count) values ($1, $2, $3, $4, $5, $6);"
    db_query(sql, [
        name,
        image_url,
        location_spotted,
        user_id,
        likes_count,
        comments_count
    ])
end

def delete_duck(id)
    db_query("delete from ducks where id = $1;", [id])
end

def update_duck(name, image_url, location_spotted, id)

    sql = "UPDATE ducks set name = $1, image_url = $2, location_spotted = $3 where id = $4"
    db_query(sql, [
        name,
        image_url,
        location_spotted,
        id
    ])
end

def all_ducks
    db_query('select * from ducks order by id;')
end

def random_five_ducks()
    sql = "select * from ducks order by RANDOM() LIMIT 5;"
    db_query(sql)
end

def find_duck(id)
    sql = "select * from ducks where id = $1;"
    db_query(sql, [id])
end