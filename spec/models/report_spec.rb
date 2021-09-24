require 'rails_helper'

RSpec.describe Report, type: :model do
  context 'Validate report relations' do
    let!(:survivor) { create(:survivor, :main) }
    it 'Report is valid' do
      report = Report.new(
        whistleblower_survivor: survivor,
        reported_survivor: survivor
      )
      expect(report).to be_valid
    end

    it 'Whistleblower Survivor is invalid, because is required' do
      report = Report.new(
        reported_survivor: survivor
      )

      expect(report).to be_invalid
    end

    it 'Reported Survivor is invalid, because is required' do
      report = Report.new(
        whistleblower_survivor: survivor
      )

      expect(report).to be_invalid
    end
  end
end
