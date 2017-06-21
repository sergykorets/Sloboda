class Tag < ApplicationRecord
  paginates_per 6
  
  validates_uniqueness_of :name
  validates_presence_of :name

  before_save :capitalize_name

  def capitalize_name
    if !self.name.nil?
      self.name = self.name.titleize
    end
  end

  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      all
    end
  end
end
