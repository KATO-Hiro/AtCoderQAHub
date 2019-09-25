class AnswersController < ApplicationController
  before_action :ensure_correct_user, {only: [:edit, :update, :destory]}
  before_action :authenticate_user, {only: [:upvote, :downvote]}

  def index
  end

  def new
    @answer = Answer.new
  end

  def create
    task_id = params[:task_id]

    @answer = Answer.new(
      question_id: params[:question_id],
      content: params[:content],
      user_id: @current_user.id
    )

    if @answer.save
      flash[:notice] = "Submit your answer!"
      redirect_to("/problems/#{task_id}/questions/#{@answer.question_id}")
    else
      @question = Question.find_by(id: params[:question_id], task_id: task_id)
      @error_message = "Must be between 1 and 400 characters."
      @content = params[:content]

      render "questions/show"
    end
  end

  def edit
    @answer = Answer.find_by(id: params[:id])
  end

  def update
    @answer = Answer.find_by(id: params[:id])

    @answer.content = params[:content]

    if @answer.save
      flash[:notice] = "Update your answer."
      redirect_to("/problems/#{params[:task_id]}/questions/#{@answer.question_id}")
    else
      render("answers/edit")
    end
  end

  def destroy
    @answer = Answer.find_by(id: params[:id])
    @answer.destroy

    flash[:notice] = "Delete the question."
    redirect_to("/problems/#{params[:task_id]}/questions/#{@answer.question_id}")
  end

  def ensure_correct_user
    @answer = Answer.find_by(id: params[:id])
    @user = @answer.user

    if @current_user.id != @user.id
      flash[:notice] = "No permissions."
      redirect_to("/problems/#{params[:task_id]}/questions/#{@answer.question_id}")
    end
  end

  def upvote
    @answer = Answer.find_by(id: params[:id])
    @answer.upvote_from @current_user
  end

  def cancel_upvote
    @answer = Answer.find_by(id: params[:id])
    @answer.unliked_by @current_user
  end

  def downvote
    @answer = Answer.find_by(id: params[:id])
    @answer.downvote_from @current_user
  end

  def cancel_downvote
    @answer = Answer.find_by(id: params[:id])
    @answer.undisliked_by @current_user
  end
end
