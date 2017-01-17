# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string
#  name        :string           not null
#  sex         :string(1)
#  description :text
#

class Cat < ActiveRecord::Base
  COLORS = %w(brown black white grey orange tuxedo)



  validates :birth_date, presence: true
  validates :name, presence: true
  validates :color, inclusion: { in: COLORS,
    message: "Pick from #{COLORS}"}


  has_many :cat_rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: 'CatRentalRequest',
    dependent: :destroy


    def age
      age = (Date.current - birth_date).to_i / 365
    end

end
