class Restaurant < ActiveRecord::Base

  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :name, length: {minimum: 3}, uniqueness: true

  def check_user(user)
    if self.user == user
      return true
    else
      self.errors.add(:user, "must be associated with restaurant")
      return
    end
  end

end
