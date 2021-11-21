class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    unless @genre.save
      render :index
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "内容を更新しました"
    else
      flash[:alert] = "変更内容に不備があります"
      render edit_admin_genre_path
    end
  end

private

def genre_params
  params.require(:genre).permit(:name)
end

end
