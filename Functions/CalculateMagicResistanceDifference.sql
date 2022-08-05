DELIMITER $$
-- Calculate the Magic Resistance difference between an item and its assumed previous piece.
-- For example, if you pass in level 30 dealer gloves it will find the dealer gloves
-- that come before the them to compare with.
CREATE FUNCTION CalculateMagicResistanceDifference
(
	_itemId INT,
    _itemTypeId INT,
    _jobId INT,
    _level INT
)
RETURNS INT
READS SQL DATA
NOT DETERMINISTIC
BEGIN
    DECLARE currentItemMagicResistance INT;
    DECLARE previousItemMagicResistance INT;

    SELECT
        Armor.Magic_Resistance
    INTO
        currentItemMagicResistance
    FROM
        Armor
    WHERE
        Armor.Item_Id = _itemId;

    SELECT
        Armor.Magic_Resistance
    INTO
        previousItemMagicResistance
    FROM
        Armor
        INNER JOIN Item ON Item.Item_Id = Armor.Item_Id
    WHERE
        Item.Item_Type_Id = _itemTypeId
        AND (
            Armor.Job_Id = _jobId
            OR (_jobId IS NULL AND Armor.Job_Id IS NULL)
        )
        AND Armor.Level < _level
    ORDER BY
        Armor.Level DESC
    LIMIT 
        1;

    IF (previousItemMagicResistance IS NULL OR currentItemMagicResistance IS NULL) THEN
        RETURN NULL;
    END IF;

    RETURN currentItemMagicResistance - previousItemMagicResistance;
END
$$
DELIMITER ;