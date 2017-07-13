def consolidate_cart(cart)
  # code here
new_hash = Hash.new(0)
  cart.each do |trunk|
    trunk.each do |name, branch|
if !new_hash.has_key?(name)
  new_hash = new_hash.merge(name => {:count => 1})
else
  new_hash[name][:count] += 1
##  binding.pry
  end
end
end
cart.each do |trunk|
  trunk.each do |name, branch|
    branch.each do |attribute, value|
      new_hash[name] = new_hash[name].merge(attribute => value)
      ##binding.pry
    end
  end
end
new_hash
##binding.pry
end

def apply_coupons(cart, coupons)
  # code here
  store_name = ""
  coupon_hash = Hash.new(0)
  coupons.each do |trunk|
    trunk.each do |att, value|
      if att == :item
      store_name = value
      coupon_hash = coupon_hash.merge(store_name => {})
      else
      coupon_hash[store_name] = coupon_hash[store_name].merge(att => value)
      ##binding.pry
      end
    end
  end
  coupon_count = 0
  coupon_hash.each do |name_coupon, branch|
      cart.each do |name_item, river|
        if name_item == name_coupon
          while cart[name_item][:count] >= coupon_hash[name_coupon][:num]

            num = cart[name_item][:count] - coupon_hash[name_coupon][:num]
            cart[name_item] = cart[name_item].merge(:count => num)
            ##  cart = cart.merge(})
          ##  binding.pry
            if !cart.has_key?("#{name_item} W/COUPON")
              cart = cart.merge("#{name_item} W/COUPON" => {:price => coupon_hash[name_item][:cost], :clearance => cart[name_item][:clearance], :count => 1})

            else
              coupon_count = cart["#{name_item} W/COUPON"][:count]
              coupon_count += 1
              cart["#{name_item} W/COUPON"] = cart["#{name_item} W/COUPON"].merge(:count => coupon_count)
              ##binding.pry
            end
          end
        end
      end
    end
    cart
    ##binding.pry
end

def apply_clearance(cart)
  # code here
  num = 0
  cart.each do |name, river|
    river.each do |att, value|
      if att == :clearance
        if value == true
          num = cart[name][:price] * 0.8
          num = num.round(3)
          cart[name] = cart[name].merge(:price => num)
          ##binding.pry
        end
      end
    end
    ##binding.pry
  end
  cart
  ##binding.pry
end

def checkout(cart, coupons)
  # code here
sum = 0
multiplier = 0
cost = 0
check1 = consolidate_cart(cart)

check2 = apply_coupons(check1, coupons)
check3 = apply_clearance(check2)

check3.each do |name, river|
  river.each do |att, value|
    if att == :count
      multiplier = value
    end
    if att == :price
      cost = value
    end

  end
  sum = sum + multiplier * cost
end
if sum > 100
  sum = sum * 0.9
else
sum
end
end
