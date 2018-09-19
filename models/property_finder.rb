require("pg")

class Property
attr_accessor :address, :value, :number_of_bedrooms, :build
attr_reader :id

def initialize(options)

  @id = options["id"].to_i if options["id"]
  @address = options["address"]
  @value = options["value"].to_i
  @number_of_bedrooms = options["number_of_bedrooms"].to_i
  @build = options["build"]
end

def save()
  db = PG.connect({dbname: "prorperty_tracker", host: "localhost"})

  sql = "INSERT INTO properties
  (address, value, number_of_bedrooms, build)
  VALUES ($1, $2, $3, $4)
  RETURNING *"

  values = [@address, @value, @number_of_bedrooms, @build]

  db.prepare("save", sql)
  db.exec_prepared("save", values)
  db.close()
end

def Property.all()
  db = PG.connect({dbname: "prorperty_tracker", host: "localhost"})

  sql = "SELECT * FROM properties"

  db.prepare("all", sql)
  houses = db.exec_prepared("all")
  db.close

  return houses.map{|house_hash| Property.new(house_hash)}
end
def delete()
  db = PG.connect({dbname: "prorperty_tracker", host: "localhost"})
  sql = "DELETE FROM properties WHERE id = $1"
  values = [@id]
  db.prepare("delete_one", sql)
  db.exec_prepared("delete_one", values)
  db.close
end

def Property.delete_all()
  db = PG.connect({dbname: "prorperty_tracker", host: "localhost"})
  sql = "DELETE FROM properties"

  db.prepare("delete_all", sql)
  db.exec_prepared("delete_all")
  db.close
end

def update()
  db = PG.connect({dbname: "prorperty_tracker", host: "localhost"})
  sql = "UPDATE properties SET (address, value, number_of_bedrooms, build)
  = ($1, $2, $3, $4)
  WHERE id = $5"

  values = [@address, @value, @number_of_bedrooms, @build, @id]

  db.prepare("update", sql)
  db.exec_prepared("update", values)
  db.close()

end

def Property.find_by_id(num)
    db = PG.connect({dbname: "prorperty_tracker", host: "localhost"})

    sql = "SELECT * FROM properties WHERE id = #{num}"

    db.prepare("find_by_id", sql)
    found = db.exec_prepared("find_by_id")
    db.close()

    return found

  end

  def Property.find_by_address(address_line)
    db = PG.connect({dbname: "prorperty_tracker", host: "localhost"})

    sql = "SELECT * FROM properties WHERE address = #{address_line}"

    db.prepare("find_by_address", sql)
    found2 = db.exec_prepared("find_by_address")
    db.close()

    return found2

  end

end
