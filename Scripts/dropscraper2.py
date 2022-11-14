from urllib.request import urlopen, Request
from bs4 import BeautifulSoup

#page = urlopen(Request("https://armory.aruarose.com/server/1", headers={'User-Agent': 'Mozilla', "Cookie": "9q7l8p9up9ni111n016g29fc3v"}))

monster_url = "https://armory.aruarose.com/monsters/"
monster_ranges = ["1-20", "21-40", "41-60", "61-80", "81-100", "101-120", "121-140", "141-999"]

for range in monster_ranges:
    drop_data = []
    monster_page = urlopen(Request(monster_url + range, headers={'User-Agent': 'Mozilla', "Cookie": "__cfduid=d58250aa6a5c6ac7724145d25e47ebd451561749569; _ga=GA1.2.321784818.1561749569; _gid=GA1.2.2023892471.1564446449; PHPSESSID=t0keomqiep8f0ppkr867l96p63"}))
    monster_soup = BeautifulSoup(monster_page, features="html.parser")
    monster_table = monster_soup.find("table")
    monster_rows = monster_table.find("tbody").find_all("tr")
    
    for monster_row in monster_rows:
        monster_anchor = monster_row.find("a")
        monster_id = monster_anchor["href"].rsplit('/')[-2]
        # print(monster_id)
        
        url = "https://armory.aruarose.com/monster/" + monster_id
        page = urlopen(Request(url, headers={'User-Agent': 'Mozilla', "Cookie": "__cfduid=d58250aa6a5c6ac7724145d25e47ebd451561749569; _ga=GA1.2.321784818.1561749569; _gid=GA1.2.2023892471.1564446449; PHPSESSID=t0keomqiep8f0ppkr867l96p63"}))
        soup = BeautifulSoup(page, features="html.parser")
        monster_name = soup.find("h2").get_text()
        drop_data.append("-- " + monster_name)
        all_tables = soup.find_all("table")
        drop_rows = all_tables[-1].find("tbody").find_all("tr")
        for row in drop_rows:
            anchor = row.find("a")
            try:
                item_id = anchor["rel"][0].rsplit('/', 1)[-1]
                insert_row = "(" + monster_id + ", " + item_id + "),"
            except:
                insert_row = "-- No Drops"
            # print(insert_row)
            drop_data.append(insert_row)
            
    with open('data.txt', 'a') as f:
        for item in drop_data:
            f.write("%s\n" % item)

"""
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

"""