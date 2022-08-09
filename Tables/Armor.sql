CREATE TABLE Armor
(
    Armor_Id INT AUTO_INCREMENT,
    Item_Id INT NOT NULL,
    Job_Id INT DEFAULT NULL,
    Level INT NOT NULL,
    Defence INT NOT NULL,
    Magic_Resistance INT NOT NULL,
    PRIMARY KEY (Armor_Id),
    FOREIGN KEY (Item_Id) REFERENCES Item(Item_Id),
    FOREIGN KEY (Job_Id) REFERENCES Job(Job_Id)
);
