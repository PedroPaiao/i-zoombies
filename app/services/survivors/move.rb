class Survivors::Move
  def move_all
    @survivors = Survivor.all
    Survivor.transaction do
      @result = @survivors.map(&:move)
      raise ActiveRecord::Rollback if @result.any?(false)
    end

    @result
  end
end
