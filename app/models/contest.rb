class Contest < ApplicationRecord
  def held_on_the_same_day?
    contests = Contest.where(start_epoch_second: self.start_epoch_second)

    if contests.count >= 2
      return true
    else
      return false
    end
  end

  def problems
    return Problem.where(contest_id: self.contest_id)
  end
end
