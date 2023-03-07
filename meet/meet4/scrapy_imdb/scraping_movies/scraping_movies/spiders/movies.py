import scrapy


class MoviesSpider(scrapy.Spider):
    name = "movies"
    allowed_domains = ["www.imdb.com"]
    start_urls = ["https://www.imdb.com/chart/top/"]

    def parse(self, response):
        movies = response.css("table tbody tr")
        for movie in movies:
            judul = movie.css("td.titleColumn a::text").get()
            aktor = movie.css("td.titleColumn a::attr(title)").get()
            rating = movie.css("td.ratingColumn a::text").get()
            poster = movie.css("td.posterColumn a img::attr(src)").get()
            yield {
                'judul': judul,
                'aktor': aktor,
                'rating': rating,
                'poster': poster
            }
