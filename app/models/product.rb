class Product < ActiveRecord::Base
  default_scope :order => 'name'
  belongs_to :category
  has_many :line_items
  has_many :orders, :through => :line_items

  before_save :ensure_valid_values
  before_destroy :ensure_not_referenced_by_any_line_item

  def self.search_by_category(category_id)
    where("category_id = ?", category_id)
  end

  def self.search_by_name(name)
    where("name LIKE ?", name)
  end

  def self.search_where_price_gte(min)
    where("price >= ?", min.gsub(',','_').to_f)
  end

  def self.search_where_price_lte(max)
    where("price <= ?", max.gsub(',','_').to_f)
  end

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

    #ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
         errors.add(:base, 'Line Items present')
         return false
      end
    end
end
