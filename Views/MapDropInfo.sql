CREATE VIEW Map_Drop_Info
AS
SELECT
	Item.Item_Id,
    Item.Name AS Item_Name,
    Item_Type.Item_Type_Id,
    Item_Type.Description AS Item_Type_Description,
    Map.Map_Id,
    Map.Name AS Map_Name,
    Planet.Planet_Id,
    Planet.Name AS Planet_Name
FROM
	Item
    INNER JOIN Item_Type ON Item_Type.Item_Type_Id = Item.Item_Type_Id
    INNER JOIN Map_Drop ON Map_Drop.Item_Id = Item.Item_Id
    INNER JOIN Map ON Map.Map_Id = Map_Drop.Map_Id
    INNER JOIN Planet ON Planet.Planet_Id = Map.Planet_Id;
