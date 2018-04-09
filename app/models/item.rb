class Item < ActiveRecord::Base

  belongs_to :user
  has_many :outfit_items
  has_many :outfits, through: :outfit_items

  def slug
    name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Item.all.find{|item| item.slug == slug}
  end


end
