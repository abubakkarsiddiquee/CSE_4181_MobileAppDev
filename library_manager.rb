# Define a class to represent a Book
class Book
    attr_accessor :title, :author, :year
  
    def initialize(title, author, year)
      @title = title
      @author = author
      @year = year
    end
  
    def to_s
      "#{title} by #{author} (#{year})"
    end
  end
  
  # Define a class to manage a Library of books
  class Library
    def initialize
      @books = []
    end
  
    def add_book(book)
      @books << book
    end
  
    def remove_book(title)
      @books.reject! { |book| book.title == title }
    end
  
    def list_books
      @books.each { |book| puts book }
    end
  
    def save_to_file(filename)
      File.open(filename, 'w') do |file|
        @books.each do |book|
          file.puts "#{book.title},#{book.author},#{book.year}"
        end
      end
    end
  
    def load_from_file(filename)
      return unless File.exist?(filename)
  
      File.foreach(filename) do |line|
        title, author, year = line.chomp.split(',')
        add_book(Book.new(title, author, year.to_i))
      end
    end
  end
  
  # Example usage
  library = Library.new
  library.add_book(Book.new("The Great Gatsby", "F. Scott Fitzgerald", 1925))
  library.add_book(Book.new("1984", "George Orwell", 1949))
  library.add_book(Book.new("To Kill a Mockingbird", "Harper Lee", 1960))
  
  puts "Listing books in the library:"
  library.list_books
  
  library.save_to_file("library.txt")
  
  puts "\nRemoving '1984' from the library."
  library.remove_book("1984")
  
  puts "\nListing books in the library after removal:"
  library.list_books
  
  puts "\nLoading books from file."
  library.load_from_file("library.txt")
  
  puts "\nListing books in the library after loading from file:"
  library.list_books  