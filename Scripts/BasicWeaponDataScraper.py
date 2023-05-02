from urllib.request import urlopen, Request
from bs4 import BeautifulSoup

classic_cookie = "PHPSESSID=1rbpip1te6ud0pc08dkctj8t7f"

base_url = "https://armory.aruarose.com/items/"

def getTypeStr(typeId):
  match typeId:
    case 21:
      return 'blunts'
    case 22:
      return 'oneHandedSwords'
    case 23:
      return 'axes'
    case 24:
      return 'duals'
    case 25:
      return 'glaives'
    case 26:
      return 'katars'
    case 27:
      return 'spears'
    case 28:
      return 'twoHandedSwords'
    case 29:
      return 'staffs'
    case 30:
      return 'wands'
    case 31:
      return 'bows'
    case 32:
      return 'crossbows'
    case 33:
      return 'guns'
    case 34:
      return 'launchers'
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
    return "{ id: " + str(self.id) + ", name: \"" + self.name + "\", icon_id: " + str(self.iconId) + ", type: \"equipment\", classification: \"" + getTypeStr(self.type) + "\", group: \"weapons\" },"

class ItemGroup:
  def __init__(self, url, typeId):
    self.url = url
    self.type = typeId

  def getUrl(self):
    return base_url + self.url

armor_groups = [
  ItemGroup('weapon/One-Handed%20Blunt%20Weapon', 21),
  ItemGroup('weapon/One-Handed%20Sword', 22),
  ItemGroup('weapon/Two-Handed%20Axe', 23),
  ItemGroup('weapon/Dual%20Swords', 24),
  ItemGroup('weapon/Katar', 26),
  ItemGroup('weapon/Spear', 27),
  ItemGroup('weapon/Two-Handed%20Sword', 28),
  ItemGroup('weapon/Magic%20Staff', 29),
  ItemGroup('weapon/Magic%20Wand', 30),
  ItemGroup('weapon/Bow', 31),
  ItemGroup('weapon/Crossbow', 32),
  ItemGroup('weapon/Gun', 33),
  ItemGroup('weapon/Launcher', 34),
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

with open('WeaponData_sql.txt', 'a') as f:
    for item in final_data:
        f.write("%s\n" % item.to_sql_str())

with open('WeaponData_json.txt', 'a') as f:
    for item in final_data:
        f.write("%s\n" % item.to_json_obj())
