
require 'sinatra'
require 'sinatra/reloader' #stops and restarts your app when you change your code
require 'pg' # we need these functions to talk to the db
require 'pry' #allows us to use commands like binding.pry to debug
require 'bcrypt' # allows us to use the encryption digestion for passwords
require 'cloudinary'

cloudinary_options = { # this is for cloudinary to allow the storing of pictures (HOW WILL THIS WORK WHEN ITS HOSTED ON THE CLOUD? NEED A SECRET FILE SOMEWHERE MAYBE?)
    cloud_name: 'dciyilvza',
    api_key: ENV['CLOUDINARY_API_KEY'],
    api_secret: ENV['CLOUDINARY_API_SECRET']
}

enable :sessions #this allows us to create a login session for the user

  # MY RESOURCES - Users, ducks, likes, comments
  # Likes, comments and ducks can BELONG to a user

require_relative 'models/duck.rb'
require_relative 'models/user.rb'
require_relative 'models/comment.rb'
require_relative 'models/like.rb'




# helper functions, like in GFH. 

def logged_in?
  if session[:user_id]
      return true
  else
      return false
  end
end


def current_user
  sql = "select * from users where id = #{session[:user_id]};"
  user = db_query(sql).first
  return OpenStruct.new(user) # this returns the user in an object-like state, so on the layout erb we can use js-like stuff like current_user.email
end

def password_correct?(pass, result)
  return BCrypt::Password.new(result[0]['password_digest']) == pass
end

# def same_user? 
#   sql = 'select * from users where id = $1;'
#   post_creater = db_query(sql, [params['user_id']])
# end



get '/' do
 # allow the user to log in, or just see some posts
  result = random_five_ducks()


  erb :index, locals: {
  ducks: result
}
end

get '/ducks/search' do

  erb :search_duck
end

get '/ducks/search_results_name' do
  name = params['name']
  sql = "select * from ducks where name = $1;"
  results = db_query(sql, [name])

  erb :search_results_name, locals: {
    results: results
  }
end

get '/ducks/search_results_location' do
  location = params['location_spotted']
  sql = "select * from ducks where location_spotted = $1;"
  results = db_query(sql, [location])
  erb :search_results_location, locals: {
    results: results
  }
end

get '/ducks/search_results_user' do
  user_email = params['email']
  user_id = find_user_id(user_email)
  sql = "select * from ducks where user_id = $1;"
  results = db_query(sql, [user_id])
  erb :search_results_user, locals: {
    results: results
  }
end

get '/sign_up' do

  erb :new_user
end

post '/users' do
  email = params['email']
  sql = "select * from users where email = $1"
  result = db_query(sql, [email])
  if result.count == 0 
    create_user(params['email'], params['password'])
    redirect '/'
  else
    erb :new_user
  end
end



get '/ducks/new' do # allows the user to see the form to make a new dick if they're logged in
  redirect '/login' unless logged_in? 

  erb :new_duck
end


post '/ducks' do # sends the new duck info to server
  redirect '/login' unless logged_in?

  duck_pic = params['image']['tempfile']

  result = Cloudinary::Uploader.upload(duck_pic, cloudinary_options)

  result_url = result['secure_url']
  create_duck(params['name'], result_url, params['location_spotted'], current_user.id, likes_count = 0, comments_count = 0)
  redirect '/'
end



get '/ducks/:duck_id' do # this is a SHOW, we're showing 1 post.
  duck_id = params['duck_id']
  duck = db_query("select * from ducks where id = $1;", [duck_id]).first

  erb :show_duck, locals: {
    duck: duck
  }
end

delete '/ducks' do
  delete_duck(params['duck_id'])

  redirect '/'
end

get '/ducks/:id/edit' do
  redirect '/login' unless logged_in?



  sql = "select * from ducks where id = $1;"

  duck = db_query(sql, [params['id']]).first
  
  redirect "/ducks/#{params['id']}" unless current_user.id == duck['user_id']


  erb :edit_duck, locals: {
    duck: duck
  }

end

put '/ducks/:id' do
  # redirect '/login' unless logged_in?
  # redirect "/ducks/#{params['id']}" unless current_user.id == duck['user_id']
  update_duck(
    params['name'],
    params['image_url'],
    params['location_spotted'],
    params['id']
  )
  redirect "/ducks/#{params['id']}"
end

get '/login' do
  redirect '/' if logged_in?

  erb :login
end

post '/session' do
  email = params['email']
  user_plain_password = params['password']

  sql = 'select * from users where email = $1;'

  result = db_query(sql, [email])


  if result.count > 0 && BCrypt::Password.new(result[0]['password_digest']) == user_plain_password
    session[:user_id] = result[0]['id']
    redirect '/'
  else
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end



