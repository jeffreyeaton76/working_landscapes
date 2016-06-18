class CreateSurveyFields < ActiveRecord::Migration
  def change
    create_table :survey_fields do |t|
      t.string :name, null: false
      t.integer :field_type, null: false

      t.timestamps null: false
    end
  end
end
