class ProblemsController < ApplicationController
  def index
    @problems = Problem.all
  end

  def show
    @problem = Problem.find_by(task_id: params[:task_id])
    @questions = Question.where(task_id: @problem.task_id).order(created_at: :desc)
  end

  def new
    @problem = Problem.new
  end

  def create
    require 'json'

    contests_api = 'https://kenkoooo.com/atcoder/resources/contests.json'
    contests = fetch_api_in_json_format contests_api

    problems_api = 'https://kenkoooo.com/atcoder/resources/problems.json'
    problems = fetch_api_in_json_format problems_api

    logger.debug("DEBUG" + "#{contests.inspect}")

    problems.each do |problem_api|
      unless Problem.find_by(task_id: problem_api["id"])
        problem = Problem.new(
          task_id: problem_api["id"],
          contest_id: problem_api["contest_id"],
          title: problem_api["title"],
        )

        if problem.save
        else
          logger.debug("DEBUG: " + "Failed to save the problem" + "#{problem.inspect}")
        end
      end
    end

    flash[:notice] = "Updated!"
    redirect_to("/problems/new")
  end

  # TODO: privateメソッドに
  def fetch_api_in_json_format(url)
    response = Faraday.get url
    response_body = response.body.force_encoding("UTF-8")
    response_body_to_json = JSON.parse(response_body)
    return response_body_to_json
  end
end
