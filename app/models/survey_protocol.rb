class SurveyProtocol < ActiveRecord::Base
  has_many :observations, foreign_key: :protocol_id

  def self.to_csv(attributes = column_names)
    CSV.generate do |csv|
      csv << attributes
      all.each do |protocol|
        csv << protocol.attributes.values_at(*attributes)
      end
    end
  end
end
