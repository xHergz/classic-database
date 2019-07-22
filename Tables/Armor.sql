CREATE TABLE Armor
(
    Armor_Id INT AUTO_INCREMENT,
    Item_Id INT NOT NULL,
    Level INT NOT NULL,
    Defense INT NOT NULL,
    Magic_Resistance INT NOT NULL,
    PRIMARY KEY(Armor_Id),
    FOREIGN KEY(Item_Id) REFERENCES Item(Item_Id)
);
