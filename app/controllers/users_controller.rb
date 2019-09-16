class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      password: params[:password],
      atcoder_id: params[:atcoder_id]
    )

    if @user.save
      # Log in
      session[:user_id] = @user.id
      flash[:notice] = "Create your account!"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])

    @user.name = params[:name]
    @user.password = params[:password]
    @user.atcoder_id = params[:atcoder_id]

    if @user.save
      flash[:notice] = "Update your account information."
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def destroy
    @User = User.find_by(id: params[:id])
    @User.destroy

    flash[:notice] = "Delete the account."
    redirect_to("/users")
  end

  def login_form
  end

  def login
    # 入力された名前とパスワードからユーザーを特定
    @user = User.find_by(name: params[:name])

    if @user && @user.authenticate(params[:password])
      # ユーザー情報をブラウザに保存
      session[:user_id] = @user.id
      flash[:notice] = "Login successful!"
      redirect_to("/problems")
    else
      # フォームで使えるように用意
      @error_message = "Incorrect username or password."
      @name = params[:name]
      @password = params[:password]

      render("users/login_form")
    end
  end

  def logout
    # ログイン状態を破棄
    session[:user_id] = nil
    redirect_to("/login")
  end
end
