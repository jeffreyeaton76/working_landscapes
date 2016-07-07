class SurveyProtocolsController < ApplicationController
  before_action :find_survey_protocol, only: [:edit, :update]


  def index
    @survey_protocols = SurveyProtocol.all
    respond_to do |format|
      format.html
      format.csv { send_data @survey_protocols.to_csv }
    end
  end

  def new
    @survey_protocol = SurveyProtocol.new
  end

  def create
    @survey_protocol = SurveyProtocol.new(strong_params)
    if @survey_protocol.save!
      redirect_to edit_survey_protocol_path(@survey_protocol)
    else
      flash[:message] = "Title is required"
      render :new
    end
  end

  def update
    @survey_protocol.update!(sample_fields: params[:fields])
    head :ok
  end

  private

  def strong_params
    params.require(:survey_protocol).permit(:title)
  end

  def find_survey_protocol
    @survey_protocol = SurveyProtocol.find(params[:id])
  end
end
