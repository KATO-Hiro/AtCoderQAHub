class Contest < ApplicationRecord
  class << self
    # abc
    def abc
      return Contest.all.where("contest_id LIKE?", "abc%").order(start_epoch_second: :desc)
    end

    # arc
    def arc
      return Contest.all.where("contest_id LIKE?", "arc%").order(start_epoch_second: :desc)
    end

    # agc
    def agc
      return Contest.all.where("contest_id LIKE?", "agc%").order(start_epoch_second: :desc)
    end

    # others
    def others
      return Contest.all.where.not("contest_id like? or contest_id like? or contest_id like?", "abc%", "arc%", "agc%").order(start_epoch_second: :desc)
    end
  end

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
