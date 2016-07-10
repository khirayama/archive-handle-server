class Event < ActiveRecord::Base
  validate :name, length: { maximum: 50 }, presence: true
  validate :place, length: { maximum: 100 }, presence: true
  validate :content, length: { maximum: 2000 }, presence: true
  validate :start_time, presence: true
  validate :end_time, presence: true
  validate :start_time_should_be_before_end_time

  private

    def start_time_should_be_before_end_time
      return unless start_time && end_time

      if start_time >= end_time
        errors.add(:start_time, ' should be before end time')
      end
    end
end
