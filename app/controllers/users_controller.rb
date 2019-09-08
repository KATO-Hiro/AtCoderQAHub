class UsersController < ApplicationController
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
      flash[:notice] = "Create your account!"
      redirect_to("/users/#{@user.id}")
    else
      ## 失敗
      ### 新規登録画面を表示
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
    # else
      ## 失敗
      ### 編集画面を表示
    #   render("questions/edit")
    end
  end

  def destroy
    @User = User.find_by(id: params[:id])
    @User.destroy

    flash[:notice] = "Delete the account."
    redirect_to("/users")
  end
end
