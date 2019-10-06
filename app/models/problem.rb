class Problem < ApplicationRecord
  def duplicated?(target_problem)
    if self.task_id == target_problem.task_id
      return true
    else
      return false
    end
  end
end
