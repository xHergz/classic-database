CREATE TABLE Map_Drop
(
    Map_Id INT NOT NULL,
    Item_Id INT NOT NULL,
    FOREIGN KEY (Map_Id) REFERENCES Map(Map_Id),
    FOREIGN KEY (Item_Id) REFERENCES Item(Item_Id)
);