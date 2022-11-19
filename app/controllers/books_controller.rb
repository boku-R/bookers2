class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    @book.save
    # 【済】books#showにリダイレクトしないといけない
    redirect_to book_path(@book.id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end

  def index
    @new_book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
  end


  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def user_params
    # 【済】ここに、画像も許可する記述が必要
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

end
