import java.io.File
import java.io.IOException

// Define a class to represent a Book
data class Book(val title: String, val author: String, val year: Int)

// Define a class to manage a Library of books
class Library {
    private val books = mutableListOf<Book>()

    fun addBook(book: Book) {
        books.add(book)
    }

    fun removeBook(title: String) {
        books.removeIf { it.title == title }
    }

    fun listBooks() {
        books.forEach { println(it) }
    }

    fun saveToFile(filename: String) {
        try {
            File(filename).printWriter().use { out ->
                books.forEach { book ->
                    out.println("${book.title},${book.author},${book.year}")
                }
            }
        } catch (e: IOException) {
            println("An error occurred while saving to file: ${e.message}")
        }
    }

    fun loadFromFile(filename: String) {
        try {
            if (!File(filename).exists()) return

            File(filename).forEachLine { line ->
                val (title, author, year) = line.split(",")
                addBook(Book(title, author, year.toInt()))
            }
        } catch (e: IOException) {
            println("An error occurred while loading from file: ${e.message}")
        }
    }
}

// Example usage
fun main() {
    val library = Library()
    library.addBook(Book("The Great Gatsby", "F. Scott Fitzgerald", 1925))
    library.addBook(Book("1984", "George Orwell", 1949))
    library.addBook(Book("To Kill a Mockingbird", "Harper Lee", 1960))

    println("Listing books in the library:")
    library.listBooks()

    library.saveToFile("library.txt")

    println("\nRemoving '1984' from the library.")
    library.removeBook("1984")

    println("\nListing books in the library after removal:")
    library.listBooks()

    println("\nLoading books from file.")
    library.loadFromFile("library.txt")

    println("\nListing books in the library after loading from file:")
    library.listBooks()
}
