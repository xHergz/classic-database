DELIMITER $$
-- Calculate the defence difference between an item and its assumed previous piece.
-- For example, if you pass in level 30 dealer gloves it will find the dealer gloves
-- that come before the them to compare with.
CREATE FUNCTION CalculateDefenceDifference
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
    DECLARE currentItemDefence INT;
    DECLARE previousItemDefence INT;

    SELECT
        Armor.Defence
    INTO
        currentItemDefence
    FROM
        Armor
    WHERE
        Armor.Item_Id = _itemId;

    SELECT
        Armor.Defence
    INTO
        previousItemDefence
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

    IF (previousItemDefence IS NULL OR currentItemDefence IS NULL) THEN
        RETURN NULL;
    END IF;

    RETURN currentItemDefence - previousItemDefence;
END
$$
DELIMITER ;