class Outfit < ActiveRecord::Base

  belongs_to :user
  has_many :outfit_items
  has_many :items, through: :outfit_items

  def slug
    name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Outfit.all.find{|outfit| outfit.slug == slug}
  end

end
