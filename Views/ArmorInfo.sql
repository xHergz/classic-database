CREATE VIEW Armor_Info
AS
SELECT
	Item.Item_Id,
    Item.Name AS Item_Name,
    Item_Type.Item_Type_Id,
    Item_Type.Description AS Item_Type_Description,
    Job.Job_Id,
    Job.Name AS Job_Name,
    Armor.Level,
    Armor.Defence,
    Armor.Magic_Resistance
FROM
	Item
    INNER JOIN Item_Type ON Item_Type.Item_Type_Id = Item.Item_Type_Id
    INNER JOIN Armor ON Armor.Item_Id = Item.Item_Id
    LEFT JOIN Job ON Job.Job_Id = Armor.Job_Id;
