class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
                                     params[:user][:password]
                                    )
    if @user
      flash[:notices] = ["Welcome!"]
      sign_in!(@user)
      redirect_to @user
    else
      @user = User.new(username: params[:user][:username])
      flash.now[:errors] = ["Invalid Username and/or Password"]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end
end
