class Tag < ApplicationRecord
  paginates_per 6
  
  validates_uniqueness_of :name
  validates_presence_of :name

  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      all
    end
  end
end
