class ExperimentController < ApplicationController
  def index

  end

  def completed
    results = params[:results]

    respond_to do |format|
      format.json do
        render :json => {
          :url => url_for(:controller => 'experiment', :action => 'thankyou')
        }
      end
    end
  end

  def thankyou

  end
end
