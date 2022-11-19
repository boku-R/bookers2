class BooksController < ApplicationController
  # 他の人が自分のユーザ情報をいじれないようにする
  before_action :is_matching_login_user, only: [:edit,:update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    # バリデーションを実装
    if @book.save
      # 【済】books#showにリダイレクトしないといけない
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy #レコード削除
    redirect_to books_path
  end

  def index
    @book = Book.new
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

  # 他の人が自分の投稿内容をいじれないようにする
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end

end
