class BookFilterService
    def initialize(params)
      @params = params
    end
  
    def call
      books = Book.all
      books = filter_by_name(books)
      books = filter_by_author(books)
      books = filter_by_categories(books)
      books = filter_by_shelf(books)
      books = sort_books(books)
      books.page(@params[:page_number]).per(@params[:page_size])
    end
  
    private
  
    def filter_by_name(books)
      return books unless @params[:name].present?
  
      books.where("title #{case_insensitive_like_operator} ?", "%#{@params[:name]}%")
    end
  
    def filter_by_author(books)
      return books unless @params[:author].present?
  
      books.where("author #{case_insensitive_like_operator} ?", "%#{@params[:author]}%")
    end
  
    def filter_by_categories(books)
      return books unless @params[:category_names].present?
  
      category_names = @params[:category_names].split(',').map(&:strip)
      books = books.joins(:categories)
      books = books.where(category_names.map { |name| "categories.name #{case_insensitive_like_operator} ?" }.join(' OR '), *category_names.map { |name| "%#{name}%" }).distinct
    end
  
    def filter_by_shelf(books)
      return books unless @params[:shelf_name].present?
  
      books.joins(:shelf).where("shelves.name #{case_insensitive_like_operator} ?", "%#{@params[:shelf_name]}%")
    end
  
    def sort_books(books)
      case @params[:sort]
      when 'highest_rated'
        books.where.not(rating: nil).order(rating: :desc)
      when 'lowest_rated'
        books.where.not(rating: nil).order(rating: :asc)
      else
        books
      end
    end
  
    def case_insensitive_like_operator
      if ActiveRecord::Base.connection.adapter_name.downcase.to_sym == :sqlite
        'LIKE'
      else
        'ILIKE'
      end
    end
  end
  