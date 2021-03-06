require 'date'
require 'pry'

class Library
  attr_accessor :books #TODO duedate person status

  def initialize(options={})
      @books = options[:books] || []
  end

  def check_in(book)
      add = {title: book[:title],
           author: book[:author],
           status: :okay,
           person: :non,
           duedate: " "}
     @books.push add
  end

  def lend(user, args={})
      book = @books.detect { |obj| obj[args.keys.first] == args[args.keys.first] }
      case
        when book[:status] == :lended then
        'Sorry, book is already with another reader'
        when user.portfolio.select { |a| a[:duedate] > Date.today.strftime('%F') } != [] then
        'Sorry, you have one overdue book to return'
      else
        @books.each do |object|
          if object[:title] == book[:title]
             object[:status] = :lended
             object[:person] = :MEEE
             object[:duedate] = set_duedate
          end
      end
    end
    book
  end


  def return(user, args={})
      book = @books.detect { |obj| obj[args.keys.first] == args[args.keys.first] }
      @books.each do |object|
        if object[:title] == book[:title]
           object[:status] = :okay
           object[:person] = :non
           object[:duedate] = ""
        end
      end
      book
  end

  def set_duedate
    Date.today.next_month.strftime('%F')
  end

end
