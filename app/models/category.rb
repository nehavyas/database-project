class Category < ActiveRecord::Base
  has_many :products
  before_save :ensure_valid_name

  private

  def ensure_valid_name
    if name.empty?
      errors.add(:base, 'A valid name required.')
      return false
    end
    return true
  end
end
