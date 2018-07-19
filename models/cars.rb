class Car
  attr_accessor :id, :make, :model, :country

  def self.open_connection
    conn = PG.connect(dbname: "cars", user: "postgres", password: "password") # tablename is car_list
  end


  def self.all
    conn = self.open_connection

    sql = "SELECT * FROM car_list ORDER BY id"

    results = conn.exec(sql)

    cars = results.map do |data|
      self.hydrate data
    end
  end


  def self.hydrate car_data
    car = Car.new

    car.id = car_data["id"]
    car.make = car_data["make"]
    car.model = car_data["model"]
    car.country = car_data["country"]

    return car
  end


  def self.find id
    conn = self.open_connection

    sql = "SELECT * FROM car_list WHERE id = #{id}"

    cars = conn.exec(sql)

    return self.hydrate cars[0]
  end


  def save
    conn = Car.open_connection

    if !self.id
      sql = "INSERT INTO car_list (make, model, country) VALUES ('#{self.make}', '#{self.model}', '#{self.country}')"
    else
      sql = "UPDATE car_list SET make= '#{self.make}', model= '#{self.model}', country = '#{self.country}' WHERE id = #{self.id}"
    end

    conn.exec(sql)
  end


  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM car_list WHERE id = #{id}"

    conn.exec(sql)
  end











end # Close class