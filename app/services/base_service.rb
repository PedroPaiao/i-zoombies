class BaseService < BusinessProcess::Base
  attr_accessor :stop
  protected :stop

  def treat_exception
    begin
      yield
    rescue StandardError => e
      Rails.logger.error("From #{self.class}: #{e.message}")
      Rails.logger.error e.backtrace.first(16).join("\n\t")
    end
  end

  def fail(error = nil)
    super(error)
  end

  def stop_steps
    @stop = true
  end

  # This is still the business process gem
  # I just added a stop to it
  def process_steps
    result = nil
    steps.map(&:to_s).each do |step_name|
      result = process_step(step_name)
      return result if @success == false || stop == true
    end
    result
  end
end