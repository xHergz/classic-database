from urllib.request import urlopen, Request
from bs4 import BeautifulSoup

while True:
    monster_id = input("Monster Id: ")

    url = "https://armory.aruarose.com/monster/" + monster_id

    page = urlopen(Request(url, headers={'User-Agent': 'Mozilla'}))

    soup = BeautifulSoup(page, features="html.parser")

    monster_name = soup.find("h2").get_text()
    all_tables = soup.find_all("table")
    drop_rows = all_tables[-1].find("tbody").find_all("tr")
    print("-- " + monster_name)
    for row in drop_rows:
        anchor = row.find("a")
        item_id = anchor["rel"][0].rsplit('/', 1)[-1]
        print("(" + monster_id + ", " + item_id + "),")

