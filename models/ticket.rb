require_relative('../db/sql_runner')

class Ticket

  attr_accessor :id, :customer_id, :film_id

  def initialize(db_hash)

    @id = db_hash['id'].to_i if db_hash['id']
    @customer_id = db_hash['customer_id'].to_i
    @film_id = db_hash['film_id'].to_i

  end

  def save()
    sql = "INSERT INTO tickets(
          customer_id, film_id)
          VALUES ($1, $2)
          RETURNING *"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values)
    @id = ticket.first['id'].to_i
  end

  def delete ()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets ORDER BY customer_id"
    tickets = SqlRunner.run(sql)
    results = tickets.map{|ticket|Ticket.new(ticket)}
    return results
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
