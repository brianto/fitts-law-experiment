class Trial < ActiveRecord::Base
  attr_accessible :distance, :participant, :pointer, :size, :time

  CSV_HEADERS = %w[participant pointer distance size time]

  def self.to_csv(options=Hash.new)
    CSV.generate(options) do |csv|
      csv << CSV_HEADERS

      Trial.find(:all).each do |trial|
        row = CSV_HEADERS.collect do |header|
          trial.send header
        end

        csv << CSV::Row.new(CSV_HEADERS, row)
      end
    end
  end
end
