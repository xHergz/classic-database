CREATE TABLE Monster_Drop
(
    Monster_Id INT NOT NULL,
    Item_Id INT NOT NULL,
    FOREIGN KEY(Monster_Id) REFERENCES Monster(Monster_Id),
    FOREIGN KEY(Item_Id) REFERENCES Item(Item_Id)
);
