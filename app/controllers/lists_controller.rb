class ListsController < ApplicationController
  before_action :authenticate_user!

  require "open-uri"
  require "json"

  TMDB_SEARCH_URL = "https://tmdb.lewagon.com/search/movie"

  def index
    @lists = current_user.lists
  end

  def show
    @list = current_user.lists.find(params[:id])
    @movies = params[:query].present? ? search_movies(params[:query]) : []
  end

  def new
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.new(list_params)
    if @list.save
      redirect_to @list
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :image_url)
  end

  def search_movies(query)
    url = "#{TMDB_SEARCH_URL}?query=#{CGI.escape(query)}"
    results = JSON.parse(URI.open(url).read)["results"]

    results.map do |movie|
      Movie.find_or_create_by!(title: movie["title"]) do |m|
        m.overview = movie["overview"]
        m.poster_url = "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}"
        m.rating = movie["vote_average"]
      end
    end
  rescue OpenURI::HTTPError, SocketError, JSON::ParserError
    Movie.where("title ILIKE ?", "%#{query}%")
  end
end
