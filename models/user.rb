require_relative 'duck.rb'
require 'bcrypt'

def create_user(email, password)
    sql = "INSERT INTO users (email, password_digest) values ($1, $2);"
    password_digest = BCrypt::Password.create(password)
    db_query(sql, [
        email,
        password_digest
    ])
end

def find_user_id(email)
    db_query('select * from users where email = $1;', [email]).first['id']
end

def find_user_email(id)
    db_query('select * from users where id = $1;', [id]).first['email']
end
