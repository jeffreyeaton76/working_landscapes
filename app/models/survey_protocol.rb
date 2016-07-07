class SurveyProtocol < ActiveRecord::Base
  has_many :observations, foreign_key: :protocol_id

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |protocol|
        csv << protocol.attributes.values_at(*column_names)
      end
    end
  end
end
