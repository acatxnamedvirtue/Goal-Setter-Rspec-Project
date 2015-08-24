class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notices] = ["Thanks for signing up!"]
      sign_in!(@user)
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.includes(:goals, :comments).find(params[:id])
    @goals = @user.goals
    @comments = @user.comments
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
