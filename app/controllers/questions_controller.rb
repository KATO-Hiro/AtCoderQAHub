class QuestionsController < ApplicationController
  before_action :ensure_correct_user, {only: [:edit, :update, :destory]}

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = Question.find_by(id: params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @problem = Problem.find_by(task_id: params[:task_id])

    @question = Question.new(
      task_id: @problem.task_id,
      title: params[:title],
      content: params[:content],
      user_id: @current_user.id
    )

    if @question.save
      flash[:notice] = "Submit a question!"
      redirect_to("/problems/#{@question.task_id}")
    else
      @title = params[:title]
      @content = params[:content]

      render("questions/new")
    end
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:id])

    @question.title = params[:title]
    @question.content = params[:content]

    if @question.save
      flash[:notice] = "Update question title and/or content."
      redirect_to("/problems/#{@question.task_id}")
    else
      render("questions/edit")
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    @question.destroy

    flash[:notice] = "Delete the question."
    redirect_to("/problems/#{@question.task_id}")
  end

  def ensure_correct_user
    @question = Question.find_by(id: params[:id])
    @user = @question.user

    if @current_user == nil || @current_user.id != @user.id
      flash[:notice] = "No permissions."
      redirect_to("/problems/#{@question.task_id}")
    end
  end
end
