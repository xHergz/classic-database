from urllib.request import urlopen, Request
from bs4 import BeautifulSoup

classic_cookie = "PHPSESSID=jsi73n04q8v2hmneps6lhps2ae"

etc_url = "https://armory.aruarose.com/items/material/"
gems_url = "https://armory.aruarose.com/items/gems/"
etc_groups = ["Gems", "Chemicals", "Cloth", "Gathered%20Goods", "Leather", "Material", "Metal", "Otherworldly%20Metal", "Refining%20Material", "Stone%20Material", "Wooden%20Material"]
etc_types = [54, 55, 56, 57, 58, 59, 60, 62, 63, 64, 65]

etc_data = []
type_index = 0

for group in etc_groups:
    match group:
        case "Gems":
            base_url = gems_url
        case _:
            base_url = etc_url
    etc_page = urlopen(Request(base_url + group, headers={'User-Agent': 'Mozilla', "Cookie": classic_cookie}))
    print(base_url + group)
    etc_soup = BeautifulSoup(etc_page, features="html.parser")
    etc_table = etc_soup.find("table")
    etc_rows = etc_table.find("tbody").find_all("tr")

    etc_data.append("-- " + group)
    for row in etc_rows:
        image = row.find("img")
        anchors = row.findAll("a")
        id = anchors[1]["href"].rsplit('/')[-2]
        name = anchors[1].text
        icon = image["src"].rsplit('/')[-1]
               
        etc_data.append("(" + id + ", " + str(etc_types[type_index]) + ", '" + name + "'), -- " + icon)

with open('EtcData.txt', 'a') as f:
    for item in etc_data:
        f.write("%s\n" % item)
