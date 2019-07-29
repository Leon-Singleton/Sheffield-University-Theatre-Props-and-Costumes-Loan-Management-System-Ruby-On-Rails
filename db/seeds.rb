# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Colour.create(name: 'Red')
Colour.create(name: 'Orange')
Colour.create(name: 'Yellow')
Colour.create(name: 'Green')
Colour.create(name: 'Blue')
Colour.create(name: 'Purple')
Colour.create(name: 'Brown')
Colour.create(name: 'Maroon')
Colour.create(name: 'Navy')
Colour.create(name: 'Silver')
Colour.create(name: 'Gold')
Colour.create(name: 'Pink')
Colour.create(name: 'white')
Colour.create(name: 'Black')
Colour.create(name: 'Camouflage')
Colour.create(name: 'Khaki')
Colour.create(name: 'Feldgrau')

Category.create(name: 'Accessories')
Category.create(name: 'Furniture')
Category.create(name: 'Homewear')
Category.create(name: 'Kids Corner')
Category.create(name: 'kitchenware')
Category.create(name: 'Lighting')
Category.create(name: 'Mens Clothing')
Category.create(name: 'Womens Clothing')
Category.create(name: 'Musical Instruments')
Category.create(name: 'Set Dressing')
Category.create(name: 'Technology and Books')

Subcategory.create(name: 'Togas', category_id: 1)
Subcategory.create(name: 'wigs', category_id: 1)
Subcategory.create(name: 'tiaras/crowns', category_id: 1)
Subcategory.create(name: 'hats', category_id: 1)
Subcategory.create(name: 'belts', category_id: 1)
Subcategory.create(name: 'bags', category_id: 1)
Subcategory.create(name: 'glasses', category_id: 1)
Subcategory.create(name: 'gloves', category_id: 1)

Subcategory.create(name: 'Tables', category_id: 2)
Subcategory.create(name: 'Chairs', category_id: 2)
Subcategory.create(name: 'Stools', category_id: 2)
Subcategory.create(name: 'Chests/Trunks', category_id: 2)

Subcategory.create(name: 'Vases', category_id: 3)
Subcategory.create(name: 'Mirrors', category_id: 3)
Subcategory.create(name: 'Clocks', category_id: 3)
Subcategory.create(name: 'Baskets', category_id: 3)

Subcategory.create(name: 'Soft Toys', category_id: 4)

Subcategory.create(name: 'Plates', category_id: 5)
Subcategory.create(name: 'Bowls', category_id: 5)
Subcategory.create(name: 'Cutlery', category_id: 5)
Subcategory.create(name: 'Jugs', category_id: 5)

Subcategory.create(name: 'Desk Lamps', category_id: 6)
Subcategory.create(name: 'Torches', category_id: 6)
Subcategory.create(name: 'Candle Holders', category_id: 6)
Subcategory.create(name: 'Stand Lamps', category_id: 6)

Subcategory.create(name: 'Mens Jumpers', category_id: 7)
Subcategory.create(name: 'Mens Jackets', category_id: 7)
Subcategory.create(name: 'Mens Coats', category_id: 7)
Subcategory.create(name: 'Mens Shirts', category_id: 7)
Subcategory.create(name: 'Mens Trousers', category_id: 7)
Subcategory.create(name: 'Mens Shoes', category_id: 7)

Subcategory.create(name: 'Womens Jumpers', category_id: 8)
Subcategory.create(name: 'Womens Jackets', category_id: 8)
Subcategory.create(name: 'Womens Coats', category_id: 8)
Subcategory.create(name: 'Womens Shirts', category_id: 8)
Subcategory.create(name: 'Womens Trousers', category_id: 8)
Subcategory.create(name: 'Womens Shoes', category_id: 8)
Subcategory.create(name: 'Womens Lingerie', category_id: 8)
Subcategory.create(name: 'Womens Skirts', category_id: 8)

Subcategory.create(name: 'Wooden', category_id: 9)
Subcategory.create(name: 'Brass', category_id: 9)

Subcategory.create(name: 'Flowers', category_id: 10)
Subcategory.create(name: 'Medical Items', category_id: 10)
Subcategory.create(name: 'Military Items', category_id: 10)
Subcategory.create(name: 'Religous Items', category_id: 10)

Subcategory.create(name: 'Phones', category_id: 11)
Subcategory.create(name: 'Cameras', category_id: 11)
Subcategory.create(name: 'Computers', category_id: 11)
Subcategory.create(name: 'Music Players', category_id: 11)
Subcategory.create(name: 'TypeWriters', category_id: 11)
Subcategory.create(name: 'Fax Machines', category_id: 11)
Subcategory.create(name: 'Record Players', category_id: 11)
