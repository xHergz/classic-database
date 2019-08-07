CREATE VIEW Monster_Drop_Info
AS
SELECT
	Item.Item_Id,
    Item.Name AS Item_Name,
    Item_Type.Item_Type_Id,
    Item_Type.Description AS Item_Type_Description,
    Monster.Monster_Id,
    Monster.Name AS Monster_Name,
    Monster.Level AS Monster_Level,
    Monster_Type.Monster_Type_Id,
    Monster_Type.Description AS Monster_Type_Description
FROM
	Item
    INNER JOIN Item_Type ON Item_Type.Item_Type_Id = Item.Item_Type_Id
    INNER JOIN Monster_Drop ON Monster_Drop.Item_Id = Item.Item_Id
    INNER JOIN Monster ON Monster.Monster_Id = Monster_Drop.Monster_Id
    INNER JOIN Monster_Type ON Monster_Type.Monster_Type_Id = Monster.Monster_Type_Id;
