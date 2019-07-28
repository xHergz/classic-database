CREATE TABLE Monster
(
    Monster_Id INT NOT NULL,
    Monster_Type_Id INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Level INT NOT NULL,
    PRIMARY KEY(Monster_Id),
    FOREIGN KEY(Monster_Type_Id) REFERENCES Planet(Monster_Type_Id)
);
