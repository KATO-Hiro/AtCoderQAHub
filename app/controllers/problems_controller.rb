class ProblemsController < ApplicationController
  def index
    @problems = Problem.all
  end

  def show
    @problem = Problem.find_by(task_id: params[:task_id])
    @questions = Question.where(task_id: @problem.task_id).order(created_at: :desc)
  end
end
