class Product < ActiveRecord::Base
  default_scope :order => 'name'
  belongs_to :category
  before_save :ensure_valid_values

  private
    def ensure_valid_values
      if name.empty?
        errors.add(:base, 'Name can not be empty')
        return false
      end

      if category_id.nil? || category_id == 0
        errors.add(:base, 'Category id missing')
        return false
      end

      if price.nil?
        errors.add(:base, 'Enter price for the item')
        return false
      end

      return true
    end
end
