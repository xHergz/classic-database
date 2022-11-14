from urllib.request import urlopen, Request
from bs4 import BeautifulSoup

classic_cookie = "__cfduid=d58250aa6a5c6ac7724145d25e47ebd451561749569; _ga=GA1.2.321784818.1561749569; _gid=GA1.2.2023892471.1564446449; PHPSESSID=p5uqsre7f31vbpgtdt0j7u8epe; _gat_gtag_UA_138690065_1=1"

maps_url = "https://armory.aruarose.com/maps/"
map_ids = ["1", "2"]

for map in map_ids:
    drop_data = []
    map_page = urlopen(Request(maps_url + map, headers={'User-Agent': 'Mozilla', "Cookie": classic_cookie}))
    map_soup = BeautifulSoup(map_page, features="html.parser")
    map_table = map_soup.find("table")
    map_rows = map_table.find("tbody").find_all("tr")
    
    for map_row in map_rows:
        map_anchor = map_row.find("a")
        map_id = map_anchor["href"].rsplit('/')[-2]
               
        url = "https://armory.aruarose.com/map/" + map_id
        page = urlopen(Request(url, headers={'User-Agent': 'Mozilla', "Cookie": classic_cookie}))
        soup = BeautifulSoup(page, features="html.parser")
        map_name = soup.find("h2").get_text()
        drop_data.append("-- " + map_name)
        all_tables = soup.find_all("table")
        drop_rows = all_tables[-1].find("tbody").find_all("tr")
        for row in drop_rows:
            anchor = row.find("a")
            try:
                item_id = anchor["rel"][0].rsplit('/', 1)[-1]
                insert_row = "(" + map_id + ", " + item_id + "),"
            except:
                insert_row = "-- No Drops"
            # print(insert_row)
            drop_data.append(insert_row)
            
    with open('MapDropData.txt', 'a') as f:
        for item in drop_data:
            f.write("%s\n" % item)
