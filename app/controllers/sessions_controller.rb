class SessionsController < ApplicationController
  def new
  end

  def create
    #We search the database for a user with the specified email address in the params hash
    #We use downcase to normalize the email since the addresses stores in the db are stored as lowercase strings
    user = User.find_by(email: params[:session][:email].downcase)

    #we verify that user is not nil and that the password in the params hash matches the specified password
    #the conditional statement will exit early if user is nil because it checks for that first
    #this order of execution will prevent a null pointer exception when user.authenticate is called if user is nil
    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

#destroy logs the user out by calling destroy_session(current_user)
  def destroy
    destroy_session(current_user)
    flash[:notice] = "You've been signed out. Come back reaaaal soon, ya hear?"
    redirect_to root_path
  end
end
