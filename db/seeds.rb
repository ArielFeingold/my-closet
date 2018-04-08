users_list = {
    "Ariel" => {
      :username => "arielf",
      :email => "ariel@gmail.com",
      :password => "12345"
    },
    "Andrew" => {
      :username => "andrewj",
      :email => "andrew@gmail.com",
      :password => "12345"
    },
    "Gal" => {
      :username => "galf",
      :email => "gal@gmail.com",
      :password => "12345"
    },
  }

users_list.each do |name, user_hash|
  p = User.new
  p.name = name
  user_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end

items_list = {
    "Armani Shirt" => {
      :catagory => "shirt",
      :type => "dress shirt",
      :color => "blue"
    },
    "Gap Jeans" => {
      :catagory => "pants",
      :type => "jeans",
      :color => "blue"
    },
    "Nike Shoes" => {
          :catagory => "shoes",
          :type => "snickers",
          :color => "red"
        },
      }

items_list.each do |name, item_hash|
  p = Item.new
  p.name = name
  item_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end

outfits_list = {
    "Clubbing 1" => {
    },
    "School " => {
    },
    "Sunday brunch" => {
    },
  }

  outfits_list.each do |name, figure_hash|
    p = Outfit.new
    p.name = name
    p.save
  end
