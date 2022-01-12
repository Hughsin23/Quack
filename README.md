# Show us your Quack, readme!

## Approach
Show us your quack is a service that uses HTML, CSS, psql and Ruby, through the Sinatra micro web framework (and later hosted on Heroku). It allows users to upload pictures to the cloud and have them "stored" on the page using Cloudinary.

### Resources used
A database has been created to track the resources Users, Ducks, Comments and Likes

### technologies used 
Sinatra, Ruby, CSS, SQL, PSQL, [Cloudinary](https://cloudinary.com/) for image storage, [bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby) for passwords.

### Problems faced
I had a number of issues, the main one being a very strange CSS error that ended up being simple pathing. The second was how to format the models so they talked correctly to the main, allowing my methods to function correctly. 

### Things to work on
- CSS really needs some work, centering certain things etc
- I will be working on making my sql functions in models more efficient.
- I'll also be adding the ability to edit comments, and hopefully like comments too. 
- I want to add Javascript to the webpage, making it a little more interactive and allowing me to have proper error messages displayed (when a user goes over a character limit for comments, for example). I want to be able to add a "duck of the day" page, that will change every 24 hours to a new randomised post. 
- I think there's also a more efficient way to manipulate my resources

you can find a link to my relational charts/wireframes [here](https://imgur.com/a/wv29UyY)




