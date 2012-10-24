class DataController < ApplicationController
  def index
    @trials = Trial.find :all, :include => :subject

    respond_to do |format|
      format.html

      format.csv do
        send_data Trial.to_csv
      end
    end
  end
end
