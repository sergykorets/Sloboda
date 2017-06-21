# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  name               :string
#  content            :text
#  slug               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  author_id          :integer
#  published          :boolean
#  published_at       :datetime
#

class Book < ApplicationRecord
  paginates_per 6
  acts_as_taggable

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :author

  validates_presence_of :name
  validates_presence_of :content

  scope :most_recent, -> { order(published_at: :desc) }
  scope :last_week, -> { where("published_at >= :date", :date => 1.week.ago) }
  scope :published, -> { where(published: true) }
  

  has_attached_file :image, styles: { medium: "700x400>", thumb: "350x200>" }, default_url: "Flag_missing.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def should_generate_new_friendly_id?
    name_changed?
  end

  def display_day_published
    if published_at.present?
  	  published_at.strftime('%-b %-d, %-Y')
    else
      "Not published"
    end
  end

  def owner?(user)
    self.author == user
  end
end
