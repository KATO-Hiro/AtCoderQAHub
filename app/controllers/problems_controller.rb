class ProblemsController < ApplicationController
  def index
    @problems = Problem.all
  end

  def show
  end
end
