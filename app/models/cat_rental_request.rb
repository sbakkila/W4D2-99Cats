# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)

  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
    validates :status, presence: true, inclusion: { in: STATUSES,
    message: "Not a valid status"}


  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: 'Cat'

  has_many :competing_requests,
    through: :cat,
    source: :cat_rental_requests

  def overlapping_requests
    # debugger

    possible_overlaps = self.competing_requests.where.not(id: self.id)
      .where.not("start_date >= ? OR end_date <= ?", "#{self.end_date}", "#{self.start_date}")
  end

  def overlapping_approved_request
    overlapping_requests.reject { |request| request.status != "APPROVED"}
  end

  def approve!

    if overlapping_approved_request.empty?
      transaction do
        self.status = 'APPROVED'
        self.save
        overlapping_requests.each do |req|
          req.deny!
        end
      end
    end

  end

  def deny!
    self.status = 'DENIED'
    self.save
  end
end
