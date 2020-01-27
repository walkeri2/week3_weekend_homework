require_relative('../db/sql_runner')

class Customer

  attr_accessor :id, :name, :funds

  def initialize(db_hash)

    @id = db_hash['id'].to_i if db_hash['id']
    @name = db_hash['name']
    @funds = db_hash['funds'].to_f #float because has decimals

  end

  def save()
    sql = "INSERT INTO customers(
          name, funds)
          VALUES ($1, $2)
          RETURNING *"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)
    @id = customer.first['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET
          (name, funds) = ($1, $2)
          WHERE ID = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def by_film
    sql = "SELECT * FROM films
    INNER JOIN tickets ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    returned_data = SqlRunner.run(sql, values)
    returned_data.map { |film_data| Film.new(film_data) }
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    customers = customer_data.map{|geezer|Customer.new(geezer)}
    return customers
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
