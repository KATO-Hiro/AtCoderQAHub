class ProblemsController < ApplicationController
  def index
    @contests = Contest.all.page(params[:page]).per(5)
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

    contests.each do |contest_api|
      unless Contest.find_by(contest_id: contest_api["id"])
        contest = Contest.new(
          contest_id: contest_api["id"],
          start_epoch_second: contest_api["start_epoch_second"],
          title: contest_api["title"],
        )

        if contest.save
        else
          logger.debug("DEBUG: " + "Failed to save the contest" + "#{contest.inspect}")
        end
      end
    end

    problems_api = 'https://kenkoooo.com/atcoder/resources/problems.json'
    problems = fetch_api_in_json_format problems_api

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

    # TODO: 同じ日に開催されたコンテストで，重複する問題に対処
    @contests = Contest.all

    @contests.each do |contest|
      if contest.held_on_the_same_day?
        logger.debug("DEBUG: " + "#{contest.inspect}")
      end

    end

    flash[:notice] = "Updated!"
    redirect_to("/problems/new")
  end

private
  def fetch_api_in_json_format(url)
    response = Faraday.get url
    response_body = response.body.force_encoding("UTF-8")
    response_body_to_json = JSON.parse(response_body)
    return response_body_to_json
  end
end
