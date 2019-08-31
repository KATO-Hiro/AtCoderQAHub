class QuestionsController < ApplicationController
  def index
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
      content: params[:content]
    )

    if @question.save
      flash[:notice] = "Submit a question!"
      redirect_to("/problems/#{@question.task_id}")
    # else
    #   # 編集画面に戻る
    #   render("problems/#{@problem.task_id}/questions/new")
    end
  end
end
