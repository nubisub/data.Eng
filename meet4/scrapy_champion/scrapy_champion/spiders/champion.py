import scrapy


class ChampionSpider(scrapy.Spider):
    name = "champion"
    allowed_domains = ["www.footballdatabase.eu"]
    start_urls = ["https://www.footballdatabase.eu/en/competition/overall/16606-ligue_des_champions/2022-2023"]

    def parse(self, response):
        table = response.xpath('/html/body/main/div[14]/div/table')
        rows = table.xpath('.//tr')
        for row in rows:
            pic = row.xpath('.//td[1]/span/img/@src').get()
            Team = row.xpath('.//td[2]/text()').get()
            Team = str(Team)
            Team = Team.strip()
            avgAge = row.xpath('.//td[3]/text()').get()
            oldestPlayerAge = row.xpath('.//td[4]/span/text()').get()
            youngestPlayerAge = row.xpath('.//td[5]/span/text()').get()
            yield {
                "TeamLogo" : pic,
                "Team": Team,
                "avgAge": avgAge,
                "oldestPlayerAge": oldestPlayerAge,
                "youngestPlayerAge": youngestPlayerAge,
            }


