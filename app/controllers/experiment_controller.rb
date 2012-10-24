class ExperimentController < ApplicationController
  def index

  end

  def completed
    subject = Subject.create :pointer => cookies[:pointer]

    params[:results].each do |index, result|
      trial = Trial.create :distance => result[:distance],
                           :size => result[:size],
                           :time => result[:time]

      trial.subject = subject
      trial.save
    end

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
