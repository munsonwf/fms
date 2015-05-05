class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :destroy,        only: :destroy

  def new
  	@user = User.new
  end

  def index
    @users = User.paginate(page: params[:id])
  end 

  def show
    @user = User.find(params[:id])
    @messages = @user.messages.paginate(page: params[:page])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save 
      attr_accessor :remember_token, :activation_token
      @user.send_activation_email
      before_save   :downcase_email
      before_create :create_activation_digest
      log_in @user
  		flash[:success] = "Welcome to FMS!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end 

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    # CONFIRMS USER IS LOGGED IN
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    # CONFIRMS USER IS CORRECT
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # CONFIRMS USER IS ADMIN
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end