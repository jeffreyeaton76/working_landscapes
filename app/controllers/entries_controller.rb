class EntriesController < ApplicationController

  def new
    survey_protocol = SurveyProtocol.first
    @protocol     = GenerateSurveyProtocolForm.new(survey_protocol.entry_fields)
    @sample       = Sample.new(id: params[:sample_id])
    @entry        = @protocol.form_class.new(entry: Entry.new)
  end

  def create
    survey_protocol = SurveyProtocol.first
    @protocol     = GenerateSurveyProtocolForm.new(survey_protocol.entry_fields)
    @sample       = Sample.new(id: params[:sample_id])
    entry         = Entry.new(sample_id: params[:sample_id])

    form = @protocol.form_class.new(entry: entry, data: OpenStruct.new)
    if form.validate(params[:entry])
      save_form(form)
      redirect_to new_sample_entry_path(@sample)
    else
      render :new
    end
  end

private

  def save_form form
    form.save do |hash|
      data = {}
      @protocol.each_field do |field|
        data[field.label] = form.send(field.name)
      end

      Entry.create(hash[:entry].merge(response_data: data, sample_id: params[:sample_id], taxon: nil, taxon_id: 33))
    end
  end


end
