class UsersController < ApplicationController
before_action :logged_in_user , only: [:edit , :update ]
before_action :my_self , only: [:edit , :update ]

  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def index
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     #保存に成功した場合はトップぺージにリダイレクト
     redirect_to @user , notice: 'プロフィールを変更しました。'
    else
      #保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :nmd, :sex, :content, :password_confirmation)
  end
  
  def my_self
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to root_path , notice: '本人のアカウントのみ変更可能です。'
    end
  end  
  
end
