class AnswersController < ApplicationController
  def index
  end

  def new
    @answer = Answer.new
  end

  def create
    task_id = params[:task_id]

    @answer = Answer.new(
      question_id: params[:question_id],
      content: params[:content]
    )

    if @answer.save
      flash[:notice] = "Submit your answer!"
      redirect_to("/problems/#{task_id}/questions/#{@answer.question_id}")
    # else
      # 回答ページを表示
      # render("")
    end
  end

  def update
  end

  def destroy
  end
end
