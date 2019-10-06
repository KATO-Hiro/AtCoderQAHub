class Contest < ApplicationRecord
  def problems
    return Problem.where(contest_id: self.contest_id)
  end
end
