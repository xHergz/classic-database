DELIMITER $$
-- Selects and arranges all the dealer armor to be analyzed
CREATE PROCEDURE DealerArmorAudit
()
BEGIN
    DECLARE DEALER_JOB_ID INT DEFAULT 1;

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
        Job_Id = DEALER_JOB_ID
    ORDER BY
        Item_Type_Id,
        Level;
END
$$
DELIMITER ;