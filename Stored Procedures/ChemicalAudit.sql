DELIMITER $$
-- Selects and arranges all the chemicals to be analyzed
CREATE PROCEDURE ChemicalAudit
()
BEGIN
    DECLARE CHEMICAL_ITEM_TYPE_ID INT DEFAULT 55;

    SELECT
        Item_Id,
        Item_Name,
        Item_Type_Id,
        Item_Type_Description,
        Monster_Id,
        Monster_Name,
        Monster_Level,
        Monster_Type_Id,
        Monster_Type_Description
    FROM
        Monster_Drop_Info
    WHERE
        Item_Type_Id = CHEMICAL_ITEM_TYPE_ID
    ORDER BY
        Item_Id,
        Monster_Level;

    SELECT
        Item_Id,
        Item_Name,
        Item_Type_Id,
        Item_Type_Description,
        Map_Id,
        Map_Name,
        Planet_Id,
        Planet_Name
    FROM
        Map_Drop_Info
    WHERE
        Item_Type_Id = CHEMICAL_ITEM_TYPE_ID
    ORDER BY
        Item_Id,
        Map_Id,
        Planet_Id;

END
$$
DELIMITER ;
