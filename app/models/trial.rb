class Trial < ActiveRecord::Base
  attr_accessible :distance, :size, :time
  belongs_to :subject

  CSV_HEADERS = %w[subject pointer distance size time]

  def self.to_csv(options=Hash.new)
    CSV.generate(options) do |csv|
      csv << CSV_HEADERS

      Trial.find(:all).each do |trial|
        row = Array.new
        row << trial.subject.id
        row << trial.subject.pointer
        row << trial.distance
        row << trial.size
        row << trial.time

        csv << CSV::Row.new(CSV_HEADERS, row)
      end
    end
  end
end
