class MoviesController < ApplicationController

  def index
    @movies = Movie.all.order(title: :asc)
  end

  def show
    @movie = Movie.find(params["id"])
  end

  def refresh
    Movie.delete_all
    Credit.delete_all
    require 'uri'
    require 'net/http'
    pages = 1
    page = 0
    while page < pages
      url = URI("https://api.themoviedb.org/3/movie/now_playing?region=GR&page=#{page+1}&language=en-US&api_key=dbabba689658292c5846c5510e4cab1c")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request.body = "{}"

      response = http.request(request)
      json = JSON.parse(response.body)
      if json["results"]
        pages = json["total_pages"]
        json["results"].each do |movie|
          title = movie["title"]
          description = movie["overview"]
          original = movie["original_title"]
          id = movie["id"]
          movie = Movie.new(title: title, description: description, original_title: original)
          if movie.save
            url = URI("https://api.themoviedb.org/3/movie/#{id}/credits?api_key=dbabba689658292c5846c5510e4cab1c")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE

            request = Net::HTTP::Get.new(url)
            request.body = "{}"

            response = http.request(request)
            jsonify = JSON.parse(response.body)
            jsonify["crew"].each do |person|
              if person["job"] == "Director"
                id = person["id"]
                director = Director.new(name: person["name"])
                if director.save
                  url = URI("https://api.themoviedb.org/3/person/%7Bperson_id%7D?language=en-US&api_key=dbabba689658292c5846c5510e4cab1c")

                  http = Net::HTTP.new(url.host, url.port)
                  http.use_ssl = true
                  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

                  request = Net::HTTP::Get.new(url)
                  request.body = "{}"

                  response = http.request(request)
                  jsoned = JSON.parse(response.body)
                  imdb = jsoned["imdb"]
                  director.imdb = imdb
                  director.save
                end
                director = Director.find_by(name: person["name"])
                Credit.create(director_id: director.id, movie_id: movie.id)
              end
            end
          end
        end
      else
        redirect_to '/movies/refresh' and return
      end
      page += 1
    end
    redirect_to '/'
  end
end
