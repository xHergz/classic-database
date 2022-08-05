DELIMITER $$
-- Selects and arranges all the bags to be analyzed
CREATE PROCEDURE BagAudit
()
BEGIN
    DECLARE BAG_TYPE_ID INT DEFAULT 17;

    SELECT
        Item_Id,
        Item_Name,
        Item_Type_Id,
        Item_Type_Description,
        Level,
        Defence,
        Magic_Resistance,
        CalculateDefenceDifference(Item_Id, Item_Type_Id, Job_Id, Level) AS Def_Diff,
        CalculateMagicResistanceDifference(Item_Id, Item_Type_Id, Job_Id, Level) AS MRes_Diff
    FROM
        Armor_Info
    WHERE
        Item_Type_Id = BAG_TYPE_ID
    ORDER BY
        Item_Type_Id,
        Level;
END
$$
DELIMITER ;
