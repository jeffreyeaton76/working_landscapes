require 'rails_helper'

RSpec.describe "submitting an individual entry", type: :feature do

  let(:protocol_definition) {
    { "fields" => [
      { "label" => "Flowering","field_type" => "dropdown","required" => true,"field_options" => {},"cid" => "c24"},
      { "label" => "Grass/Forb/Wood","field_type" => "dropdown","required" => true,
        "field_options" => {"options" => [
          {"label" => "Grass","checked" => true},
          {"label" => "Forb","checked" => false},
          {"label" => "Wood","checked" => false},
          {"label" => "","checked" => false}
      ],"include_blank_option" => true},"cid" => "c54"}
    ]}
  }

  before do
    protocol_builder = GenerateSurveyProtocolForm.new(protocol_definition)
    allow(GenerateSurveyProtocolForm).to receive(:new).and_return protocol_builder
  end

  it "renders a page successfully" do
    visit "/samples/23/entries/new"

    expect(page).to have_text("Flowering")
    expect(page).to have_text("Grass/Forb/Wood")
  end


end
