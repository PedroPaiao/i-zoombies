class Api::V1::ReportsController < Api::ApiController
  before_action :set_survivor

  def create
    report = Report.new(formatted_params)

    if report.save
      render_success(serialize_resource(report, ReportSerializer))
    else
      render_unprocessable_entity_error(report.errors.messages)
    end
  end

  private

  def set_survivor
    @survivor = Survivor.find_by(id: params[:id])

    render_not_found_error unless @survivor.present?
  end

  def report_params
    params.require(:report).permit(:description, :reported_survivor_id)
  end

  def formatted_params
    report_params
      .merge(
        whistleblower_survivor_id: @survivor[:id],
        reported_survivor_id: report_params[:reported_survivor_id]
      )
      .except(:survivor_id)
  end
end