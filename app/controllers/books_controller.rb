class BooksController < ApplicationController
  # 他の人が自分のユーザ情報をいじれないようにする
  before_action :is_matching_login_user, only: [:edit,:update]

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    # バリデーションを実装
    if @book.save
      # フラッシュメッセージを設定
      flash[:notice] = "You have created book successfully."
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
      # フラッシュメッセージを設定
      flash[:notice] = "You have update book successfully."
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
    @book = Book.new
    @show_book = Book.find(params[:id])
    # showにおける本の感想を書いたuserの情報を出したい
    @user = User.find(@show_book.user_id)
    @book_comment = BookComment.new

    # のちのちのための記述。userコントローラのshowにて記述
    # @user = current_user
    # @books = @user.books
  end


  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title,:body,:star)
  end

  def user_params
    # 【済】ここに、画像も許可する記述が必要
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  # 他の人が自分の投稿内容をいじれないようにする
  def is_matching_login_user
    book_user_id = Book.find(params[:id]).user.id.to_i
    login_user_id = current_user.id
    if(book_user_id != login_user_id)
      redirect_to books_path
    end
  end

end
