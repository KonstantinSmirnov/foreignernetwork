class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to our family"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    #@current_user_array = []
    #@current_user_array << current_user
    #@users = User.all - @current_user_array
    @users = User.paginate(:page => params[:page], :per_page => 6)

  end

  def post

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation)
    end
end

