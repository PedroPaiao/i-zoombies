class MoveAllSurvivorsWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default, unique_for: 30.minutes

  def perform
    Survivors::Move.new.move_all
  end
end