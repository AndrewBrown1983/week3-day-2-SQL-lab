require("pry")
require_relative("./models/property_finder")

Property.delete_all()

property1 = Property.new({
  "address" => "6 Queensbury Gardens",
  "value" => 265000,
  "number_of_bedrooms" => 3,
  "build" => "flat"
  })

  property1.save()

  property2 = Property.new({
    "address" => "12 Bearsden road",
    "value" => 495000,
    "number_of_bedrooms" => 5,
    "build" => "detached"
    })

    # property2.value = 550000
    # property2.update()
    property2.save()


    property3 = Property.new({
      "address" => "1250 Great Western Road",
      "value" => 185000,
      "number_of_bedrooms" => 2,
      "build" => "semi-detached"
      })

      property3.save()
      # property3.delete()
      houses = Property.all()

      found = Property.find_by_id(61)
      found2 = Property.find_by_address("1250 Great Western Road")
      binding.pry
nil
