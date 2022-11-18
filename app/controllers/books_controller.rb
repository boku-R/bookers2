class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    @book.save
    # books#showにリダイレクトしないといけない
    redirect_to user_path(current_user.id)
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
    # ここに、画像も許可する記述が必要
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

end
