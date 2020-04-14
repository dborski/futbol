module Mathable
  def percent(subset, total)
    (subset.to_f / total.length.to_f).round(2)
  end

  def average(subset, total)
    (subset.to_f / total.to_f).round(2)
  end
end
