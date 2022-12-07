class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    @show_book = Book.find(params[:book_id])
    @book_comment = BookComment.new
    # redirect_to book_path(book) #非同期のためにコメントアウト。これでjsファイルを探してくれる
  end

  def destroy
    @show_book = Book.find(params[:book_id])
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    @book_comment = BookComment.new
    # BookComment.find(params[:id]).destroy
    # redirect_to book_path(book_comment.book_id) #非同期のためにコメントアウト。これでjsファイルを探してくれる
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
