from urllib.request import urlopen, Request
from bs4 import BeautifulSoup

classic_cookie = "PHPSESSID=1rbpip1te6ud0pc08dkctj8t7f"

base_url = "https://armory.aruarose.com/items/"

def getTypeStr(typeId):
  match typeId:
    case 1:
      return 'hat'
    case 2:
      return 'casualClothes'
    case 3:
      return 'gloves'
    case 4:
      return 'shoes'
    case 5:
      return 'helmet'
    case 6:
      return 'combatUniforms'
    case 7:
      return 'gauntlets'
    case 8:
      return 'boots'
    case 9:
      return 'magicHat'
    case 10:
      return 'magicClothes'
    case 11:
      return 'magicGloves'
    case 12:
      return 'magicBoots'
    case _:
      return 'unknown'

class Item:
  def __init__(self, id, name, typeId, iconId):
    self.id = id
    self.name = name
    self.type = typeId
    self.iconId = iconId
  
  def to_sql_str(self):
    return "(" + str(self.id) + ", " + str(self.type) + ", '" + self.name + "'), -- " + self.iconId

  def to_json_obj(self):
    return "{ id: " + str(self.id) + ", name: \"" + self.name + "\", icon_id: " + str(self.iconId) + ", type: \"equipment\", classification: \"" + getTypeStr(self.type) + "\", group: \"\" },"

class ItemGroup:
  def __init__(self, url, typeId):
    self.url = url
    self.type = typeId

  def getUrl(self):
    return base_url + self.url

armor_groups = [
  ItemGroup('hat/Hat', 1),
  ItemGroup('body/Casual%20Clothes', 2),
  ItemGroup('gloves/Gloves', 3),
  ItemGroup('boots/Shoes', 4),
  ItemGroup('hat/Helmet', 5),
  ItemGroup('body/Combat%20Uniform', 6),
  ItemGroup('gloves/Gauntlets', 7),
  ItemGroup('boots/Boots', 8),
  ItemGroup('hat/Magic%20Hat', 9),
  ItemGroup('body/Magic%20Clothes', 10),
  ItemGroup('gloves/Magic%20Gloves', 11),
  ItemGroup('boots/Magic%20Boots', 12),
]

final_data = []

for group in armor_groups:
    page = urlopen(Request(group.getUrl(), headers={'User-Agent': 'Mozilla', "Cookie": classic_cookie}))
    print(group.getUrl())
    soup = BeautifulSoup(page, features="html.parser")
    table = soup.find("table")
    rows = table.find("tbody").find_all("tr")

    for row in rows:
        image = row.find("img")
        anchors = row.findAll("a")
        id = anchors[1]["href"].rsplit('/')[-2]
        name = anchors[1].text
        icon = image["src"].rsplit('/')[-1]
               
        final_data.append(Item(id, name, group.type, icon))

with open('ArmorData_sql.txt', 'a') as f:
    for item in final_data:
        f.write("%s\n" % item.to_sql_str())

with open('ArmorData_json.txt', 'a') as f:
    for item in final_data:
        f.write("%s\n" % item.to_json_obj())
