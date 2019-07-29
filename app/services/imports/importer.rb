require 'csv'

class Imports::Importer

  def initialize(file)
    @path = file.path
  end

  def import
    csv = CSV.read(@path, headers: true, skip_blanks: true)
    csv_valid = (['name', 'code', 'description', 'costume', 'subcategory', 'category', 'colour', 'image'] - csv.headers.compact).empty?
    return "Invalid file type" unless csv_valid

    csv.each do |item|
      if Category.where(name: item["category"]).empty?
        new_category = Category.create(name: item["category"])
        # new_category.save
        # category = Category.find_by(name: item["category"])
        new_sub = new_category.subcategories.create(name: item["subcategory"])
        # new_sub = Subcategory.new(name: item["subcategory"], category_id: category.id)
        # new_sub.save
        # subcategory = Subcategory.find_by(name: item["subcategory"])
      elsif Subcategory.where(name: item["subcategory"]).empty?
        new_category = Category.find_by(name: item["category"])
        new_sub = new_category.subcategories.create(name: item["subcategory"])
      else
        new_category = Category.find_by(name: item["category"])
        new_sub = Subcategory.find_by(name: item["subcategory"])
      end
      if Colour.where(name: item["colour"]).empty?
        new_colour = Colour.create(name: item["colour"])
      else
        new_colour = Colour.find_by(name: item["colour"])
      end

      new_item = Item.new
      new_item.name = item["name"]
      new_item.code = item["code"]
      new_item.description = item["description"]
      new_item.costume = item["costume"]
      new_item.subcategory_id = new_sub.id
      new_item.category_id = new_category.id
      new_item.colour_id = new_colour.id
      new_item.item_image_file = item["item_image_file"]
      if (!new_item.valid?)
        return "Code for an item has already been taken"
        # flash.now[:alert] = "Code for an item has already been taken"
      else
        new_item.save!
      end
    end


  return true
end
end
