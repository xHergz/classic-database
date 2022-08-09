CREATE TABLE Weapon
(
    Weapon_Id INT AUTO_INCREMENT,
    Item_Id INT NOT NULL,
    Level INT NOT NULL,
    Attack_Power INT NOT NULL,
    Attack_Speed INT NOT NULL,
    PRIMARY KEY (Weapon_Id),
    FOREIGN KEY (Item_Id) REFERENCES Item(Item_Id)
);
