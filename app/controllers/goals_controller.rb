class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def show
    @goal = Goal.includes(:user, :comments).find(params[:id])
    @user = @goal.user
    @comments = @goal.comments
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      flash[:notices] = ["Hopefully you can live up to that."]
      redirect_to current_user
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end

  def update
    @goal = current_user.goals.find(params[:id])

    if @goal.update(goal_params)
      flash[:notices] = ["You have changed your goal. Hopefully it'll be easier now"]
      redirect_to current_user
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = current_user.goals.destroy(params[:id])

    flash[:notices] = ["Looks like you gave up"]

    redirect_to current_user
  end

  def cheer
    @goal = Goal.find(params[:id])
    current_user.give_cheer(@goal)
    redirect_to :back
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :privacy, :completed)
  end
end
