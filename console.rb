require('pry')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')


customer1 = Customer.new({'name' => 'Billy', 'funds' => '10.50'})
customer2 = Customer.new({'name' => 'Royal', 'funds' => '20.75'})
customer1.save()
customer2.save()

film1 = Film.new({'title' => 'Cool Runnings', 'price' => '5'})
film2 = Film.new({'tilte' => 'Uncle Buck', 'price' => '4'})
film1.save()
film2.save()


ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})


ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})

ticket1.save()
ticket2.save()

Ticket.all()

binding.pry
nil
