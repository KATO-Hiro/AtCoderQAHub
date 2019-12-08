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

    # 同じ日に開催されたコンテストで，重複する問題に対処
    contests_problems_api = 'https://kenkoooo.com/atcoder/resources/contest-problem.json'
    contests_problems = fetch_api_in_json_format contests_problems_api

    contests_problems.each do |contest_problem|
      unless Problem.find_by(contest_id: contest_problem["contest_id"], task_id: contest_problem["problem_id"])
        problem_title = Problem.find_by(task_id: contest_problem["problem_id"]).title

        problem = Problem.new(
          task_id: contest_problem["problem_id"],
          contest_id: contest_problem["contest_id"],
          title: problem_title,
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

  def abc
    @selected_problems = Contest.abc.page(params[:page]).per(5)
    @contest_type = "AtCoder Beginner Contest"

    render("problems/index")
  end

  def arc
    @selected_problems = Contest.arc.page(params[:page]).per(5)
    @contest_type = "AtCoder Regular Contest"

    render("problems/index")
  end

  def agc
    @selected_problems = Contest.agc.page(params[:page]).per(5)
    @contest_type = "AtCoder Grand Contest"

    render("problems/index")
  end

  def other
    @selected_problems = Contest.others.page(params[:page]).per(5)
    @contest_type = "Other Contests"

    render("problems/index")
  end

private
  def fetch_api_in_json_format(url)
    response = Faraday.get url
    response_body = response.body.force_encoding("UTF-8")
    response_body_to_json = JSON.parse(response_body)
    return response_body_to_json
  end
end
