class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  def show
    @book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end
  
  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
     flash[:notice] = "create book succsessfully"
     redirect_to book_path(@book)
   else
     render :index
   end 
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to book_path
    end 
  end
  
  def update
    @book = Book.find(params[:id])
    @book.user.id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "update succsessfully"
      redirect_to book_path
    end 
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end