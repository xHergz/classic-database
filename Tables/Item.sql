CREATE TABLE Item
(
    Item_Id INT NOT NULL,
    Item_Type_Id INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    PRIMARY KEY(Item_Id),
    FOREIGN KEY(Item_Type_Id) REFERENCES Item_Type(Item_Type_Id)
);
