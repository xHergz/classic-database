DELIMITER $$
-- Selects and arranges all the soldier armor to be analyzed
CREATE PROCEDURE SoldierArmorAudit
()
BEGIN
    DECLARE SOLDIER_JOB_ID INT DEFAULT 4;

    SELECT
        Item_Id,
        Item_Name,
        Item_Type_Id,
        Item_Type_Description,
        Job_Id,
        Job_Name,
        Level,
        Defence,
        Magic_Resistance,
        CalculateDefenceDifference(Item_Id, Item_Type_Id, Job_Id, Level) AS Def_Diff,
        CalculateMagicResistanceDifference(Item_Id, Item_Type_Id, Job_Id, Level) AS MRes_Diff
    FROM
        Armor_Info
    WHERE
        Job_Id = SOLDIER_JOB_ID
    ORDER BY
        Item_Type_Id,
        Level;
END
$$
DELIMITER ;