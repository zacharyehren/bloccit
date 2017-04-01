module SessionsHelper

#create session sets user_id on the session object to user.id, which is unique to each user
#session is an object Rails provides to track the state of a particular user. There is a one-to-one relationship
#between session objects and user ids.
  def create_session(user)
    session[:user_id] = user.id
  end

#we clear the user ID on the session object by setting it to nil
  def destroy_session(user)
    session[:user_id] = nil
  end

#we define current_user which returns the current user of the of the app
#current_user encapsulates the pattern of finding the current user that we would otherwise call throughout Bloccit
#thus we don't have to constantly call User.find_by(id: session[:user_id]).
#current_user finds the signed-in user by taking the user id from the session and searching the db for the user in question

  def current_user
    User.find_by(id: session[:user_id])
  end
end
