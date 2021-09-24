class Report < ApplicationRecord
  belongs_to :whistleblower_survivor, class_name: 'Survivor'
  belongs_to :reported_survivor, class_name: 'Survivor'

  validates :whistleblower_survivor, :reported_survivor, presence: true

  after_commit :mark_infected_survivor

  private

  def mark_infected_survivor
    return if reported_survivor.reported_reports.count < 3

    reported_survivor.update(infected: true)
  end
end
